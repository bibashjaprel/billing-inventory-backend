package config

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

func ConnectDB() (*sql.DB, error) {
	host := GetEnv("DB_HOST", "localhost")
	user := GetEnv("DB_USER", "postgres")
	pass := GetEnv("DB_PASS", "postgres")
	name := GetEnv("DB_NAME", "billing_inventory_db")
	port := GetEnv("DB_PORT", "5432")
	ssl := GetEnv("DB_SSLMODE", "disable")

	dsn := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=%s", host, port, user, pass, name, ssl)
	db, err := sql.Open("postgres", dsn)
	if err != nil {
		return nil, err
	}
	if err := db.Ping(); err != nil {
		return nil, err
	}
	return db, nil
}

func CloseDB(db *sql.DB) {
	if db != nil {
		db.Close()
	}
}
