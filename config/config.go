package config

import (
	"fmt"
	"time"

	"github.com/spf13/viper"
)

type StateConfig struct {
	State string `mapstructure:"STATE"`
}

// Config stores all configuration of the application.
// The values are read by viper from a config file or environment variable.
type Config struct {
	AccessTokenDuration    time.Duration `mapstructure:"ACCESS_TOKEN_DURATION"`
	DBProjectREF           string        `mapstructure:"DB_PROJECT_REF"`
	SupabaseServiceRoleKey string        `mapstructure:"SUPABASE_SERVICE_ROLE_KEY"`
	SupabaseApiKey         string        `mapstructure:"SUPABASE_API_KEY"`
	DBSource               string        `mapstructure:"DB_SOURCE"`
	TokenSymmetricKey      string        `mapstructure:"TOKEN_SYMMETRIC_KEY"`

	RedisAddress      string `mapstructure:"REDIS_ADDRESS"`
	RedisPort         string `mapstructure:"REDIS_PORT"`
	RedisHost         string `mapstructure:"REDIS_HOST"`
	RedisPassword     string `mapstructure:"REDIS_PASSWORD"`
	RedisDatabase     int    `mapstructure:"REDIS_DATABASE"`
	GRPCServerAddress string `mapstructure:"GRPC_SERVER_ADDRESS"`
}

// LoadConfig reads configuration from file or environment variables.
func LoadState(path string) (config StateConfig, err error) {
	viper.AddConfigPath(path)
	viper.SetConfigName("state")
	viper.SetConfigType("env")
	viper.AutomaticEnv()
	err = viper.ReadInConfig()
	if err != nil {
		return
	}
	err = viper.Unmarshal(&config)
	return
}

func loadAncScan(config *Config) (err error) {
	err = viper.ReadInConfig()
	if err != nil {
		return err
	}
	err = viper.Unmarshal(config)
	if err != nil {
		return err
	}
	return nil
}

// LoadConfig reads configuration from file or environment variables.
func LoadConfig(path string, state string) (config Config, err error) {
	stateEnvFilePath := fmt.Sprintf("%s.env", state)
	viper.SetConfigName(stateEnvFilePath)

	err = loadAncScan(&config)
	if err != nil {
		return
	}
	viper.SetConfigName("shared.env")
	err = loadAncScan(&config)
	if err != nil {
		return
	}
	return
}
