-- Exercise 1: Find Orders with More than One Product
-- Objective: Write a SQL query to find all orders that contain more than one product. List the order ID and the number of products in each order.

SELECT order_id, COUNT(product_id) AS number_of_products
FROM OrderDetails
GROUP BY order_id
HAVING COUNT(product_id) > 1;

-- Exercise 2: List Users Who Have Not Placed Any Orders
-- Objective: Write a SQL query to list all users who have not placed any orders. Show their usernames and email addresses.

SELECT username as Username , email as Email 
from users  
where user_id not in (select distinct user_id from Orders);

-- Exercise 3: Average Order Value by User
-- Objective: Write a SQL query to calculate the average order value for each user. Display the user's username and their average order value.

SELECT u.username, AVG(od.price_at_time_of_purchase * od.quantity) AS avg_order_value
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY u.username;

--Exercise 4: Orders and Total Amounts
--Objective: Write a SQL query to list all orders along with the total amount for each order. Include the order ID and total amount

Select O.order_id , Sum(od.price_at_time_of_purchase * od.quantity) as Total_amount 
from Orders O join OrderDetails od on O.order_id = od.order_id
group by O.order_id ; 


--Exercise 5: Average Product Rating
--Objective: Write a SQL query to calculate the average rating for each product. List the product name and its average rating.

SELECT p.name, AVG(r.rating) AS average_rating 
FROM Products p JOIN Reviews r ON p.product_id = r.product_id GROUP BY p.name;

-- Exercise 6: Users with Multiple Orders
--Objective: Write a SQL query to find users who have placed more than 2 orders. Show their username and the number of orders.

SELECT u.username, COUNT(o.order_id) AS orders_count 
FROM Users u JOIN Orders o ON u.user_id = o.user_id 
GROUP BY u.username HAVING COUNT(o.order_id) > 2;

--Exercise 7: List All Products Without Stock
--Objective: Write a SQL query to list all products that are out of stock. Display the product name.

SELECT name FROM Products WHERE stock_quantity = 0;

--Exercise 8: Find Orders Placed in the Last Week
--Objective: Write a SQL query to find all orders placed in the last week. Include the order ID and the order date.

SELECT order_id, created_at FROM Orders WHERE created_at >= NOW() - INTERVAL 7 DAY;

-- Exercise 11: Most Popular Product Categories
-- Objective: Write a SQL query to find the three most popular product categories based on the number of orders. List the category name and the number of orders.


SELECT c.name, COUNT(o.order_id) AS order_count FROM Categories c JOIN Products p ON c.category_id = p.category_id JOIN OrderDetails od ON p.product_id = od.product_id JOIN Orders o ON od.order_id = o.order_id GROUP BY c.name ORDER BY order_count DESC LIMIT 3;
Exercise 12: Users Who Have Not Reviewed Their Purchases
Objective: Write a SQL query to list users who have made at least one order but have not left any reviews. Display the username.

sql
Copy code
SELECT DISTINCT u.username FROM Users u JOIN Orders o ON u.user_id = o.user_id LEFT JOIN Reviews r ON u.user_id = r.user_id WHERE r.review_id IS NULL;
Exercise 13: Total Revenue per Category
Objective: Write a SQL query to calculate the total revenue generated from each category. List the category name and total revenue.

sql
Copy code
SELECT c.name AS category_name, SUM(od.quantity * od.price_at_time_of_purchase) AS total_revenue FROM Categories c JOIN Products p ON c.category_id = p.category_id JOIN OrderDetails od ON p.product_id = od.product_id GROUP BY c.name;
Exercise 14: Products with Above Average Price
Objective: Write a SQL query to list products with a price above the average price of all products. Include the product name and price.

sql
Copy code
SELECT name, price FROM Products WHERE price > (SELECT AVG(price) FROM Products);
