package handlers

import (
    "database/sql"
    "net/http"

    "github.com/gin-gonic/gin"
)

type CustomerHandler struct {
    DB *sql.DB
}

func NewCustomerHandler(db *sql.DB) *CustomerHandler {
    return &CustomerHandler{DB: db}
}

func (h *CustomerHandler) GetAll(c *gin.Context) {
    c.JSON(http.StatusOK, gin.H{"message":"get customers"})
}

func (h *CustomerHandler) Create(c *gin.Context) {
    c.JSON(http.StatusOK, gin.H{"message":"create customer"})
}

