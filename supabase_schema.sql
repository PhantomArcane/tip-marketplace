-- Run this script in your Supabase SQL Editor to create the necessary tables

-- 1. Users Table
CREATE TABLE public.tip_users (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL, -- Storing btoa password as in original app (for a real app, use Supabase Auth!)
    course TEXT DEFAULT '',
    bio TEXT DEFAULT '',
    avatar TEXT,
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Products Table
CREATE TABLE public.tip_products (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    price NUMERIC NOT NULL,
    category TEXT,
    image TEXT, -- Base64 string or URL
    condition TEXT,
    seller_id TEXT REFERENCES public.tip_users(id) ON DELETE CASCADE,
    seller_name TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    views INTEGER DEFAULT 0
);

-- 3. Messages Table
CREATE TABLE public.tip_messages (
    id TEXT PRIMARY KEY,
    sender_id TEXT REFERENCES public.tip_users(id) ON DELETE CASCADE,
    sender_name TEXT,
    receiver_id TEXT REFERENCES public.tip_users(id) ON DELETE CASCADE,
    receiver_name TEXT,
    text TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    read BOOLEAN DEFAULT FALSE
);

-- 4. Wishlist Table
CREATE TABLE public.tip_wishlist (
    user_id TEXT REFERENCES public.tip_users(id) ON DELETE CASCADE,
    product_id TEXT REFERENCES public.tip_products(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, product_id)
);

-- Allow anonymous access for the student project (Disable Row Level Security for now to match localStorage ease of use)
ALTER TABLE public.tip_users DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.tip_products DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.tip_messages DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.tip_wishlist DISABLE ROW LEVEL SECURITY;
