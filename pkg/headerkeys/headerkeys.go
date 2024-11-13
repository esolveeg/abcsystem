package headerkeys

import (
	"net/http"
	"strings"
)

// callerIDKey is an unexported type to avoid key collisions.
type headerType string

// callerIDKey is an unexported variable of the unique key type.
var (
	permissionGroupKey  = headerType("X-Permission-Group")
	permittedActionsKey = headerType("X-Permitted-Actions")
)

func WithPermissionGroup(header http.Header, group string) {
	header.Add(string(permissionGroupKey), group)
}

func WithPermittedActions(header http.Header, actionsMap map[string]bool) {
	actions := make([]string, 0)
	for k, v := range actionsMap {
		if v {
			actions = append(actions, k)
		}
	}
	actionsStr := strings.Join(actions, ",")
	header.Add(string(permittedActionsKey), actionsStr)
}
func PermissionGroup(header *http.Header) string {
	return header.Get(string(permissionGroupKey))
}
func PermittedActions(header *http.Header) map[string]bool {
	permittedActions := header.Get(string(permittedActionsKey))
	actions := strings.Split(permittedActions, ",")
	result := make(map[string]bool)
	for _, action := range actions {
		result[action] = true
	}
	return result
}
