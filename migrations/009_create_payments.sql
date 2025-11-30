-- ENUM type for payment_method
CREATE TYPE IF NOT EXISTS payment_method AS ENUM ('cash', 'esewa', 'khalti', 'bank', 'credit');

CREATE TABLE IF NOT EXISTS payments (
    payment_id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES invoices(invoice_id),
    payment_date TIMESTAMP,
    amount DECIMAL(12, 2),
    method payment_method,
    payment_reference VARCHAR(255),
    recorded_by INT REFERENCES users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_payments_invoice ON payments (invoice_id);

CREATE INDEX IF NOT EXISTS idx_payments_date ON payments (payment_date);

CREATE INDEX IF NOT EXISTS idx_payments_method ON payments (method);
