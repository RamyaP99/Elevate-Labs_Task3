-- Create the database
CREATE DATABASE IF NOT EXISTS olist_ecommerce;
USE olist_ecommerce;

-- Customers table
CREATE TABLE olist_customers_dataset (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

-- Orders table
CREATE TABLE olist_orders_dataset (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES olist_customers_dataset(customer_id)
);

-- Order Items table
CREATE TABLE olist_order_items_dataset (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY (order_id, order_item_id)
);

-- Products table
CREATE TABLE olist_products_dataset (
    product_id VARCHAR(50),
    product_category_name VARCHAR(50),
    product_name_length INT,
    product_description_length INT
);

-- Sellers table
CREATE TABLE olist_sellers_dataset (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

-- Payments table
CREATE TABLE olist_order_payments_dataset (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);

-- Importing CSV Data

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv"
INTO TABLE olist_customers_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv"
INTO TABLE olist_order_items_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv"
INTO TABLE olist_order_payments_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv"
INTO TABLE olist_orders_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, customer_id, order_status, @order_purchase_timestamp, @order_approved_at, @order_delivered_carrier_date, @order_delivered_customer_date, @order_estimated_delivery_date)
SET
    order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
    order_approved_at = NULLIF(@order_approved_at, ''),
    order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
    order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv"
INTO TABLE olist_products_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id,product_category_name, @product_name_length, @product_description_length,@dummy1, @dummy2,@dummy3, @dummy4,@dummy5)
SET
    product_name_length = NULLIF(@product_name_length, ''),
    product_description_length = NULLIF(@product_description_length, '');


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv"
INTO TABLE olist_sellers_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

