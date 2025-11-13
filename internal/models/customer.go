package models

import (
	"time"

	"gorm.io/gorm"
)

// Customer represents a customer in the system
type Customer struct {
	CustomerID     uint           `gorm:"primaryKey;autoIncrement" json:"customer_id"`
	Name           string         `gorm:"size:255;not null" json:"name"`
	Phone          string         `gorm:"size:20;index" json:"phone,omitempty"`
	Email          string         `gorm:"size:255" json:"email,omitempty"`
	Address        string         `gorm:"type:text" json:"address,omitempty"`
	OpeningBalance float64        `gorm:"type:decimal(12,2);default:0" json:"opening_balance"`
	IsActive       bool           `gorm:"default:true" json:"is_active"`
	CreatedAt      time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt      time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt      gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
}
