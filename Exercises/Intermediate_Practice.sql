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

