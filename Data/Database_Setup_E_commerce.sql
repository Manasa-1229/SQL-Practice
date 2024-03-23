-- Step 1: Create the Database
CREATE DATABASE IF NOT EXISTS ecommerce_website;
USE ecommerce_website;
-- Step 2: Create Tables 
-- Users Table
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

-- Categories Table
CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES Categories(category_id)
);

-- Products Table
CREATE TABLE IF NOT EXISTS Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    status VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- OrderDetails Table
CREATE TABLE IF NOT EXISTS OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_time_of_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- Reviews Table
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Addresses Table
CREATE TABLE IF NOT EXISTS Addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255),
    zip_code VARCHAR(10),
    country VARCHAR(255) NOT NULL,
    is_primary BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- PaymentMethods Table
CREATE TABLE IF NOT EXISTS PaymentMethods (
    payment_method_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    card_number VARCHAR(16) NOT NULL,
    expiry_date DATE NOT NULL,
    card_name VARCHAR(255) NOT NULL,
    billing_address_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (billing_address_id) REFERENCES Addresses(address_id)
);

-- Insert the data into tables
INSERT INTO Users (username, email, password) VALUES
('AliceWonder', 'alice@example.com', 'alicepass'),
('BobBuilder', 'bob@example.com', 'bobpass'),
('CharlieDay', 'charlie@example.com', 'charliepass'),
('john_doe', 'john.doe@example.com', 'johnpass'),
('jane_doe', 'jane.doe@example.com', 'janepass');

INSERT INTO Categories (name, description) VALUES
('Electronics', 'Gadgets, devices, and more'),
('Books', 'From fiction to non-fiction, a book for everyone'),
('Clothing', 'Fashionable choices for every season');

-- Insert subcategories for Electronics
INSERT INTO Categories (name, description, parent_id) VALUES
('Smartphones', 'Latest smartphones and accessories', 1),
('Laptops', 'For gaming, work, and everything in between', 1);

-- Electronics
INSERT INTO Products (name, description, price, stock_quantity, category_id) VALUES
('SuperPhone X', 'The latest and greatest in smartphone technology', 999.99, 100, 4),
('Laptop Pro 15"', 'A powerful laptop for professionals and creators', 1599.99, 50, 5);

-- Books
INSERT INTO Products (name, description, price, stock_quantity, category_id) VALUES
('The Final Frontier', 'A journey through space and time', 19.99, 100, 2),
('Fashion Forward', 'Exploring the past, present, and future of fashion', 29.99, 100, 3);

INSERT INTO Orders (user_id, status) VALUES
(1, 'Shipped'),
(2, 'Processing'),
(3, 'Delivered');

-- Assuming each user ordered one type of product
INSERT INTO OrderDetails (order_id, product_id, quantity, price_at_time_of_purchase) VALUES
(1, 1, 1, 999.99),
(2, 2, 1, 1599.99),
(3, 3, 2, 19.99);  -- Charlie ordered 2 copies of "The Final Frontier"

INSERT INTO Reviews (product_id, user_id, rating, comment) VALUES
(1, 1, 5, 'Absolutely love my new SuperPhone X! Highly recommend.'),
(2, 2, 4, 'Laptop Pro is great, but battery life could be better.'),
(3, 3, 5, 'A fascinating read. Couldn’t put it down!');

INSERT INTO Addresses (user_id, street, city, state, zip_code, country, is_primary) VALUES
(1, '123 Apple St', 'Techville', 'CA', '12345', 'USA', true),
(2, '456 Builder Rd', 'Construct City', 'NY', '23456', 'USA', true),
(3, '789 Sunshine Ave', 'Daytown', 'FL', '34567', 'USA', true);

INSERT INTO PaymentMethods (user_id, card_number, expiry_date, card_name, billing_address_id) VALUES
(1, '1111222233334444', '2025-12-31', 'Alice Wonder', 1),
(2, '5555666677778888', '2024-11-30', 'Bob Builder', 2),
(3, '9999000011112222', '2023-10-31', 'Charlie Day', 3);

