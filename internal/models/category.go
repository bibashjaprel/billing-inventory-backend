package models

import (
	"time"

	"gorm.io/gorm"
)

// Category represents a product category
type Category struct {
	CategoryID  uint           `gorm:"primaryKey;autoIncrement" json:"category_id"`
	Name        string         `gorm:"size:255;not null;uniqueIndex" json:"name"`
	Description string         `gorm:"type:text" json:"description,omitempty"`
	IsActive    bool           `gorm:"default:true" json:"is_active"`
	CreatedAt   time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt   time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt   gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
}
