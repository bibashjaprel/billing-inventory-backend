CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    sku VARCHAR(100) UNIQUE,
    category_id INT REFERENCES categories(category_id) ON DELETE
    SET
        NULL,
        unit VARCHAR(50),
        cost_price DECIMAL(12, 2) DEFAULT 0,
        selling_price DECIMAL(12, 2) DEFAULT 0,
        stock_quantity INT DEFAULT 0,
        min_stock_level INT DEFAULT 0,
        barcode VARCHAR(100),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        deleted_at TIMESTAMP NULL,
        is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_products_sku ON products (sku);

CREATE INDEX IF NOT EXISTS idx_products_name ON products (name);
