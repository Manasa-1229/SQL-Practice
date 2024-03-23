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

--Exercise 4: Self Join - Finding Pairs of Products in the Same Category
-- Objective: Write a SQL query using a self join to find all pairs of products that are in the same category and have a price difference of less than $50.


SELECT A.name AS ProductA, B.name AS ProductB, A.category_id
FROM Products A, Products B
WHERE A.product_id <> B.product_id
AND A.category_id = B.category_id
AND ABS(A.price - B.price) < 50;

--Exercise 5: CTE - Hierarchical Category Structure
--Objective: Use a Common Table Expression to list all categories along with their subcategories to any depth in a hierarchical format. Assume that the Categories table has category_id and parent_id columns.


WITH RECURSIVE CategoryPath AS (
  SELECT category_id, name, parent_id, name AS path
  FROM Categories
  WHERE parent_id IS NULL
  UNION ALL
  SELECT c.category_id, c.name, c.parent_id, CONCAT(cp.path, ' > ', c.name)
  FROM CategoryPath cp
  JOIN Categories c ON cp.category_id = c.parent_id
)
SELECT path FROM CategoryPath ORDER BY path;

--Exercise 6: Window Function - Ranking Products by Price Within Each Category
--Objective: Use a window function to rank products by price within each category. Display the category, product name, price, and rank.


SELECT category_id, name, price,
       RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS price_rank
FROM Products;

--Exercise 7: CTE and Window Function - Monthly Sales Growth
--Objective: Calculate the month-over-month sales growth percentage for each product. Use CTEs to aggregate monthly sales and window functions to calculate the growth percentage.


WITH MonthlySales AS (
  SELECT product_id,
         EXTRACT(YEAR FROM created_at) AS year,
         EXTRACT(MONTH FROM created_at) AS month,
         SUM(quantity * price_at_time_of_purchase) AS total_sales
  FROM OrderDetails
  JOIN Orders ON OrderDetails.order_id = Orders.order_id
  GROUP BY product_id, year, month
),
SalesGrowth AS (
  SELECT product_id, year, month, total_sales,
         LAG(total_sales) OVER(PARTITION BY product_id ORDER BY year, month) AS prev_month_sales
  FROM MonthlySales
)
SELECT product_id, year, month,
       ROUND(((total_sales - prev_month_sales) / prev_month_sales) * 100, 2) AS growth_percentage
FROM SalesGrowth
WHERE prev_month_sales IS NOT NULL;

--Exercise 8: Self Join - Identifying Users with Common Orders
--Objective: Find pairs of users who have ordered the same product. List the user IDs and the common product IDs they've ordered.

SELECT A.user_id AS User1, B.user_id AS User2, A.product_id
FROM OrderDetails A
JOIN OrderDetails B ON A.product_id = B.product_id AND A.user_id < B.user_id
JOIN Orders OA ON A.order_id = OA.order_id
JOIN Orders OB ON B.order_id = OB.order_id
GROUP BY A.user_id, B.user_id, A.product_id;
