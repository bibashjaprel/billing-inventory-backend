
-- ==================================================
-- PostgreSQL POS / Inventory Schema + Data Sample Data
-- ==================================================

-- =========================
-- ENUM TYPES
-- =========================
CREATE TYPE user_role AS ENUM ('admin', 'cashier', 'manager');
CREATE TYPE payment_status AS ENUM ('paid', 'pending', 'partial');
CREATE TYPE invoice_type AS ENUM ('retail', 'wholesale');
CREATE TYPE payment_method AS ENUM ('cash', 'esewa', 'khalti', 'bank', 'credit');
CREATE TYPE stock_transaction_type AS ENUM ('IN', 'OUT', 'ADJUSTMENT');
CREATE TYPE po_status AS ENUM ('draft', 'received_partial', 'received_full');

-- =========================
-- TABLES
-- =========================
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  username VARCHAR(100) UNIQUE,
  password_hash VARCHAR(255),
  email VARCHAR(255) UNIQUE,
  phone VARCHAR(20),
  role user_role,
  last_login TIMESTAMP,
  profile_photo_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_users_username_active ON users (username, is_active);

CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  phone VARCHAR(20),
  email VARCHAR(255),
  address TEXT,
  opening_balance DECIMAL(12,2) DEFAULT 0.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);
CREATE INDEX idx_customers_phone ON customers (phone);
CREATE INDEX idx_customers_active ON customers (is_active);

CREATE TABLE suppliers (
  supplier_id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  contact_person VARCHAR(255),
  phone VARCHAR(20),
  email VARCHAR(255),
  address TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);
CREATE INDEX idx_suppliers_active ON suppliers (is_active);

CREATE TABLE categories (
  category_id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);
CREATE INDEX idx_categories_active ON categories (is_active);

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  sku VARCHAR(100) UNIQUE,
  barcode VARCHAR(100),
  category_id INT REFERENCES categories(category_id),
  unit VARCHAR(50),
  cost_price DECIMAL(12,2),
  selling_price DECIMAL(12,2),
  stock_quantity INT,
  min_stock_level INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);
CREATE INDEX idx_products_barcode ON products (barcode);
CREATE INDEX idx_products_category ON products (category_id);
CREATE INDEX idx_products_active ON products (is_active);

CREATE TABLE stock_transactions (
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
CREATE INDEX idx_stock_product_date ON stock_transactions (product_id, transaction_date);
CREATE INDEX idx_stock_reference ON stock_transactions (reference_type, reference_id);
CREATE INDEX idx_stock_active ON stock_transactions (is_active);

CREATE TABLE invoices (
  invoice_id SERIAL PRIMARY KEY,
  invoice_number VARCHAR(50) UNIQUE,
  customer_id INT REFERENCES customers(customer_id),
  created_by INT REFERENCES users(user_id),
  invoice_date TIMESTAMP,
  nepali_invoice_date VARCHAR(50),
  total_amount DECIMAL(12,2),
  discount_amount DECIMAL(12,2),
  tax_rate DECIMAL(5,2),
  tax_amount DECIMAL(12,2),
  grand_total DECIMAL(12,2),
  round_off DECIMAL(12,2),
  payment_status payment_status,
  payment_due_date TIMESTAMP,
  invoice_type invoice_type,
  remarks TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);
CREATE INDEX idx_invoices_customer_date ON invoices (customer_id, invoice_date);
CREATE INDEX idx_invoices_status ON invoices (payment_status);
CREATE INDEX idx_invoices_active ON invoices (is_active);

CREATE TABLE invoice_items (
  invoice_item_id SERIAL PRIMARY KEY,
  invoice_id INT REFERENCES invoices(invoice_id),
  product_id INT REFERENCES products(product_id),
  quantity INT,
  rate DECIMAL(12,2),
  discount DECIMAL(12,2),
  total DECIMAL(12,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);
CREATE INDEX idx_invoice_items_invoice_product ON invoice_items (invoice_id, product_id);

CREATE TABLE payments (
  payment_id SERIAL PRIMARY KEY,
  invoice_id INT REFERENCES invoices(invoice_id),
  payment_date TIMESTAMP,
  amount DECIMAL(12,2),
  method payment_method,
  payment_reference VARCHAR(255),
  recorded_by INT REFERENCES users(user_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);
CREATE INDEX idx_payments_invoice ON payments (invoice_id);
CREATE INDEX idx_payments_date ON payments (payment_date);
CREATE INDEX idx_payments_method ON payments (method);

CREATE TABLE purchase_orders (
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
CREATE INDEX idx_purchase_orders_supplier ON purchase_orders (supplier_id);
CREATE INDEX idx_purchase_orders_status ON purchase_orders (status);

CREATE TABLE purchase_items (
  po_item_id SERIAL PRIMARY KEY,
  po_id INT REFERENCES purchase_orders(po_id),
  product_id INT REFERENCES products(product_id),
  quantity INT,
  amount DECIMAL(12,2),
  tax_rate DECIMAL(5,2),
  tax_amount DECIMAL(12,2),
  discount DECIMAL(12,2),
  total DECIMAL(12,2),
  remarks TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE
);
CREATE INDEX idx_purchase_items_po_product ON purchase_items (po_id, product_id);

CREATE TABLE audit_logs (
  log_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  action VARCHAR(50),
  table_name VARCHAR(100),
  record_id INT,
  ip_address VARCHAR(50),
  old_value TEXT,
  new_value TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_audit_table_record ON audit_logs (table_name, record_id);


-- =========================
-- SAMPLE DATA
-- =========================
-- USERS
INSERT INTO users (full_name, username, password_hash, email, phone, role)
VALUES
('Admin User', 'admin', 'hash123', 'admin@example.com', '9800000001', 'admin'),
('Cashier One', 'cashier1', 'hash456', 'cashier1@example.com', '9800000002', 'cashier'),
('Store Manager', 'manager', 'hash789', 'manager@example.com', '9800000003', 'manager');

-- CUSTOMERS
INSERT INTO customers (name, phone, email, address, opening_balance)
VALUES
('Ram Bahadur', '9801111111', 'ram@example.com', 'Kathmandu', 0),
('Sita Devi', '9802222222', 'sita@example.com', 'Patan', 100),
('Hari Shrestha', '9803333333', 'hari@example.com', 'Bhaktapur', 50);

-- SUPPLIERS
INSERT INTO suppliers (name, contact_person, phone, email, address)
VALUES
('ABC Traders', 'Ramesh', '9804444444', 'abc@traders.com', 'Kalanki'),
('Global Suppliers', 'Manish', '9805555555', 'global@supply.com', 'Chitwan');

-- CATEGORIES
INSERT INTO categories (name, description)
VALUES
('Grocery', 'Everyday grocery items'),
('Electronics', 'Electronic products'),
('Beverage', 'Drinks and beverages');

-- PRODUCTS
INSERT INTO products (name, sku, barcode, category_id, unit, cost_price, selling_price, stock_quantity, min_stock_level)
VALUES
('Rice 20KG', 'SKU-RICE-20', 'BR123001', 1, 'bag', 1800, 2200, 50, 5),
('Cooking Oil 1L', 'SKU-OIL-1', 'BR123002', 1, 'bottle', 220, 260, 80, 10),
('Coca Cola 1L', 'SKU-COKE-1', 'BR123003', 3, 'bottle', 80, 100, 100, 20),
('LED Bulb 12W', 'SKU-BULB-12', 'BR123004', 2, 'piece', 120, 150, 40, 10);

-- PURCHASE ORDERS
INSERT INTO purchase_orders (supplier_id, po_number, po_date, total_amount, status)
VALUES
(1, 'PO-1001', NOW() - INTERVAL '10 days', 50000, 'received_full'),
(2, 'PO-1002', NOW() - INTERVAL '5 days', 30000, 'received_partial');

-- PURCHASE ITEMS
INSERT INTO purchase_items (po_id, product_id, quantity, amount, tax_rate, tax_amount, discount, total, remarks)
VALUES
(1,1,20,36000,13,4680,0,40680,'Full supply'),
(1,2,40,8800,13,1144,0,9944,'Cooking oil'),
(2,3,100,8000,13,1040,500,8540,'Soft drinks'),
(2,4,25,3000,13,390,0,3390,'Bulbs partial');

-- STOCK TRANSACTIONS (Purchase IN)
INSERT INTO stock_transactions (product_id, transaction_type, quantity, reference_type, reference_id, transaction_date, created_by)
VALUES
(1,'IN',20,'purchase',1,NOW() - INTERVAL '10 days',1),
(2,'IN',40,'purchase',1,NOW() - INTERVAL '10 days',1),
(3,'IN',100,'purchase',2,NOW() - INTERVAL '5 days',1),
(4,'IN',25,'purchase',2,NOW() - INTERVAL '5 days',1);

-- INVOICES
INSERT INTO invoices (invoice_number, customer_id, created_by, invoice_date, total_amount, discount_amount, tax_rate, tax_amount, grand_total, round_off, payment_status, invoice_type)
VALUES
('INV-1001',1,2,NOW() - INTERVAL '1 day',3000,100,13,377,3277,0,'paid','retail'),
('INV-1002',2,2,NOW(),4500,200,13,559,4859,0,'partial','wholesale'),
('INV-1003',3,2,NOW(),1500,0,13,195,1695,0,'pending','retail');

-- INVOICE ITEMS
INSERT INTO invoice_items (invoice_id, product_id, quantity, rate, discount, total)
VALUES
(1,1,1,2200,100,2100),
(1,3,10,100,0,1000),
(2,2,10,260,100,2500),
(2,3,20,100,100,1900),
(3,4,10,150,0,1500);

-- STOCK TRANSACTIONS (Sales OUT)
INSERT INTO stock_transactions (product_id, transaction_type, quantity, reference_type, reference_id, transaction_date, created_by)
VALUES
(1,'OUT',1,'invoice',1,NOW() - INTERVAL '1 day',2),
(3,'OUT',10,'invoice',1,NOW() - INTERVAL '1 day',2),
(2,'OUT',10,'invoice',2,NOW(),2),
(3,'OUT',20,'invoice',2,NOW(),2),
(4,'OUT',10,'invoice',3,NOW(),2);

-- PAYMENTS
INSERT INTO payments (invoice_id, payment_date, amount, method, payment_reference, recorded_by)
VALUES
(1,NOW() - INTERVAL '1 day',3277,'cash','CASH-1001',2),
(2,NOW(),3000,'esewa','ESEWA-202',2);

-- AUDIT LOGS
INSERT INTO audit_logs (user_id, action, table_name, record_id, ip_address, old_value, new_value)
VALUES
(1,'CREATE','products',1,'127.0.0.1',NULL,'Created Rice'),
(2,'UPDATE','invoices',2,'127.0.0.1','{\"payment_status\":\"pending\"}','{\"payment_status\":\"partial\"}');
