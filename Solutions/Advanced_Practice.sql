---Exercise 1: Top 3 Most Expensive Products in Each Category
---Objective: Write a SQL query to find the top 3 most expensive products in each category. List the category name, product name, and price.

SELECT c.name AS category_name, p.name AS product_name, p.price
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
ORDER BY c.name, p.price DESC
LIMIT 3;

--Exercise 2: Products Without Reviews
--Objective: Write a SQL query to list all products that have not received any reviews. Display the product name and price.

SELECT name, price
FROM Products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM Reviews);

--Exercise 3: Total Sales Per Month
--Objective: Write a SQL query to calculate the total sales per month. Display the month, year, and total sales amount.

SELECT YEAR(o.created_at) AS year, MONTH(o.created_at) AS month, SUM(od.price_at_time_of_purchase * od.quantity) AS total_sales
FROM Orders o
JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY YEAR(o.created_at), MONTH(o.created_at);
