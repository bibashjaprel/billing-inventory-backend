package models

import (
	"time"

	"gorm.io/gorm"
)

// Supplier represents a supplier in the system
type Supplier struct {
	SupplierID    uint           `gorm:"primaryKey;autoIncrement" json:"supplier_id"`
	Name          string         `gorm:"size:255;not null;index" json:"name"`
	ContactPerson string         `gorm:"size:255" json:"contact_person,omitempty"`
	Phone         string         `gorm:"size:20" json:"phone,omitempty"`
	Email         string         `gorm:"size:255" json:"email,omitempty"`
	Address       string         `gorm:"type:text" json:"address,omitempty"`
	IsActive      bool           `gorm:"default:true" json:"is_active"`
	CreatedAt     time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt     time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt     gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
}
