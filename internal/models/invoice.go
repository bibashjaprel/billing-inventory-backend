package models

import (
	"time"

	"gorm.io/gorm"
)

// Invoice represents a sales invoice
type Invoice struct {
	InvoiceID         uint           `gorm:"primaryKey;autoIncrement" json:"invoice_id"`
	InvoiceNumber     string         `gorm:"size:50;uniqueIndex;not null" json:"invoice_number"`
	CustomerID        uint           `gorm:"not null;index" json:"customer_id"`
	Customer          Customer       `gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;" json:"customer,omitempty"`
	InvoiceDate       time.Time      `gorm:"default:CURRENT_TIMESTAMP;index" json:"invoice_date"`
	NepaliInvoiceDate string         `gorm:"size:50" json:"nepali_invoice_date,omitempty"`
	TotalAmount       float64        `gorm:"type:decimal(12,2);default:0" json:"total_amount"`
	DiscountAmount    float64        `gorm:"type:decimal(12,2);default:0" json:"discount_amount"`
	TaxRate           float64        `gorm:"type:decimal(5,2);default:0" json:"tax_rate"`
	TaxAmount         float64        `gorm:"type:decimal(12,2);default:0" json:"tax_amount"`
	GrandTotal        float64        `gorm:"type:decimal(12,2);default:0" json:"grand_total"`
	PaymentStatus     string         `gorm:"size:50" json:"payment_status,omitempty"`
	PaymentDueDate    *time.Time     `json:"payment_due_date,omitempty"`
	Remarks           string         `gorm:"type:text" json:"remarks,omitempty"`
	InvoiceType       string         `gorm:"size:50" json:"invoice_type,omitempty"`
	RoundOff          float64        `gorm:"type:decimal(5,2);default:0" json:"round_off"`
	CreatedByID       uint           `gorm:"not null" json:"created_by"`
	CreatedBy         User           `gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;" json:"created_by_user,omitempty"`
	IsActive          bool           `gorm:"default:true" json:"is_active"`
	CreatedAt         time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt         time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt         gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
	InvoiceItems      []InvoiceItem  `gorm:"foreignKey:InvoiceID" json:"invoice_items,omitempty"`
}
