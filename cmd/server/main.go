package main

import (
    "log"
    "os"

    "github.com/gin-gonic/gin"
    "github.com/bibashjaprel/billing-inventory-backend/config"
    "github.com/bibashjaprel/billing-inventory-backend/internal/routes"
)

func main() {
    // load env
    config.LoadEnv()
    db, err := config.ConnectDB()
    if err != nil {
        log.Fatal("failed to connect db: ", err)
    }
    defer config.CloseDB(db)

    r := gin.Default()
    api := r.Group("/api/v1")
    routes.RegisterRoutes(api, db)

    port := os.Getenv("APP_PORT")
    if port == "" {
        port = "8080"
    }
    log.Println("Server started on :" + port)
    r.Run(":" + port)
}

