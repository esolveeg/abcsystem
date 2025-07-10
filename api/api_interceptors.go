package api

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"strings"
	"time"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/pkg/auth"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
	"github.com/darwishdev/devkit-api/pkg/headerkeys"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/iancoleman/strcase"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
)

type contextKey string

const callerIDKey = contextKey("callerID")

func (s *Server) InjectRefreshTokenMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if cookie, err := r.Cookie(s.config.RefreshTokenCookieName); err == nil {
			ctx := contextkeys.WithRefreshToken(r.Context(), cookie.Value)
			r = r.WithContext(ctx)
		}

		if cookie, err := r.Cookie(s.config.SupabaseTokenCookieName); err == nil {
			ctx := contextkeys.WithSupabaseToken(r.Context(), cookie.Value)
			r = r.WithContext(ctx)
		}

		if cookie, err := r.Cookie(s.config.SupabaseRefreshTokenCookieName); err == nil {
			ctx := contextkeys.WithSupabaseRefreshToken(r.Context(), cookie.Value)
			r = r.WithContext(ctx)
		}
		next.ServeHTTP(w, r)
	})
}
func (s *Server) proccessProcedureName(procName string) (string, string) {
	procParts := strings.Split(procName, "/")
	procedureName := strings.TrimLeft(procParts[len(procParts)-1], "Input")
	functionNameSnake := strcase.ToSnake(procedureName)
	functionNameParts := strings.Split(functionNameSnake, "_")
	group := functionNameParts[0]
	log.Debug().Interface("err", group).Msg("group")
	return procedureName, group
}

func (s *Server) getFiledFromRequest(msgReflect protoreflect.Message, fieledName string) (*protoreflect.Value, bool) {
	field := msgReflect.Descriptor().Fields().ByName(protoreflect.Name(fieledName))
	if field == nil || !msgReflect.Has(field) {
		return nil, false
	}
	value := msgReflect.Get(field)
	return &value, true
}

// this function should handle the create update request and chech for the record id on the request to pass either [create , update]
// as permission variation
func (s *Server) createUpdateMethodPermissionName(msgReflect protoreflect.Message, group string) string {
	permissionName := strcase.ToCamel(fmt.Sprintf("%s_create", group))
	recordIdValue, ok := s.getFiledFromRequest(msgReflect, "record_id")
	if !ok {
		recordIdValue, ok = s.getFiledFromRequest(msgReflect, fmt.Sprintf("%s_id", group))
		if !ok {
			return permissionName
		}
	}
	recordID := recordIdValue.Int() // assuming role_id is an int32 or int64 field
	if recordID > 0 {
		permissionName = strcase.ToCamel(fmt.Sprintf("%s_update", group))
	}
	return strcase.ToCamel(permissionName)

}
func (s *Server) AuthorizeRequest(req connect.AnyRequest) (*auth.Payload, error) {
	authHeader := req.Header().Get("Authorization")
	if authHeader == "" {
		return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("missing metadata"))
	}
	fields := strings.Fields(authHeader)
	if len(fields) < 2 {
		return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("invalid authorization header format"))
	}

	authType := strings.ToLower(fields[0])
	if authType != "bearer" {
		return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("unsupported authorization type: %s", authType))
	}

	accessToken := fields[1]
	payload, err := s.tokenMaker.VerifyToken(accessToken)
	if err != nil {
		return nil, connect.NewError(connect.CodeUnauthenticated, err)
	}
	return payload, nil
}

// checkRecordID checks if a connect.AnyRequest contains a field named "recordId"
// (or a dynamically generated group-based field) with a value greater than zero.
func (s *Server) NewAuthenticationInterceptor() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
			methodDesc, ok := req.Spec().Schema.(protoreflect.MethodDescriptor)
			if !ok {
				return nil, fmt.Errorf("Schema is not a MethodDescriptor")
			}
			// Access the method options
			options := methodDesc.Options()
			var payload *auth.Payload
			var err error

			procedureName, group := s.proccessProcedureName(req.Spec().Procedure)
			if options != nil {
				skipAuth, ok := proto.GetExtension(options, devkitv1.E_SkipAuthentication).(bool)
				if skipAuth && ok {
					return next(ctx, req)
				}

				permissionGroup, ok := proto.GetExtension(options, devkitv1.E_PermissionGroup).(string)
				if permissionGroup != "" && ok {
					group = permissionGroup
				}

				permissionName, ok := proto.GetExtension(options, devkitv1.E_PermissionName).(string)
				if permissionName != "" && ok {
					procedureName = permissionName
				}
				payload, err = s.AuthorizeRequest(req)

				if err != nil {
					return nil, connect.NewError(connect.CodeUnauthenticated, err)
				}
				session, err := s.redisClient.AuthSessionFind(ctx, payload.UserId, payload.ID.String())
				if err != nil {
					return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("session not stored : %w", err))
				}
				if session.IsBlocked {
					return nil, connect.NewError(connect.CodeUnauthenticated, fmt.Errorf("session is blocked"))
				}
				// Inject the callerID into the context
				ctx = contextkeys.WithCallerID(ctx, payload.UserId)

				skipAuthorization, ok := proto.GetExtension(options, devkitv1.E_SkipAuthorization).(bool)
				if skipAuthorization && ok {
					return next(ctx, req)
				}

			}
			isCreateUpdate := strings.Contains(procedureName, "CreateUpdate")

			ctx = contextkeys.WithiTenantID(ctx, payload.TenantId)
			if isCreateUpdate {
				message, ok := req.Any().(protoreflect.ProtoMessage)
				if !ok {
					return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("request is not a ProtoMessage"))
				}
				procedureName = s.createUpdateMethodPermissionName(message.ProtoReflect(), group)
			}
			ctx = contextkeys.WithPermissionGroup(ctx, group)

			ctx = contextkeys.WithPermissionFunction(ctx, procedureName)
			log.Debug().Interface("err", group).Msg("group")

			headerkeys.WithPermissionGroup(req.Header(), group)
			return next(ctx, req)

		})
	}
	return connect.UnaryInterceptorFunc(interceptor)
}
func (s *Server) NewValidateInterceptor() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
			message, ok := req.Any().(protoreflect.ProtoMessage)
			if !ok {
				return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("request is not a ProtoMessage"))
			}
			err := s.validator.Validate(message)
			if err != nil {
				return nil, connect.NewError(connect.CodeInvalidArgument, err)
			}
			return next(ctx, req)
		})
	}
	return connect.UnaryInterceptorFunc(interceptor)
}
func (s *Server) NewAuthorizationInterceptor() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
			// this ok will be false if endpoint has the skip authorization option

			group, ok := contextkeys.PermissionGroup(ctx)
			if !ok {
				return next(ctx, req)
			}

			permissionFunction, ok := contextkeys.PermissionFunction(ctx)
			if !ok {
				return next(ctx, req)
			}
			// this ok will be false if the user type is not tenant and the logged in user don't have the attribute tenant_id set on the db
			tenantId, ok := contextkeys.TenantID(ctx)
			if ok {

				// here we will check if the logged in user has certain tenant id to return error if he passed diffrent tenant id on the request
				message, ok := req.Any().(protoreflect.ProtoMessage)
				if !ok {
					return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("request is not a ProtoMessage"))
				}
				msgReflect := message.ProtoReflect()
				// get the value of the tenant_id key on the incoming request
				requestTenantIdValue, ok := s.getFiledFromRequest(msgReflect, "tenant_id")
				if ok {
					requestTenantId := requestTenantIdValue.Int()
					if requestTenantId != int64(tenantId) && tenantId > 0 {
						return nil, connect.NewError(connect.CodePermissionDenied, fmt.Errorf("this user attached to TenantId number %d , not allowed to take any actions under another tenant %d", tenantId, requestTenantId))
					}
				}
			}
			permissionGroup, err := s.api.(*Api).CheckForAccess(ctx, permissionFunction, group)
			if err != nil {
				return nil, err
			}
			// permissionsMap, err := s.redisClient.UserPermissionFind(ctx, callerId)
			// if err != nil {
			// 	permissions, err := s.store.UserPermissionsMap(ctx, callerId)
			// 	if err != nil {
			// 		return nil, connect.NewError(connect.CodeUnauthenticated, err)
			// 	}
			// 	for _, rec := range permissions {
			// 		groupPermissions := make(map[string]bool)
			// 		err := json.Unmarshal(rec.Permissions, &groupPermissions)
			// 		if err != nil {
			// 			return nil, err
			// 		}
			// 		permissionsMap[rec.PermissionGroup] = groupPermissions
			// 	}
			//
			// 	err = s.redisClient.UserPermissionCreate(ctx, callerId, &permissionsMap)
			// 	if err != nil {
			// 		return nil, err
			// 	}
			//
			// }
			// permissionGroup, ok := permissionsMap[group]
			// if !ok {
			// 	return nil, connect.NewError(connect.CodePermissionDenied, fmt.Errorf("user does not have the required permission for this group %s", group))
			// }
			// isPermissionGranted, ok := permissionGroup[permissionFunction]
			// if !ok || !isPermissionGranted {
			// 	return nil, connect.NewError(connect.CodePermissionDenied, fmt.Errorf("user does not have the required permission for this permission %s on this group %s", permissionFunction, group))
			// }
			//
			// log.Debug().Interface("local", permissionGroup).Msg("local")
			headerkeys.WithPermittedActions(req.Header(), *permissionGroup)
			return next(ctx, req)
		})
	}
	return connect.UnaryInterceptorFunc(interceptor)
}

func (s *Server) NewLoggerInterceptor() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
			startTime := time.Now()
			result, err := next(ctx, req)
			duration := time.Since(startTime)
			zerolog.TimeFieldFormat = zerolog.TimeFormatUnix
			log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})
			logger := log.Info()
			if s.config.State == "dev" {
				if err != nil {
					logger = log.Error().Err(err)
				}

				logger.
					Str("Procedure", req.Spec().Procedure).
					Interface("request", req.Any()).
					Interface("response", result).
					Dur("duration", duration).
					Msg("received a gRPC request")

			}
			return result, err
		})
	}
	return connect.UnaryInterceptorFunc(interceptor)
}
