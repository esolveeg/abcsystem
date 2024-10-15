package db

import (
	"context"
	"testing"

	"github.com/darwishdev/devkit-api/random"
	"github.com/stretchr/testify/require"
)

func TestRoleCreate(t *testing.T) {
	// Define test input parameters.
	validName := random.RandomName()
	testcases := []struct {
		name             string
		params           *RoleCreateParams
		expectedErrorMsg string
		expectErr        bool
	}{
		{
			name: "ValidRole",
			params: &RoleCreateParams{
				RoleName:        validName,
				RoleDescription: random.RandomString(50),
				Permissions:     []int32{1, 2, 3},
			},
			expectErr: false,
		},
		{
			name: "DuplicatedRoleName",
			params: &RoleCreateParams{
				RoleName:        validName,
				RoleDescription: random.RandomString(50),
				Permissions:     []int32{1, 2, 3},
			},
			expectErr: true,
		},
		{
			name: "RoleNameRequired",
			params: &RoleCreateParams{
				RoleName:        "", // Empty role name
				RoleDescription: random.RandomString(50),
				Permissions:     []int32{1, 2, 3},
			},
			expectErr: true,
		},
		{
			name: "RoleNameTooLong",
			params: &RoleCreateParams{
				RoleName:        random.RandomString(220), // Exceeds max length
				RoleDescription: random.RandomString(50),
				Permissions:     []int32{1, 2, 3},
			},
			expectErr: true,
		},
	}
	for _, tc := range testcases {
		t.Run(tc.name, func(t *testing.T) {
			// Call the RoleCreate function with the test parameters
			role, err := store.RoleCreate(context.Background(), *tc.params)

			if tc.expectErr {
				require.Error(t, err)
				require.Empty(t, role) // Expect no role to be returned on error
			} else {
				require.NoError(t, err)
				require.NotEmpty(t, role)
				require.Equal(t, tc.params.RoleName, role.RoleName)
				require.Equal(t, tc.params.RoleDescription, role.RoleDescription.String)
			}
		})
	}

}
