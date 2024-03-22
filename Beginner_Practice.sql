-- Exercise 1: Retrieve User Information
-- Objective: Write a SQL query to retrieve all user information from the Users table.
SELECT * FROM Users;

-- Exercise 2: List All Products with Prices Higher than $100
-- Objective: Write a SQL query to list the names and prices of products that are priced over $100.
SELECT name, price FROM Products WHERE price > 100;

-- Exercise 3: Count the Number of Products in Each Category
-- Objective: Write a SQL query to count the number of products in each category. Display the category name and the count.
SELECT c.name , count(p.product_id) from Categories c join Products p on c.category_id = p.category_id group by c.name ;

-- Exercise 4: List All Categories
-- Objective: Write a SQL query to list all categories' names and descriptions.
SELECT name, description FROM Categories;

-- Exercise 5: Find Products Under $50
-- Objective: Write a SQL query to find all products with a price under $50. Display the product name and price.
SELECT name, price FROM Products WHERE price < 50;

-- Exercise 6: List Recent Users
-- Objective: Write a SQL query to list all users who joined in the last 30 days. Show their username and the date they joined.
SELECT username, created_at FROM Users WHERE created_at >= NOW() - INTERVAL 30 DAY;

-- Exercise 7: Count Products in Stock
-- Objective: Write a SQL query to count the total number of products currently in stock.
SELECT COUNT(*) AS total_in_stock FROM Products WHERE stock_quantity > 0;

-- Exercise 8: List Products and Their Categories
-- Objective: Write a SQL query to list each product's name along with the name of its category.
SELECT p.name AS product_name, c.name AS category_name FROM Products p JOIN Categories c ON p.category_id = c.category_id;
