-- Top 5 Most Frequently Ordered Product Categories
SELECT 
    p.product_category_name,
    COUNT(*) AS total_items_sold
FROM olist_order_items_dataset AS oi
JOIN olist_products_dataset AS p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_items_sold DESC
LIMIT 5;

-- Total Payment Value by State (INNER JOIN)
SELECT 
    c.customer_state,
    ROUND(SUM(pay.payment_value), 2) AS total_payment
FROM olist_orders_dataset AS o
JOIN olist_customers_dataset AS c ON o.customer_id = c.customer_id
JOIN olist_order_payments_dataset AS pay ON o.order_id = pay.order_id
GROUP BY c.customer_state
ORDER BY total_payment DESC;

-- Orders with Above-Average Payment Value
SELECT 
    order_id, 
    SUM(payment_value) AS total_payment
FROM olist_order_payments_dataset
GROUP BY order_id
HAVING total_payment > (
    SELECT AVG(payment_value) FROM olist_order_payments_dataset
);

-- Average Freight Cost per Product Category
SELECT 
    p.product_category_name,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight_cost
FROM olist_order_items_dataset AS oi
JOIN olist_products_dataset AS p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_freight_cost DESC;

--  View: Average Delivery Time by State
CREATE VIEW v_avg_delivery_time_state AS
SELECT 
    c.customer_state,
    ROUND(AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)), 2) AS avg_delivery_days
FROM olist_orders_dataset AS o
JOIN olist_customers_dataset AS c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state;

SELECT * FROM v_avg_delivery_time_state ORDER BY avg_delivery_days;

-- Add Indexes to Speed Up JOINs and Filters
CREATE INDEX idx_customer_id ON olist_customers_dataset(customer_id);
CREATE INDEX idx_order_id ON olist_orders_dataset(order_id);
CREATE INDEX idx_product_id ON olist_products_dataset(product_id);
CREATE INDEX idx_order_item_id ON olist_order_items_dataset(order_id);

