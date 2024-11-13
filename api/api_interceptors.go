package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	"github.com/darwishdev/devkit-api/pkg/auth"
	"github.com/darwishdev/devkit-api/pkg/contextkeys"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/iancoleman/strcase"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
	"os"
	"strings"
	"time"
)

type contextKey string

const callerIDKey = contextKey("callerID")

func (s *Server) proccessProcedureName(procName string) (string, string) {
	procParts := strings.Split(procName, "/")
	procedureName := strings.TrimLeft(procParts[len(procParts)-1], "Input")
	functionNameSnake := strcase.ToSnake(procedureName)
	functionNameParts := strings.Split(functionNameSnake, "_")
	group := functionNameParts[0]

	return procedureName, group
}

// this function should handle the create update request and chech for the record id on the request to pass either [create , update]
// ass permission variation
func (s *Server) createUpdateMethodPermissionName(msgReflect protoreflect.Message, group string) string {
	recordIdKey := "record_id"
	permissionName := fmt.Sprintf("%s_create", group)
	field := msgReflect.Descriptor().Fields().ByName(protoreflect.Name(recordIdKey))
	if field == nil {
		recordIdKey = fmt.Sprintf("%s_id", group)
		field = msgReflect.Descriptor().Fields().ByName(protoreflect.Name(recordIdKey))
		if field == nil {
			return permissionName
		}
	}
	if msgReflect.Has(field) {
		recordIDValue := msgReflect.Get(field)
		recordID := recordIDValue.Int() // assuming role_id is an int32 or int64 field
		if recordID > 0 {
			permissionName = fmt.Sprintf("%s_update", group)
		}
	}
	return strcase.ToCamel(permissionName)
}

// checkRecordID checks if a connect.AnyRequest contains a field named "recordId"
// (or a dynamically generated group-based field) with a value greater than zero.
func (s *Server) authorize(req connect.AnyRequest) (*auth.Payload, error) {
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
func (s *Server) NewAuthenticationInterceptor() connect.UnaryInterceptorFunc {
	interceptor := func(next connect.UnaryFunc) connect.UnaryFunc {
		return connect.UnaryFunc(func(
			ctx context.Context,
			req connect.AnyRequest,
		) (connect.AnyResponse, error) {
			methodDesc, ok := req.Spec().Schema.(protoreflect.MethodDescriptor)
			if !ok {
				fmt.Errorf("Schema is not a MethodDescriptor")
			}
			// Access the method options
			options := methodDesc.Options()

			if options != nil {
				skipAuth, ok := proto.GetExtension(options, devkitv1.E_SkipAuthentication).(bool)
				if skipAuth && ok {
					return next(ctx, req)
				}
				payload, err := s.authorize(req)
				if err != nil {
					return nil, connect.NewError(connect.CodeUnauthenticated, err)
				}
				// Inject the callerID into the context
				ctx = contextkeys.WithCallerID(ctx, payload.UserId)

				skipAuthorization, ok := proto.GetExtension(options, devkitv1.E_SkipAuthorization).(bool)
				if skipAuthorization && ok {
					return next(ctx, req)
				}

			}
			procedureName, group := s.proccessProcedureName(req.Spec().Procedure)
			isCreateUpdate := strings.Contains(procedureName, "CreateUpdate")
			if isCreateUpdate {
				message, ok := req.Any().(protoreflect.ProtoMessage)
				if !ok {
					return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("request is not a ProtoMessage"))
				}
				procedureName = s.createUpdateMethodPermissionName(message.ProtoReflect(), group)
			}
			ctx = contextkeys.WithPermissionFunction(ctx, procedureName)
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
			permissionFunction, ok := contextkeys.PermissionFunction(ctx)
			if !ok {
				return next(ctx, req)
			}

			log.Debug().Interface("ctex", permissionFunction).Msg("auyiwwwwwwth")
			callerId, ok := contextkeys.CallerID(ctx)
			if !ok {
				return next(ctx, req)
			}
			permissionsMap, err := s.redisClient.AuthSessionFind(ctx, callerId)
			if err != nil {
				permissions, err := s.store.UserPermissionsMap(ctx, callerId)
				if err != nil {
					return nil, connect.NewError(connect.CodeUnauthenticated, err)
				}
				permissionsMap, err = s.redisClient.AuthSessionCreate(ctx, callerId, &permissions)
			}
			_, group := s.proccessProcedureName(req.Spec().Procedure)
			permissionGroup, ok := permissionsMap[group]
			if !ok {
				return nil, connect.NewError(connect.CodePermissionDenied, fmt.Errorf("user does not have the required permission for this group %s", group))
			}
			isPermissionGranted, ok := permissionGroup[permissionFunction]
			if !ok || !isPermissionGranted {
				return nil, connect.NewError(connect.CodePermissionDenied, fmt.Errorf("user does not have the required permission for this permission %s on this group %s", permissionFunction, group))
			}
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
