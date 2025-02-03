package adapter

import (
        "github.com/darwishdev/devkit-api/db"
        "github.com/darwishdev/devkit-api/proto_gen/devkit/v1"
)

type PropertyAdapterInterface interface {
        // INJECT INTERFACE
}

type PropertyAdapter struct {
}

func NewPropertyAdapter() PropertyAdapterInterface {
        return &PropertyAdapter{}
}
