-- ENUM type for user_role
CREATE TYPE IF NOT EXISTS user_role AS ENUM ('admin', 'cashier', 'manager');

CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    username VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    role user_role,
    last_login TIMESTAMP,
    profile_photo_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_users_username_active ON users (username, is_active);
