package handlers

import (
    "database/sql"
    "net/http"

    "github.com/gin-gonic/gin"
)

type ProductHandler struct {
    DB *sql.DB
}

func NewProductHandler(db *sql.DB) *ProductHandler {
    return &ProductHandler{DB: db}
}

func (h *ProductHandler) GetAll(c *gin.Context) {
    c.JSON(http.StatusOK, gin.H{"message":"get products"})
}

func (h *ProductHandler) Create(c *gin.Context) {
    c.JSON(http.StatusOK, gin.H{"message":"create product"})
}

