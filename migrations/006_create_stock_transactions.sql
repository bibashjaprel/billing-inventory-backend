-- ENUM type for stock_transaction_type
CREATE TYPE IF NOT EXISTS stock_transaction_type AS ENUM ('IN', 'OUT', 'ADJUSTMENT');

CREATE TABLE IF NOT EXISTS stock_transactions (
    transaction_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    transaction_type stock_transaction_type,
    quantity INT,
    reference_type VARCHAR(50),
    reference_id INT,
    transaction_date TIMESTAMP,
    created_by INT REFERENCES users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_stock_product_date ON stock_transactions (product_id, transaction_date);
CREATE INDEX IF NOT EXISTS idx_stock_reference ON stock_transactions (reference_type, reference_id);
CREATE INDEX IF NOT EXISTS idx_stock_active ON stock_transactions (is_active);
