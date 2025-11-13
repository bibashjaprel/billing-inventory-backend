package models

import (
	"time"

	"gorm.io/gorm"
)

// PurchaseItem represents a line item in a purchase order
type PurchaseItem struct {
	PurchaseItemID  uint           `gorm:"primaryKey;autoIncrement" json:"po_item_id"`
	PurchaseOrderID uint           `gorm:"not null;index" json:"po_id"`
	PurchaseOrder   PurchaseOrder  `gorm:"constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"purchase_order,omitempty"`
	ProductID       uint           `gorm:"not null;index" json:"product_id"`
	Product         Product        `gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;" json:"product,omitempty"`
	Quantity        int            `gorm:"not null" json:"quantity"`
	Amount          float64        `gorm:"type:decimal(12,2);default:0" json:"amount"`
	TaxRate         float64        `gorm:"type:decimal(5,2);default:0" json:"tax_rate"`
	TaxAmount       float64        `gorm:"type:decimal(12,2);default:0" json:"tax_amount"`
	Discount        float64        `gorm:"type:decimal(12,2);default:0" json:"discount"`
	Total           float64        `gorm:"type:decimal(12,2);default:0" json:"total"`
	Remarks         string         `gorm:"type:text" json:"remarks,omitempty"`
	IsActive        bool           `gorm:"default:true" json:"is_active"`
	CreatedAt       time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt       time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt       gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
}
