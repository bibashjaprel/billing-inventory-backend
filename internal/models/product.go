package models

import (
	"time"

	"gorm.io/gorm"
)

// Product represents an item in the inventory
type Product struct {
	ProductID     uint           `gorm:"primaryKey;autoIncrement" json:"product_id"`
	Name          string         `gorm:"size:255;not null;index" json:"name"`
	SKU           string         `gorm:"size:100;uniqueIndex;not null" json:"sku"`
	CategoryID    *uint          `gorm:"index" json:"category_id,omitempty"` // nullable foreign key
	Category      *Category      `gorm:"constraint:OnUpdate:CASCADE,OnDelete:SET NULL;" json:"category,omitempty"`
	Unit          string         `gorm:"size:50" json:"unit,omitempty"`
	CostPrice     float64        `gorm:"type:decimal(12,2);default:0" json:"cost_price"`
	SellingPrice  float64        `gorm:"type:decimal(12,2);default:0" json:"selling_price"`
	StockQuantity int            `gorm:"default:0" json:"stock_quantity"`
	MinStockLevel int            `gorm:"default:0" json:"min_stock_level"`
	Barcode       string         `gorm:"size:100" json:"barcode,omitempty"`
	IsActive      bool           `gorm:"default:true" json:"is_active"`
	CreatedAt     time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt     time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt     gorm.DeletedAt `gorm:"index" json:"deleted_at,omitempty"`
}
