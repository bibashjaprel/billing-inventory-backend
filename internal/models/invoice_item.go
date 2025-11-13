package models

import (
	"time"

	"gorm.io/gorm"
)

// InvoiceItem represents a line item in an invoice
type InvoiceItem struct {
	InvoiceItemID uint           `gorm:"primaryKey;autoIncrement" json:"invoice_item_id"`
	InvoiceID     uint           `gorm:"not null;index" json:"invoice_id"`
	Invoice       Invoice        `gorm:"constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"invoice,omitempty"`
	ProductID     uint           `gorm:"not null;index" json:"product_id"`
	Product       Product        `gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;" json:"product,omitempty"`
	Quantity      int            `gorm:"not null" json:"quantity"`
	Rate          float64        `gorm:"type:decimal(12,2);default:0" json:"rate"`
	Discount      float64        `gorm:"type:decimal(12,2);default:0" json:"discount"`
	Total         float64        `gorm:"type:decimal(12,2);default:0" json:"total"`
	IsActive      bool           `gorm:"default:true" json:"is_active"`
	CreatedAt     time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt     time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt     gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
}
