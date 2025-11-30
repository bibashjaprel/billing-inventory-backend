CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    sku VARCHAR(100) UNIQUE,
    barcode VARCHAR(100),
    category_id INT REFERENCES categories(category_id),
    unit VARCHAR(50),
    cost_price DECIMAL(12, 2),
    selling_price DECIMAL(12, 2),
    stock_quantity INT,
    min_stock_level INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_products_barcode ON products (barcode);

CREATE INDEX IF NOT EXISTS idx_products_category ON products (category_id);

CREATE INDEX IF NOT EXISTS idx_products_active ON products (is_active);
