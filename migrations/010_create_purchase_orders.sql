-- ENUM type for po_status
CREATE TYPE IF NOT EXISTS po_status AS ENUM ('draft', 'received_partial', 'received_full');

CREATE TABLE IF NOT EXISTS purchase_orders (
    po_id SERIAL PRIMARY KEY,
    supplier_id INT REFERENCES suppliers(supplier_id),
    po_number VARCHAR(50) UNIQUE,
    po_date TIMESTAMP,
    total_amount DECIMAL(12,2),
    status po_status,
    expected_delivery_date TIMESTAMP,
    received_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_purchase_orders_supplier ON purchase_orders (supplier_id);
CREATE INDEX IF NOT EXISTS idx_purchase_orders_status ON purchase_orders (status);
