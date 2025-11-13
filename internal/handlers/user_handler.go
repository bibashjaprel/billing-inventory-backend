package handlers

import (
    "database/sql"
    "net/http"

    "github.com/gin-gonic/gin"
)

type UserHandler struct {
    DB *sql.DB
}

func NewUserHandler(db *sql.DB) *UserHandler {
    return &UserHandler{DB: db}
}

func (h *UserHandler) Register(c *gin.Context) {
    c.JSON(http.StatusOK, gin.H{"message":"register"})
}

func (h *UserHandler) Login(c *gin.Context) {
    c.JSON(http.StatusOK, gin.H{"message":"login"})
}

