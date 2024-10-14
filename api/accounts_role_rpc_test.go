package api

import (
	"context"
	"testing"

	"connectrpc.com/connect"
	"github.com/darwishdev/devkit-api/db"
	mockdb "github.com/darwishdev/devkit-api/db/mock"
	"github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
	"github.com/darwishdev/devkit-api/random"
	"github.com/golang/mock/gomock"
)

type roleCreateTest struct {
	name       string
	params     *devkitv1.RoleCreateRequest
	buildStubs func(store *mockdb.MockStore)
	expectErr  bool
}

func getValidRole() *devkitv1.RoleCreateRequest {
	return &devkitv1.RoleCreateRequest{
		RoleName:        random.RandomName(),
		RoleDescription: random.RandomString(50),
	}
}

func TestRoleCreate(t *testing.T) {

	validRole := getValidRole()
	// Define a slice of test cases
	testcases := []roleCreateTest{
		// Test for a valid role creation.
		{
			name: "ValidRole",
			params: &devkitv1.RoleCreateRequest{
				RoleName:        validRole.RoleName,
				RoleDescription: validRole.RoleDescription,
			},
			buildStubs: func(store *mockdb.MockStore) {
				arg := db.RoleCreateParams{
					RoleName:        validRole.RoleName,
					RoleDescription: db.StringToPgtext(validRole.RoleDescription),
				}
				store.EXPECT().
					RoleCreate(gomock.Any(), arg).
					Times(1).
					Return(db.AccountsSchemaRole{

						RoleID:          1,
						RoleName:        validRole.RoleName,
						RoleDescription: db.StringToPgtext((validRole.RoleDescription)),
					}, nil)
			},
			expectErr: false,
		},
		{
			name: "InValidNameToShort",
			params: &devkitv1.RoleCreateRequest{
				RoleName:        random.RandomString(1),
				RoleDescription: validRole.RoleDescription,
			},
			buildStubs: func(store *mockdb.MockStore) {
				store.EXPECT().
					RoleCreate(gomock.Any(), gomock.Any()).
					Times(0)

			},
			expectErr: true,
		},
		{
			name: "InValidNameToLong",
			params: &devkitv1.RoleCreateRequest{
				RoleName:        random.RandomString(220),
				RoleDescription: validRole.RoleDescription,
			},
			buildStubs: func(store *mockdb.MockStore) {

				store.EXPECT().
					RoleCreate(gomock.Any(), gomock.Any()).
					Times(0)

			},
			expectErr: true,
		},
		{
			name: "InValidDescriptionToLong",
			params: &devkitv1.RoleCreateRequest{
				RoleName:        random.RandomString(120),
				RoleDescription: random.RandomString(220),
			},
			buildStubs: func(store *mockdb.MockStore) {

				store.EXPECT().
					RoleCreate(gomock.Any(), gomock.Any()).
					Times(0)

			},
			expectErr: true,
		},
	}

	// Loop through the test cases and test each one
	// ctx := context.Background()
	storeCtrl := gomock.NewController(t)
	defer storeCtrl.Finish()
	store := mockdb.NewMockStore(storeCtrl)
	api := newTestApi(store)

	for _, tc := range testcases {
		t.Run(tc.name, func(t *testing.T) {
			tc.buildStubs(store)
			createdRole, err :=
				api.RoleCreate(context.Background(), connect.NewRequest(tc.params))
			// If the current test case expects an error and no error occurred, fail the test
			if tc.expectErr && err == nil {
				t.Errorf("Expected an error but got none %s", tc.name)
			}

			// If the current test case does not expect an error and an error occurred, fail the test
			if !tc.expectErr && err != nil {
				t.Errorf("Expected no error but got %v", err)
			}
			if !tc.expectErr {
				if createdRole.Msg.Role.RoleName != tc.params.RoleName {
					t.Errorf("un expected name wanted %s got %s", createdRole.Msg.Role.RoleName, tc.params.RoleName)
				}
				if createdRole.Msg.Role.RoleDescription != tc.params.RoleDescription {
					t.Errorf("un expected description wanted %s got %s", createdRole.Msg.Role.RoleDescription, tc.params.RoleDescription)
				}

			}

		})
	}
}
