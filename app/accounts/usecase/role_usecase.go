package usecase

import (
	"context"
	"github.com/darwishdev/devkit-api/gen/db"
	apiv1 "github.com/darwishdev/devkit-api/gen/pb/proto/devkit/v1"
	"github.com/jackc/pgx/v5/pgtype"
)

func (u *AccountsUsecase) RoleCreate(ctx context.Context, req *apiv1.RoleCreateRequest) (*apiv1.RoleCreateResponse, error) {
	roleCreateParams := db.RoleCreateParams{RoleName: req.GetRoleName(), RoleDescription: pgtype.Text{String: req.GetRoleDescription(), Valid: true}}
	role, err := u.repo.RoleCreate(ctx, roleCreateParams)

	if err != nil {
		return nil, err
	}
	response := apiv1.RoleCreateResponse{Role: &apiv1.AccountsSchemaRole{
		RoleId:          role.RoleID,
		RoleName:        role.RoleName,
		RoleDescription: role.RoleDescription.String,
		CreatedAt:       role.CreatedAt.Time.Format("2024-10-01"),
		DeletedAt:       role.CreatedAt.Time.Format("2024-10-01"),
	}}
	return &response, nil
}
