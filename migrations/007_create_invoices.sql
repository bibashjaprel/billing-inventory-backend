CREATE TABLE IF NOT EXISTS invoices (
    invoice_id SERIAL PRIMARY KEY,
    invoice_number VARCHAR(50) UNIQUE,
    customer_id INT REFERENCES customers(customer_id),
    invoice_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nepali_invoice_date VARCHAR(50),
    total_amount DECIMAL(12, 2),
    discount_amount DECIMAL(12, 2),
    tax_rate DECIMAL(5, 2),
    tax_amount DECIMAL(12, 2),
    grand_total DECIMAL(12, 2),
    payment_status VARCHAR(50),
    payment_due_date TIMESTAMP,
    remarks TEXT,
    invoice_type VARCHAR(50),
    round_off DECIMAL(5, 2),
    created_by INT REFERENCES users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_invoices_customer ON invoices (customer_id);

CREATE INDEX IF NOT EXISTS idx_invoices_date ON invoices (invoice_date);
