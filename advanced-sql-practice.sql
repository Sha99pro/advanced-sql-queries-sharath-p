CREATE DATABASE If NOT EXISTS online_store;
USE online_store;

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;

CREATE TABLE customers (
 id INT PRIMARY KEY AUTO_INCREMENT,
 first_name VARCHAR(50),
 last_name VARCHAR(50)
);

CREATE TABLE orders (
 id INT PRIMARY KEY,
 customer_id INT NULL,
 order_date DATE,
 total_amount DECIMAL(10, 2),
 FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (id, first_name, last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);



-- Task 1: INNER JOIN
-- Display orders with matching customer names.
SELECT orders.id, customers.first_name, customers.last_name,
       orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.id;


-- Task 2: LEFT JOIN
-- Display all orders, including orders without a registered customer.
SELECT orders.id, customers.first_name, customers.last_name,
       orders.total_amount
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.id;


-- Task 3: GROUP BY with SUM
-- Calculate the total amount spent for each customer ID.
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;


-- Task 4: GROUP BY with COUNT
-- Count the number of orders for each customer.
SELECT customer_id, COUNT(id) AS order_count
FROM orders
GROUP BY customer_id;


-- Task 5: WHERE clause
-- Find orders with an amount greater than $200.
SELECT *
FROM orders
WHERE total_amount > 200;


-- Task 6: HAVING clause
-- Find customer IDs whose total spending exceeds $200.
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200;


-- Task 7: Scalar subquery
-- Find orders equal to or greater than the average order amount.
SELECT *
FROM orders
WHERE total_amount >= (
    SELECT AVG(total_amount)
    FROM orders
);


-- Task 8: Column subquery
-- Find orders placed by customers with the last name Smith.
SELECT *
FROM orders
WHERE customer_id IN (
    SELECT id
    FROM customers
    WHERE last_name = 'Smith'
);


-- Task 9: Table subquery
-- Retrieve order dates using a subquery.
SELECT order_date
FROM (
    SELECT id, order_date, total_amount
    FROM orders
) AS order_summary;


-- Task 10: LEFT JOIN with IS NULL
-- Find customers who have not placed any orders.
SELECT customers.id, customers.first_name, customers.last_name
FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id
WHERE orders.id IS NULL;

SELECT * FROM customers;
SELECT * FROM orders;


