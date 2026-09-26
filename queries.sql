-- ============================================================
-- Week 2 Assignment - SQL for Data Analysis
-- Sample database: customers, orders  (see schema_and_data.sql)
-- Run against sample_database.db
-- ============================================================

-- ------------------------------------------------------------
-- Q1. Top customers by total spend (completed orders only)
--     Topics used: JOIN, WHERE, GROUP BY, ORDER BY, SUM, COUNT
-- ------------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.city,
    COUNT(o.order_id)          AS completed_orders,
    ROUND(SUM(o.amount), 2)    AS total_spend,
    ROUND(AVG(o.amount), 2)    AS avg_order_value
FROM customers AS c
JOIN orders AS o
    ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY total_spend DESC
LIMIT 5;


-- ------------------------------------------------------------
-- Q2. Average order value - overall, and split completed vs. not
--     Topics used: WHERE, aggregation (AVG, COUNT), CASE
-- ------------------------------------------------------------
SELECT
    COUNT(*)                                              AS all_orders,
    ROUND(AVG(amount), 2)                                 AS avg_order_value_all,
    ROUND(AVG(CASE WHEN status = 'completed' THEN amount END), 2)
                                                           AS avg_order_value_completed_only
FROM orders;


-- ------------------------------------------------------------
-- Q3. Average order value PER customer, with a CASE-based
--     spend tier (Gold / Silver / Bronze)
--     Topics used: JOIN, GROUP BY, ORDER BY, CASE, SUM/AVG
-- ------------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id)           AS completed_orders,
    ROUND(SUM(o.amount), 2)     AS total_spend,
    ROUND(AVG(o.amount), 2)     AS avg_order_value,
    CASE
        WHEN SUM(o.amount) >= 1000 THEN 'Gold'
        WHEN SUM(o.amount) >= 500  THEN 'Silver'
        ELSE 'Bronze'
    END AS spend_tier
FROM customers AS c
JOIN orders AS o
    ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spend DESC;


-- ------------------------------------------------------------
-- Q4. Customers who spend ABOVE the average customer spend
--     Topics used: subquery, aggregation
-- ------------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    ROUND(SUM(o.amount), 2) AS total_spend
FROM customers AS c
JOIN orders AS o
    ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.amount) > (
    -- subquery: average total spend across all customers
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(amount) AS customer_total
        FROM orders
        WHERE status = 'completed'
        GROUP BY customer_id
    )
)
ORDER BY total_spend DESC;


-- ------------------------------------------------------------
-- Q5. Order outcome breakdown by city
--     Topics used: JOIN, GROUP BY, CASE, COUNT
-- ------------------------------------------------------------
SELECT
    c.city,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN o.status = 'completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN o.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled,
    SUM(CASE WHEN o.status = 'returned'  THEN 1 ELSE 0 END) AS returned
FROM orders AS o
JOIN customers AS c
    ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_orders DESC;
