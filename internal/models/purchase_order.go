package models

import (
	"time"

	"gorm.io/gorm"
)

// PurchaseOrder represents a supplier purchase order
type PurchaseOrder struct {
	PurchaseOrderID      uint           `gorm:"primaryKey;autoIncrement" json:"po_id"`
	SupplierID           uint           `gorm:"not null;index" json:"supplier_id"`
	Supplier             Supplier       `gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;" json:"supplier,omitempty"`
	PONumber             string         `gorm:"size:50;uniqueIndex;not null" json:"po_number"`
	PODate               time.Time      `gorm:"default:CURRENT_TIMESTAMP" json:"po_date"`
	TotalAmount          float64        `gorm:"type:decimal(12,2);default:0" json:"total_amount"`
	Status               string         `gorm:"size:50" json:"status,omitempty"` // e.g., Pending, Received, Cancelled
	ExpectedDeliveryDate *time.Time     `json:"expected_delivery_date,omitempty"`
	ReceivedDate         *time.Time     `json:"received_date,omitempty"`
	IsActive             bool           `gorm:"default:true" json:"is_active"`
	CreatedAt            time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt            time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt            gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
	PurchaseItems        []PurchaseItem `gorm:"foreignKey:PurchaseOrderID" json:"purchase_items,omitempty"`
}
