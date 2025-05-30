# Elevate-Labs_Task3

#### Overview

This project demonstrates SQL-based data analysis on the Brazilian E-commerce Public Dataset by Olist, available on Kaggle (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
The goal is to extract meaningful insights, such as top product categories, payment trends, freight costs, and delivery times, while demonstrating best practices in SQL query design and performance optimization.

#### Dataset Description

The dataset includes multiple CSV files, each representing a table in the database:

* olist_orders_dataset.csv: Order details (order ID, customer ID, status, timestamps).
* olist_order_items_dataset.csv: Items in each order (order ID, product ID, price, freight value).
* olist_products_dataset.csv: Product information (product ID, category).
* olist_customers_dataset.csv: Customer details (customer ID, state).
* olist_order_payments_dataset.csv: Payment information (order ID, payment value).

#### Create the Database:

Run the following SQL to create a database:

        sql

        CREATE DATABASE olist_ecommerce;
        USE olist_ecommerce;

#### Create Tables:

Based on the Olist dataset, create tables matching the CSV structure. Here’s an example for key tables (adjust column types if needed):

        sql

         -- Table for orders
         CREATE TABLE orders (
             order_id VARCHAR(50) PRIMARY KEY,
             customer_id VARCHAR(50),
             order_status VARCHAR(20),
             order_purchase_timestamp DATETIME,
             order_delivered_timestamp DATETIME
         );

#### Import Data:

I encountered the --secure-file-priv error,

1) Moved CSV files to allowed directory

   --Check the allowed directory:
  
       sql

       SHOW VARIABLES LIKE 'secure_file_priv';

2) Enabled local_infile:

        SHOW VARIABLES LIKE 'local_infile';
        SET GLOBAL local_infile = 1;

3) Imported csv data to created tables: Using SQL LOAD DATA
   
         LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv"
         INTO TABLE olist_customers_dataset
         FIELDS TERMINATED BY ',' 
         ENCLOSED BY '"'
         LINES TERMINATED BY '\n'
         IGNORE 1 ROWS;
    
#### SQL Queries

1. Top 5 Most Frequently Ordered Product Categories

   Purpose: Identify the top 5 product categories by the number of items sold.

    Insight: Identifies the most popular product categories by sales volume.

2. Total Payment Value by State (INNER JOIN)

   Purpose: Calculate the total payment value for orders in each Brazilian state.

   Insight: Reveals which states contribute the most revenue.

3. Orders with Above-Average Payment Value (Subquery)

   Purpose: Find orders with a total payment value exceeding the dataset's average payment value.

   Insight: Highlights high-value orders that are above average in payment.

4. Average Freight Cost per Product Category

   Purpose: Compute the average freight cost for each product category.

   Insight: Helps identify categories with high delivery costs.

5. View: Average Delivery Time by State

   Purpose: Create a reusable view to show the average delivery time (in days) by customer state.

   Insight: Tracks average shipping duration by location.

6. Optimize Queries with Indexes

   Purpose: Add indexes to improve query performance for JOINs and filters.

   Impact: Improves performance for large-table queries.







