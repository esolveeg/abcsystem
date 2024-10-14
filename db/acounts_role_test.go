package db

import (
	"context"
	"testing"

	"github.com/darwishdev/devkit-api/random"
	"github.com/jackc/pgx/v5/pgtype"
	"github.com/stretchr/testify/require"
)

func TestRoleCreate(t *testing.T) {
	// Define test input parameters.
	testRoleName := random.RandomName()
	testRoleDescription := pgtype.Text{String: random.RandomName(), Valid: true}

	arg := RoleCreateParams{
		RoleName:        testRoleName,
		RoleDescription: testRoleDescription,
	}

	// Call the RoleCreate function and capture the result.
	role, err := store.RoleCreate(context.Background(), arg)

	// Use require package to validate results
	require.NoError(t, err)
	require.NotEmpty(t, role)

	// Validate the role fields.
	require.Equal(t, testRoleName, role.RoleName)
	require.Equal(t, testRoleDescription.String, role.RoleDescription.String)

}
