package repo

import (
	// INJECT IMPORTS
	"context"
        "github.com/darwishdev/devkit-api/db"
)

type PropertyRepoInterface interface {
	// INJECT INTERFACE
}

type PropertyRepo struct {
	store        db.Store
	errorHandler map[string]string
}

func NewPropertyRepo(store db.Store) PropertyRepoInterface {
	errorHandler := map[string]string{
	// INJECT ERROR
	}
	return &PropertyRepo{
		store:        store,
		errorHandler: errorHandler,
	}
}
