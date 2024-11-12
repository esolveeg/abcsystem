package api

import (
	"context"
	"fmt"
	"runtime"
	"strings"

	"connectrpc.com/connect"
	apiv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

func getCurrentFuncName() string {
	pc, _, _, ok := runtime.Caller(1) // 1 means we want the caller of getCurrentFuncName
	if !ok {
		return "unknown"
	}
	funcFullName := runtime.FuncForPC(pc).Name()
	funcNameParts := strings.Split(funcFullName, ".")
	funcName := funcNameParts[len(funcNameParts)-1]
	return funcName
}
func (api *Api) RoleList(ctx context.Context, req *connect.Request[apiv1.RoleListRequest]) (*connect.Response[apiv1.RoleListResponse], error) {
	response, err := api.accountsUsecase.RoleList(ctx)
	if err != nil {
		return nil, err
	}
	// response.Options = options
	return connect.NewResponse(response), nil
}

func (api *Api) RoleCreateUpdate(ctx context.Context, req *connect.Request[apiv1.RoleCreateUpdateRequest]) (*connect.Response[apiv1.RoleCreateUpdateResponse], error) {
	// err := api.validator.Validate(req.Msg)
	// if err != nil {
	// 	return nil, connect.NewError(connect.CodeInvalidArgument, err)
	// }
	if req.Msg.GetRoleId() == 0 && req.Msg.GetRoleName() == "" {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("role name is required if role ID not passed (create scenario)"))
	}
	response, err := api.accountsUsecase.RoleCreateUpdate(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(response), nil
}

func (api *Api) RoleDeleteRestore(ctx context.Context, req *connect.Request[apiv1.RoleDeleteRestoreRequest]) (*connect.Response[apiv1.RoleDeleteRestoreResponse], error) {
	_, err := api.checkForAccess(req.Header(), "role", "delete_restore")
	if err != nil {
		return nil, err
	}
	_, err = api.accountsUsecase.RoleDeleteRestore(ctx, req)
	if err != nil {
		return nil, err
	}
	return connect.NewResponse(&apiv1.RoleDeleteRestoreResponse{}), nil
}
