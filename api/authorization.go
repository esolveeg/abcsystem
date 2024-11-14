package api

import (
	"context"
	"fmt"
	"net/http"

	"github.com/darwishdev/devkit-api/pkg/auth"
	"github.com/darwishdev/devkit-api/pkg/headerkeys"
	"github.com/darwishdev/devkit-api/pkg/redisclient"
	devkitv1 "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/iancoleman/strcase"
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
func (api *Api) getAvailableOptions(header http.Header) *devkitv1.AvailableOptions {
	var (
		group                        string                     = headerkeys.PermissionGroup(&header)
		findEndpoint                 string                     = strcase.ToLowerCamel(fmt.Sprintf("%s_find_for_update", group))
		findRequestProperty          string                     = "recordId"
		deleteRestoreRequestProperty string                     = "records"
		redirectRoute                string                     = strcase.ToCamel(fmt.Sprintf("%s_list", group))
		update                       string                     = strcase.ToCamel(fmt.Sprintf("%s_update", group))
		create                       string                     = strcase.ToCamel(fmt.Sprintf("%s_create", group))
		deleteKey                    string                     = strcase.ToCamel(fmt.Sprintf("%s_delete", group))
		deleteRestore                string                     = strcase.ToCamel(fmt.Sprintf("%s_delete_restore", group))
		result                       *devkitv1.AvailableOptions = &devkitv1.AvailableOptions{
			Title:       fmt.Sprintf("%s_list", group),
			Description: fmt.Sprintf("%s_list_description", group),
		}
	)

	permittedActions := headerkeys.PermittedActions(&header)
	isCreatePermitted, ok := permittedActions[create]
	if isCreatePermitted && ok {
		result.CreateHandler = &devkitv1.CreateHandler{
			RedirectRoute: redirectRoute,
			Title:         create,
			Endpoint:      strcase.ToLowerCamel(create),
			RouteName:     create,
		}
	}
	isUpdatePermitted, ok := permittedActions[update]
	if isUpdatePermitted && ok {
		result.UpdateHandler = &devkitv1.UpdateHandler{

			RedirectRoute:       redirectRoute,
			Title:               update,
			Endpoint:            strcase.ToLowerCamel(update),
			RouteName:           update,
			FindEndpoint:        findEndpoint,
			FindRequestProperty: findRequestProperty,
		}
	}
	isDeletePermitted, ok := permittedActions[deleteRestore]
	if isDeletePermitted && ok {
		result.DeleteHandler = &devkitv1.DeleteHandler{
			Endpoint:        strcase.ToLowerCamel(deleteKey),
			RequestProperty: deleteRestoreRequestProperty,
		}
	}
	isDeleteRestorePermitted, ok := permittedActions[deleteKey]
	if isDeleteRestorePermitted && ok {
		result.DeleteRestoreHandler = &devkitv1.DeleteRestoreHandler{
			Endpoint:        strcase.ToLowerCamel(deleteRestore),
			RequestProperty: deleteRestoreRequestProperty,
		}
	}
	return result
}
