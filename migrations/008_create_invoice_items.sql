CREATE TABLE IF NOT EXISTS invoice_items (
    invoice_item_id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES invoices(invoice_id) ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id),
    quantity INT,
    rate DECIMAL(12, 2),
    discount DECIMAL(12, 2),
    total DECIMAL(12, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_invoice_items_invoice ON invoice_items (invoice_id);

CREATE INDEX IF NOT EXISTS idx_invoice_items_product ON invoice_items (product_id);
