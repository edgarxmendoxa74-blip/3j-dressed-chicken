-- Supabase Schema for 3J Dressed Chicken Store
-- This script creates the tables and seeds default data (categories, menu items, settings).

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Store Settings Table
CREATE TABLE IF NOT EXISTS store_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    store_name TEXT NOT NULL DEFAULT '3J Dressed Chicken Store',
    address TEXT,
    contact TEXT,
    logo_url TEXT,
    banner_images JSONB DEFAULT '[]',
    open_time TIME DEFAULT '16:00',
    close_time TIME DEFAULT '01:00',
    manual_status TEXT DEFAULT 'auto',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Menu Items Table
CREATE TABLE IF NOT EXISTS menu_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    promo_price DECIMAL(10, 2),
    image TEXT,
    out_of_stock BOOLEAN DEFAULT FALSE,
    sort_order INTEGER DEFAULT 0,
    variations JSONB DEFAULT '[]', -- [{name, price, disabled}]
    flavors JSONB DEFAULT '[]',    -- [{name, disabled}] or [string]
    addons JSONB DEFAULT '[]',      -- [{name, price, disabled}]
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Order Types Table
CREATE TABLE IF NOT EXISTS order_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Payment Settings Table
CREATE TABLE IF NOT EXISTS payment_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    account_number TEXT,
    account_name TEXT,
    qr_url TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Orders Table
CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_number SERIAL,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    order_type TEXT NOT NULL,
    payment_method TEXT NOT NULL,
    customer_details JSONB NOT NULL, -- {name, phone, tableNumber, address, etc}
    items JSONB NOT NULL,            -- Array of strings or object summaries
    total_amount DECIMAL(10, 2) NOT NULL,
    status TEXT DEFAULT 'Pending'    -- Pending, Preparing, Ready, Completed, Cancelled
);


-- ============================================================================
-- INITIAL SEED DATA (Categories & Menu Items)
-- ============================================================================

-- Insert Store Settings
INSERT INTO store_settings (store_name, address, contact, open_time, close_time, manual_status)
VALUES (
    '3J Dressed Chicken Store',
    'Main Street, Store Address',
    '+63 900 000 0000',
    '16:00',
    '01:00',
    'auto'
)
ON CONFLICT DO NOTHING;

-- Insert Order Types
INSERT INTO order_types (name, is_active) VALUES
('Pick Up', TRUE),
('Delivery', TRUE)
ON CONFLICT DO NOTHING;

-- Insert Payment Settings
INSERT INTO payment_settings (name, account_number, account_name, is_active) VALUES
('GCash', '09123456789', '3J Dressed Chicken Store', TRUE),
('Cash on Delivery', 'N/A', 'Cash Payment', TRUE),
('Maya', '09123456789', '3J Dressed Chicken Store', TRUE)
ON CONFLICT DO NOTHING;

-- Insert Categories and Menu Items using a CTE script
WITH cat_fresh AS (
    INSERT INTO categories (name, sort_order) VALUES ('Fresh Chicken', 1)
    RETURNING id
),
cat_frozen AS (
    INSERT INTO categories (name, sort_order) VALUES ('Frozen Goods', 2)
    RETURNING id
),
cat_marinated AS (
    INSERT INTO categories (name, sort_order) VALUES ('Marinated Items', 3)
    RETURNING id
),
cat_ready AS (
    INSERT INTO categories (name, sort_order) VALUES ('Ready to Eat', 4)
    RETURNING id
)

-- Insert Menu Items into Fresh Chicken
INSERT INTO menu_items (category_id, name, description, price, promo_price, image, sort_order, variations, flavors, addons)
SELECT id, 'Whole Dressed Chicken', 'Premium quality fresh dressed chicken.', 220.00, NULL,
    'https://images.unsplash.com/photo-1606787366850-de6330128bfc?auto=format&fit=crop&w=400&q=80',
    1,
    '[{"name": "1kg", "price": 220}, {"name": "1/2 kg", "price": 110}, {"name": "1/4 kg", "price": 60}]'::jsonb,
    '["Whole", "Cuts"]'::jsonb,
    '[]'::jsonb
FROM cat_fresh
UNION ALL
SELECT id, 'Chicken Breast (Boneless)', 'Fresh boneless chicken breast, perfect for fillets.', 260.00, NULL,
    'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&w=400&q=80',
    2,
    '[{"name": "500g", "price": 140}, {"name": "1kg", "price": 260}]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb
FROM cat_fresh

-- Insert Menu Items into Marinated Items
UNION ALL
SELECT id, 'Marinated Roast Chicken', 'Ready-to-bake chicken with our secret spice blend.', 320.00, 299.00,
    'https://images.unsplash.com/photo-1594464083313-2dc704bb43c8?auto=format&fit=crop&w=400&q=80',
    1,
    '[]'::jsonb,
    '["Classic Garlic", "Spicy BBQ", "Honey Soy"]'::jsonb,
    '[]'::jsonb
FROM cat_marinated
UNION ALL
SELECT id, 'Chicken Wings (Buffalo Style)', 'Marinated wings ready for frying or baking.', 180.00, NULL,
    'https://images.unsplash.com/photo-1527477396000-e27163b481c2?auto=format&fit=crop&w=400&q=80',
    2,
    '[{"name": "Set of 6", "price": 180}, {"name": "Set of 12", "price": 340}]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb
FROM cat_marinated

-- Insert Menu Items into Frozen Goods
UNION ALL
SELECT id, 'Chicken Nuggets', 'Premium frozen chicken nuggets for kids and snacks.', 150.00, NULL,
    'https://images.unsplash.com/photo-1562967914-608f82629710?auto=format&fit=crop&w=400&q=80',
    1,
    '[{"name": "250g", "price": 85}, {"name": "500g", "price": 150}]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb
FROM cat_frozen
UNION ALL
SELECT id, 'Chicken Longganisa', 'Authentic Filipino style frozen chicken sausage.', 120.00, NULL,
    'https://images.unsplash.com/photo-1541518763669-27f714620583?auto=format&fit=crop&w=400&q=80',
    2,
    '[{"name": "Standard Pack", "price": 120}, {"name": "Family Pack", "price": 220}]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb
FROM cat_frozen;

-- CLEANUP SECTION (Uncomment to reset all data)
-- DELETE FROM orders;
-- DELETE FROM menu_items;
-- DELETE FROM categories;
-- DELETE FROM payment_settings;
-- DELETE FROM store_settings;
-- DELETE FROM order_types;
