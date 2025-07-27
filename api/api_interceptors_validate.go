package api

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	"google.golang.org/protobuf/reflect/protoreflect"
)

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
