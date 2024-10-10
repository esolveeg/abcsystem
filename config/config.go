package config

import (
	"fmt"
	"github.com/spf13/viper"
)

type StateConfig struct {
	State string `mapstructure:"STATE"`
}

// Config stores all configuration of the application.
// The values are read by viper from a config file or environment variable.
type Config struct {
	DBSource          string `mapstructure:"DB_SOURCE"`
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
