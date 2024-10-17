package supabasea

import (
	"github.com/darwishdev/supaapi-go"
)

// su "github.com/darwishdev/supabase-go"

type SupabaseInterface interface {
}

type Supabase struct {
	client supaapigo.SupaapiInterface
}

func NewSupabaseService(supabaseUrl string, supabaseStorageUrl string, supabaseKey string) SupabaseInterface {
	client := supaapigo.NewSupaapi(supabaseUrl, supabaseStorageUrl, supabaseKey)
	return &Supabase{
		client: client,
	}
}
