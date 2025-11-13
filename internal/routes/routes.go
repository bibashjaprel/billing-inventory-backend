package routes

import (
    "database/sql"

    "github.com/gin-gonic/gin"
    "github.com/bibashjaprel/billing-inventory-backend/internal/handlers"
)

func RegisterRoutes(rg *gin.RouterGroup, db *sql.DB) {
    // health
    rg.GET("/health", func(c *gin.Context) {
        c.JSON(200, gin.H{"status":"ok"})
    })

    // users
    uh := handlers.NewUserHandler(db)
    users := rg.Group("/users")
    users.POST("/register", uh.Register)
    users.POST("/login", uh.Login)

    // customers
    ch := handlers.NewCustomerHandler(db)
    cust := rg.Group("/customers")
    cust.GET("/", ch.GetAll)
    cust.POST("/", ch.Create)

    // products
    ph := handlers.NewProductHandler(db)
    prod := rg.Group("/products")
    prod.GET("/", ph.GetAll)
    prod.POST("/", ph.Create)
}

