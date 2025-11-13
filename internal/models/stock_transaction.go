package models

import (
	"time"

	"gorm.io/gorm"
)

// StockTransaction represents an inventory stock movement
type StockTransaction struct {
	TransactionID   uint           `gorm:"primaryKey;autoIncrement" json:"transaction_id"`
	ProductID       uint           `gorm:"not null;index" json:"product_id"`
	Product         Product        `gorm:"constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"product,omitempty"`
	TransactionType string         `gorm:"size:50;not null" json:"transaction_type"` // e.g., "IN", "OUT"
	Quantity        int            `gorm:"not null" json:"quantity"`
	ReferenceID     *uint          `gorm:"index" json:"reference_id,omitempty"` // optional, e.g., invoice or purchase order
	TransactionDate time.Time      `gorm:"default:CURRENT_TIMESTAMP" json:"transaction_date"`
	CreatedByID     uint           `gorm:"not null" json:"created_by"` // references User
	CreatedBy       User           `gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;" json:"created_by_user,omitempty"`
	IsActive        bool           `gorm:"default:true" json:"is_active"`
	CreatedAt       time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt       time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt       gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
}
