package config

import (
    "github.com/joho/godotenv"
    "log"
    "os"
)

func LoadEnv() {
    if err := godotenv.Load(); err != nil {
        log.Println(".env not found, relying on environment variables")
    }
}

func GetEnv(key, fallback string) string {
    if v := os.Getenv(key); v != "" {
        return v
    }
    return fallback
}

