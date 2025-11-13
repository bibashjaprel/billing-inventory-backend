package models

import (
	"time"

	"gorm.io/gorm"
)

// Payment represents a payment made for an invoice
type Payment struct {
	PaymentID        uint           `gorm:"primaryKey;autoIncrement" json:"payment_id"`
	InvoiceID        uint           `gorm:"not null;index" json:"invoice_id"`
	Invoice          Invoice        `gorm:"constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"invoice,omitempty"`
	PaymentDate      time.Time      `gorm:"default:CURRENT_TIMESTAMP" json:"payment_date"`
	Amount           float64        `gorm:"type:decimal(12,2);default:0" json:"amount"`
	Method           string         `gorm:"size:50" json:"method,omitempty"`
	PaymentReference string         `gorm:"size:255" json:"payment_reference,omitempty"`
	RecordedByID     uint           `gorm:"not null" json:"recorded_by"`
	RecordedBy       User           `gorm:"constraint:OnUpdate:CASCADE,OnDelete:RESTRICT;" json:"recorded_by_user,omitempty"`
	IsActive         bool           `gorm:"default:true" json:"is_active"`
	CreatedAt        time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt        time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt        gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
}
