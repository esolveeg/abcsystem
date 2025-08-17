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
	State string `mapstructure:"STATE"`

	AllowedOrigins []string `mapstructure:"ALLOWED_ORIGINS"`
	ApiVersion     string   `mapstructure:"API_VERSION"`
	ApiServiceName string   `mapstructure:"API_SERVICE_NAME"`

	GRPCServerAddress    string        `mapstructure:"GRPC_SERVER_ADDRESS"`
	BaseNetwork          string        `mapstructure:"BASE_NETWORK"`
	AccessTokenDuration  time.Duration `mapstructure:"ACCESS_TOKEN_DURATION"`
	RefreshTokenDuration time.Duration `mapstructure:"REFRESH_TOKEN_DURATION"`
	DockerHubUser        string        `mapstructure:"DOCKERHUB_USER"`
	AppName              string        `mapstructure:"APP_NAME"`
	GitUser              string        `mapstructure:"GIT_USER"`
	ERPAPIUrl            string        `mapstructure:"ERP_API_URL"`
	ERPAPIToken          string        `mapstructure:"EERP_API_TOKEN"`
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
	config.State = state
	if err != nil {
		return
	}
	return
}
