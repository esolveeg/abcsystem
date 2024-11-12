package api

import (
	"context"
	"github.com/darwishdev/devkit-api/pkg/auth"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"net/http"
)

func (api *Api) authorizeRequestHeader(header http.Header) (*auth.Payload, error) {
	return nil, nil

}
func (api *Api) authorizedUserPermissions(ctx context.Context, payload *auth.Payload) (redisclient.PermissionsMap, error) {
	return nil, nil

}

func (api *Api) checkForAccess(header http.Header, group string, permission string) (*redisclient.PermissionsMap, error) {
	return nil, nil

}
func (api *Api) getAccessableActionsForGroup(permissionsMap redisclient.PermissionsMap, group string) (*devkitv1.AvailableOptions, error) {
	return nil, nil
}
