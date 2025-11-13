CREATE TABLE IF NOT EXISTS purchase_items (
    po_item_id SERIAL PRIMARY KEY,
    po_id INT REFERENCES purchase_orders(po_id) ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id),
    quantity INT,
    amount DECIMAL(12, 2),
    tax_rate DECIMAL(5, 2),
    tax_amount DECIMAL(12, 2),
    discount DECIMAL(12, 2),
    total DECIMAL(12, 2),
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_purchase_items_po ON purchase_items (po_id);

CREATE INDEX IF NOT EXISTS idx_purchase_items_product ON purchase_items (product_id);
