CREATE TABLE IF NOT EXISTS stock_transactions (
    transaction_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    transaction_type VARCHAR(50),
    quantity INT,
    reference_id INT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT REFERENCES users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_stock_transactions_product ON stock_transactions(product_id);

CREATE INDEX IF NOT EXISTS idx_stock_transactions_ref ON stock_transactions(reference_id);
