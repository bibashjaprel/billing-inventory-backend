package models

import (
	"time"

	"gorm.io/gorm"
)

type User struct {
	UserID          uint           `gorm:"primaryKey;autoIncrement" json:"user_id"`
	FullName        string         `gorm:"size:255;not null" json:"full_name"`
	Username        string         `gorm:"size:100;not null;unique" json:"username"`
	PasswordHash    string         `gorm:"size:255;not null" json:"password_hash"`
	Email           string         `gorm:"size:255" json:"email"`
	Phone           string         `gorm:"size:20" json:"phone"`
	Role            string         `gorm:"size:50;not null" json:"role"`
	LastLogin       *time.Time     `json:"last_login"`
	ProfilePhotoURL string         `gorm:"size:255" json:"profile_photo_url"`
	CreatedAt       time.Time      `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt       time.Time      `gorm:"autoUpdateTime" json:"updated_at"`
	DeletedAt       gorm.DeletedAt `gorm:"index" json:"deleted_at"`
	IsActive        bool           `gorm:"default:true" json:"is_active"`
}
