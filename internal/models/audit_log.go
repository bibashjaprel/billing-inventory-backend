package models

import (
	"time"
)

// AuditLog represents an action performed by a user for auditing purposes
type AuditLog struct {
	LogID     uint      `gorm:"primaryKey;autoIncrement" json:"log_id"`
	UserID    uint      `gorm:"not null;index" json:"user_id"`
	User      User      `gorm:"constraint:OnUpdate:CASCADE,OnDelete:SET NULL;" json:"user,omitempty"`
	Action    string    `gorm:"size:50;not null" json:"action"` // e.g., CREATE, UPDATE, DELETE
	TableName string    `gorm:"size:100;not null;index" json:"table_name"`
	RecordID  uint      `gorm:"not null" json:"record_id"` // ID of the affected record
	CreatedAt time.Time `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt time.Time `gorm:"autoUpdateTime" json:"updated_at"`
}
