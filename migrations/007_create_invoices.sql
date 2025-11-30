-- ENUM types for payment_status and invoice_type
CREATE TYPE IF NOT EXISTS payment_status AS ENUM ('paid', 'pending', 'partial');

CREATE TYPE IF NOT EXISTS invoice_type AS ENUM ('retail', 'wholesale');

CREATE TABLE IF NOT EXISTS invoices (
    invoice_id SERIAL PRIMARY KEY,
    invoice_number VARCHAR(50) UNIQUE,
    customer_id INT REFERENCES customers(customer_id),
    created_by INT REFERENCES users(user_id),
    invoice_date TIMESTAMP,
    nepali_invoice_date VARCHAR(50),
    total_amount DECIMAL(12, 2),
    discount_amount DECIMAL(12, 2),
    tax_rate DECIMAL(5, 2),
    tax_amount DECIMAL(12, 2),
    grand_total DECIMAL(12, 2),
    round_off DECIMAL(12, 2),
    payment_status payment_status,
    payment_due_date TIMESTAMP,
    invoice_type invoice_type,
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_invoices_customer_date ON invoices (customer_id, invoice_date);

CREATE INDEX IF NOT EXISTS idx_invoices_status ON invoices (payment_status);

CREATE INDEX IF NOT EXISTS idx_invoices_active ON invoices (is_active);
