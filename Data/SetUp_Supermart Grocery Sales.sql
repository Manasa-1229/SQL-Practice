-- Create Your Database
-- Using MySQL as an example, you would start by creating a new database:

CREATE DATABASE RetailAnalytics;
USE RetailAnalytics;

---Define the Schema
-- Based on the dataset, define the schema for your database. Here's a simple example schema for the RetailAnalytics dataset:

CREATE TABLE Orders (
    OrderID VARCHAR(255) PRIMARY KEY,
    CustomerName VARCHAR(255),
    Category VARCHAR(255),
    SubCategory VARCHAR(255),
    City VARCHAR(255),
    OrderDate DATE,
    Region VARCHAR(255),
    Sales DECIMAL(10, 2),
    Discount DECIMAL(5, 2),
    Profit DECIMAL(10, 2),
    State VARCHAR(255)
);

--  Import the Dataset
-- The method of importing your dataset into the database depends on the format of your dataset and the database system you're using. If your dataset is in CSV format, and you're using MySQL, you could use the LOAD DATA INFILE command or MySQL Workbench's import wizard.

-- Example using LOAD DATA INFILE (adjust the path and options as necessary):


LOAD DATA INFILE '/path/to/your/dataset.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

