-- RetailAnalytics.sql
-- Exploratory Data Analysis for Supermart Grocery Sales Data

-- Use the correct database
USE SalesData;

-- Basic Summary of Sales Data
SELECT 
    COUNT(*) AS TotalTransactions,
    SUM(Sales) AS TotalSales,
    AVG(Sales) AS AverageSales,
    MIN(Sales) AS MinimumSale,
    MAX(Sales) AS MaximumSale,
    SUM(Discount) AS TotalDiscountGiven,
    AVG(Discount) AS AverageDiscount
FROM SupermartGrocerySales;

-- output
-- | TotalTransactions | TotalSales | AverageSales | MinimumSale | MaximumSale | TotalDiscountGiven | AverageDiscount |
-- | ----------------- | ---------- | ------------ | ----------- | ----------- | ------------------ | --------------- |
-- | 9994              | 14956982   | 1496.596     | 500         | 2500        | 2266.81            | 0.226817        |


-- Total Sales by Category
SELECT 
    Category,
    COUNT(*) AS TotalOrders,
    SUM(Sales) AS TotalSales,
    AVG(Sales) AS AverageSalePerCategory
FROM SupermartGrocerySales
GROUP BY Category
ORDER BY TotalSales DESC; 

-- output :
| Category          | TotalOrders | TotalSales | AverageSalePerCategory |
| ----------------- | ----------- | ---------- | ---------------------- |
| Eggs, Meat & Fish | 1490        | 2267401    | 1521.746               |
| Snacks            | 1514        | 2237546    | 1477.904               |
| Food Grains       | 1398        | 2115272    | 1513.07                |
| Bakery            | 1413        | 2112281    | 1494.891               |
| Fruits & Veggies  | 1418        | 2100727    | 1481.472               |
| Beverages         | 1400        | 2085313    | 1489.509               |
| Oil & Masala      | 1361        | 2038442    | 1497.753               |

-- Sales by Sub-Category
SELECT 
    SubCategory,
    COUNT(*) AS TotalOrders,
    SUM(Sales) AS TotalSales,
    AVG(Sales) AS AverageSalePerSubCategory
FROM SupermartGrocerySales
GROUP BY SubCategory
ORDER BY TotalSales DESC;

-- Output :
| SubCategory        | TotalOrders | TotalSales | AverageSalePerSubCategory |
| ------------------ | ----------- | ---------- | ------------------------- |
| Health Drinks      | 719         | 1051439    | 1462.363                  |
| Soft Drinks        | 681         | 1033874    | 1518.17                   |
| Cookies            | 520         | 768213     | 1477.333                  |
| Breads & Buns      | 502         | 742586     | 1479.255                  |
| Noodles            | 495         | 735435     | 1485.727                  |
| Chocolates         | 499         | 733898     | 1470.738                  |
| Masalas            | 463         | 697480     | 1506.436                  |
| Cakes              | 452         | 685612     | 1516.841                  |
| Biscuits           | 459         | 684083     | 1490.377                  |
| Spices             | 447         | 672876     | 1505.315                  |
| Edible Oil & Ghee  | 451         | 668086     | 1481.344                  |
| Mutton             | 394         | 611200     | 1551.269                  |
| Eggs               | 379         | 575156     | 1517.562                  |
| Fish               | 369         | 560548     | 1519.1                    |
| Organic Staples    | 372         | 558929     | 1502.497                  |
| Fresh Fruits       | 369         | 551212     | 1493.8                    |
| Atta & Flour       | 353         | 534649     | 1514.586                  |
| Fresh Vegetables   | 354         | 525842     | 1485.429                  |
| Dals & Pulses      | 343         | 523371     | 1525.863                  |
| Chicken            | 348         | 520497     | 1495.681                  |
| Organic Vegetables | 347         | 520271     | 1499.34                   |
| Organic Fruits     | 348         | 503402     | 1446.558                  |
| Rice               | 330         | 498323     | 1510.07                   |


  -- As we imported the dataset directly from the CSV to Database Order date is in TEXT data type to perfor any date opperations we need to change the format to DATE first. You can execute the following script for the same:
ALTER TABLE SupermartGrocerySales ADD COLUMN TempOrderDate DATE;
UPDATE SupermartGrocerySales
SET TempOrderDate = STR_TO_DATE(OrderDate, '%m/%d/%Y');
ALTER TABLE SupermartGrocerySales DROP COLUMN OrderDate;
ALTER TABLE SupermartGrocerySales CHANGE COLUMN TempOrderDate OrderDate DATE;
SELECT OrderDate FROM SupermartGrocerySales LIMIT 10;

-- Sales Over Time
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(Sales) AS TotalSales,
    COUNT(*) AS NumberOfOrders,
    AVG(Sales) AS AverageSales
FROM SupermartGrocerySales
GROUP BY Month
ORDER BY Month;

-- OUTPUT :
| Month   | TotalSales | NumberOfOrders | AverageSales |
| ------- | ---------- | -------------- | ------------ |
| 2015-01 | 122497     | 79             | 1550.595     |
| 2015-02 | 66030      | 46             | 1435.435     |
| 2015-03 | 247156     | 157            | 1574.242     |
| 2015-04 | 203258     | 135            | 1505.615     |
| 2015-05 | 164263     | 122            | 1346.418     |
| 2015-06 | 206064     | 135            | 1526.4       |
| 2015-07 | 220986     | 143            | 1545.357     |
| 2015-08 | 230161     | 153            | 1504.32      |
| 2015-09 | 382200     | 268            | 1426.119     |
| 2015-10 | 241726     | 159            | 1520.289     |
| 2015-11 | 480979     | 318            | 1512.513     |
| 2015-12 | 410279     | 278            | 1475.824     |
| 2016-01 | 89009      | 58             | 1534.638     |
| 2016-02 | 90823      | 64             | 1419.109     |
| 2016-03 | 212164     | 138            | 1537.42      |
| 2016-04 | 237272     | 160            | 1482.95      |
| 2016-05 | 222722     | 146            | 1525.493     |
| 2016-06 | 205388     | 138            | 1488.319     |
| 2016-07 | 215776     | 140            | 1541.257     |
| 2016-08 | 229543     | 159            | 1443.667     |
| 2016-09 | 429658     | 293            | 1466.41      |
| 2016-10 | 249639     | 166            | 1503.849     |
| 2016-11 | 477720     | 324            | 1474.444     |
| 2016-12 | 472245     | 316            | 1494.446     |
| 2017-01 | 131727     | 89             | 1480.079     |
| 2017-02 | 132982     | 83             | 1602.193     |
| 2017-03 | 238956     | 163            | 1465.988     |
| 2017-04 | 247773     | 170            | 1457.488     |
| 2017-05 | 332524     | 225            | 1477.884     |
| 2017-06 | 291454     | 199            | 1464.593     |
| 2017-07 | 315531     | 201            | 1569.806     |
| 2017-08 | 256089     | 176            | 1455.051     |
| 2017-09 | 546728     | 363            | 1506.138     |
| 2017-10 | 308026     | 196            | 1571.561     |
| 2017-11 | 551815     | 370            | 1491.392     |
| 2017-12 | 518307     | 352            | 1472.463     |
| 2018-01 | 234739     | 155            | 1514.445     |
| 2018-02 | 166267     | 107            | 1553.897     |
| 2018-03 | 355704     | 238            | 1494.555     |
| 2018-04 | 310150     | 203            | 1527.833     |
| 2018-05 | 367411     | 242            | 1518.227     |
| 2018-06 | 354902     | 245            | 1448.58      |
| 2018-07 | 337092     | 226            | 1491.558     |
| 2018-08 | 331014     | 218            | 1518.413     |
| 2018-09 | 705680     | 459            | 1537.429     |
| 2018-10 | 443898     | 298            | 1489.591     |
| 2018-11 | 683410     | 459            | 1488.911     |
| 2018-12 | 687245     | 462            | 1487.543     |

-- Top 10 Profitable Sales
SELECT *
FROM SupermartGrocerySales
ORDER BY Profit DESC
LIMIT 10;

-- ouput
| Order ID | CustomerName | Category          | SubCategory        | City           | Region  | Sales | Discount | Profit  | State      | OrderDate |
| -------- | ------------ | ----------------- | ------------------ | -------------- | ------- | ----- | -------- | ------- | ---------- | --------- |
| OD3160   | Haseena      | Bakery            | Cakes              | Cumbum         | Central | 2491  | 0.26     | 1120.95 | Tamil Nadu | 4-Sep-17  |
| OD3468   | Verma        | Fruits & Veggies  | Fresh Fruits       | Theni          | Central | 2490  | 0.24     | 1120.5  | Tamil Nadu | 16-Feb-15 |
| OD3437   | Yadav        | Bakery            | Breads & Buns      | Theni          | Central | 2469  | 0.29     | 1111.05 | Tamil Nadu | 16-Dec-15 |
| OD8135   | Aditi        | Bakery            | Biscuits           | Coimbatore     | East    | 2452  | 0.18     | 1103.4  | Tamil Nadu | 18-Sep-16 |
| OD9783   | Komal        | Snacks            | Cookies            | Karur          | Central | 2450  | 0.21     | 1102.5  | Tamil Nadu | 29-Mar-17 |
| OD1116   | Vinne        | Eggs, Meat & Fish | Chicken            | Madurai        | West    | 2439  | 0.3      | 1097.55 | Tamil Nadu | 4-Jul-17  |
| OD4944   | Willams      | Beverages         | Soft Drinks        | Ramanadhapuram | Central | 2434  | 0.29     | 1095.3  | Tamil Nadu | 21-Nov-18 |
| OD1305   | Akash        | Fruits & Veggies  | Organic Vegetables | Salem          | East    | 2432  | 0.34     | 1094.4  | Tamil Nadu | 1-Dec-17  |
| OD1808   | Esther       | Bakery            | Biscuits           | Trichy         | West    | 2429  | 0.11     | 1093.05 | Tamil Nadu | 21-Nov-18 |
| OD3145   | Sabeela      | Oil & Masala      | Masalas            | Krishnagiri    | Central | 2478  | 0.13     | 1090.32 | Tamil Nadu | 29-Dec-17 |


-- Discount Impact Analysis
SELECT 
    Discount,
    AVG(Profit) AS AverageProfit,
    SUM(Sales) AS TotalSales,
    COUNT(*) AS NumberOfOrders
FROM SupermartGrocerySales
GROUP BY Discount
ORDER BY AverageProfit;

--ouput
| Discount | AverageProfit | TotalSales | NumberOfOrders |
| -------- | ------------- | ---------- | -------------- |
| 0.3      | 358.5647      | 556561     | 378            |
| 0.34     | 360.7307      | 590111     | 409            |
| 0.1      | 361.8884      | 532943     | 366            |
| 0.18     | 362.0085      | 580139     | 392            |
| 0.12     | 362.9447      | 559913     | 375            |
| 0.22     | 364.2781      | 569922     | 393            |
| 0.35     | 364.3605      | 604142     | 413            |
| 0.24     | 364.5047      | 578783     | 387            |
| 0.2      | 371.0516      | 517513     | 346            |
| 0.19     | 371.4243      | 625800     | 415            |
| 0.33     | 372.9349      | 573343     | 389            |
| 0.15     | 373.7108      | 550520     | 371            |
| 0.14     | 374.3074      | 575624     | 381            |
| 0.21     | 374.6135      | 606676     | 402            |
| 0.25     | 375.7522      | 657312     | 438            |
| 0.31     | 376.7867      | 565232     | 369            |
| 0.17     | 378.5692      | 499122     | 336            |
| 0.28     | 379.327       | 551009     | 374            |
| 0.11     | 380.7647      | 556585     | 372            |
| 0.16     | 383.1322      | 593699     | 386            |
| 0.27     | 384.0618      | 631069     | 422            |
| 0.26     | 387.9022      | 609538     | 404            |
| 0.23     | 387.9248      | 609026     | 392            |
| 0.29     | 389.6921      | 537835     | 366            |
| 0.32     | 394.2036      | 598340     | 376            |
| 0.13     | 396.2335      | 526225     | 342            |

-- Sales by State
SELECT 
    State,
    SUM(Sales) AS TotalSales,
    COUNT(*) AS NumberOfOrders,
    AVG(Profit) AS AverageProfit
FROM SupermartGrocerySales
GROUP BY State
ORDER BY TotalSales DESC;

-- output Since the data is from single state result has only one state
| State      | TotalSales | NumberOfOrders | AverageProfit |
| ---------- | ---------- | -------------- | ------------- |
| Tamil Nadu | 14956982   | 9994           | 374.9371      |

-- Customers with Most Orders
SELECT 
    CustomerName,
    COUNT(*) AS NumberOfOrders,
    SUM(Sales) AS TotalSales
FROM SupermartGrocerySales
GROUP BY CustomerName
ORDER BY NumberOfOrders DESC
LIMIT 5;

-- Output
| CustomerName | NumberOfOrders | TotalSales |
| ------------ | -------------- | ---------- |
| Amrish       | 227            | 333351     |
| Krithika     | 224            | 334361     |
| Arutra       | 218            | 325720     |
| Verma        | 218            | 331665     |
| Shah         | 215            | 318588     |

-- Sales and Profit Correlation Analysis
SELECT 
    ROUND(Sales, -2) AS SalesRoundedToNearestHundred,
    AVG(Profit) AS AverageProfit
FROM SupermartGrocerySales
GROUP BY SalesRoundedToNearestHundred
ORDER BY SalesRoundedToNearestHundred;

--output 
| SalesRoundedToNearestHundred | AverageProfit |
| ---------------------------- | ------------- |
| 500                          | 123.6739      |
| 600                          | 153.5259      |
| 700                          | 169.1135      |
| 800                          | 196.9703      |
| 900                          | 222.5908      |
| 1000                         | 257.9673      |
| 1100                         | 279.5868      |
| 1200                         | 305.3173      |
| 1300                         | 318.2154      |
| 1400                         | 343.6741      |
| 1500                         | 365.0027      |
| 1600                         | 414.0417      |
| 1700                         | 415.0625      |
| 1800                         | 450.4184      |
| 1900                         | 485.3085      |
| 2000                         | 509.2359      |
| 2100                         | 531.6312      |
| 2200                         | 555.5207      |
| 2300                         | 577.6221      |
| 2400                         | 600.1231      |
| 2500                         | 597.375       |


-- Potentially More Queries to Analyze the Trends, Seasonality, Customer Behavior, etc.

-- Monthly Sales Trend
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(Sales) AS TotalSales
FROM SupermartGrocerySales
GROUP BY Month
ORDER BY Month;

-- Quarterly Sales Trend
SELECT 
    YEAR(OrderDate) AS Year,
    QUARTER(OrderDate) AS Quarter,
    SUM(Sales) AS TotalSales
FROM SupermartGrocerySales
GROUP BY Year, Quarter
ORDER BY Year, Quarter;

-- output
| Year | Quarter | TotalSales |
| ---- | ------- | ---------- |
| 2015 | 1       | 435683     |
| 2015 | 2       | 573585     |
| 2015 | 3       | 833347     |
| 2015 | 4       | 1132984    |
| 2016 | 1       | 391996     |
| 2016 | 2       | 665382     |
| 2016 | 3       | 874977     |
| 2016 | 4       | 1199604    |
| 2017 | 1       | 503665     |
| 2017 | 2       | 871751     |
| 2017 | 3       | 1118348    |
| 2017 | 4       | 1378148    |
| 2018 | 1       | 756710     |
| 2018 | 2       | 1032463    |
| 2018 | 3       | 1373786    |
| 2018 | 4       | 1814553    |

-- Month-over-Month Growth Rate
WITH MonthlySales AS (
  SELECT
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(Sales) AS TotalSales
  FROM SupermartGrocerySales
  GROUP BY Month
)
SELECT 
    CURRENT.Month,
    CURRENT.TotalSales,
    LAG(CURRENT.TotalSales) OVER (ORDER BY CURRENT.Month) AS PreviousMonthSales,
    ((CURRENT.TotalSales - LAG(CURRENT.TotalSales) OVER (ORDER BY CURRENT.Month))
     / LAG(CURRENT.TotalSales) OVER (ORDER BY CURRENT.Month)) * 100 AS MonthOverMonthGrowth
FROM MonthlySales AS CURRENT;


-- OUTPUT:
| Month   | TotalSales | PreviousMonthSales | MonthOverMonthGrowth |
| ------- | ---------- | ------------------ | -------------------- |
| 2015-01 | 122497     | NULL               | NULL                 |
| 2015-02 | 66030      | 122497             | -46.0966            |
| 2015-03 | 247156     | 66030              | 274.3086             |
| 2015-04 | 203258     | 247156             | -17.7613            |
| 2015-05 | 164263     | 203258             | -19.185             |
| 2015-06 | 206064     | 164263             | 25.4476              |
| 2015-07 | 220986     | 206064             | 7.2414               |
| 2015-08 | 230161     | 220986             | 4.1518               |
| 2015-09 | 382200     | 230161             | 66.0577              |
| 2015-10 | 241726     | 382200             | -36.7541            |
| 2015-11 | 480979     | 241726             | 98.9769              |
| 2015-12 | 410279     | 480979             | -14.6992            |
| 2016-01 | 89009      | 410279             | -78.3053            |
| 2016-02 | 90823      | 89009              | 2.038                |
| 2016-03 | 212164     | 90823              | 133.6016             |
| 2016-04 | 237272     | 212164             | 11.8342              |
| 2016-05 | 222722     | 237272             | -6.1322             |
| 2016-06 | 205388     | 222722             | -7.7828             |
| 2016-07 | 215776     | 205388             | 5.0577               |
| 2016-08 | 229543     | 215776             | 6.3802               |
| 2016-09 | 429658     | 229543             | 87.1797              |
| 2016-10 | 249639     | 429658             | -41.8982            |
| 2016-11 | 477720     | 249639             | 91.3643              |
| 2016-12 | 472245     | 477720             | -1.1461             |
| 2017-01 | 131727     | 472245             | -72.1062            |
| 2017-02 | 132982     | 131727             | 0.9527               |
| 2017-03 | 238956     | 132982             | 79.6905              |
| 2017-04 | 247773     | 238956             | 3.6898               |
| 2017-05 | 332524     | 247773             | 34.2051              |
| 2017-06 | 291454     | 332524             | -12.351             |
| 2017-07 | 315531     | 291454             | 8.261                |
| 2017-08 | 256089     | 315531             | -18.8387            |
| 2017-09 | 546728     | 256089             | 113.4914             |
| 2017-10 | 308026     | 546728             | -43.6601            |
| 2017-11 | 551815     | 308026             | 79.1456              |
| 2017-12 | 518307     | 551815             | -6.0723             |
| 2018-01 | 234739     | 518307             | -54.7104            |
| 2018-02 | 166267     | 234739             | -29.1694            |
| 2018-03 | 355704     | 166267             | 113.9354             |
| 2018-04 | 310150     | 355704             | -12.8067            |
| 2018-05 | 367411     | 310150             | 18.4624              |
| 2018-06 | 354902     | 367411             | -3.4046             |
| 2018-07 | 337092     | 354902             | -5.0183             |
| 2018-08 | 331014     | 337092             | -1.8031             |
| 2018-09 | 705680     | 331014             | 113.1874             |
| 2018-10 | 443898     | 705680             | -37.0964            |
| 2018-11 | 683410     | 443898             | 53.9565              |
| 2018-12 | 687245     | 683410             | 0.5612               |
    
-- Customers with Highest Lifetime Value
SELECT 
    CustomerName,
    SUM(Sales) AS LifetimeSales,
    SUM(Profit) AS LifetimeProfit
FROM SupermartGrocerySales
GROUP BY CustomerName
ORDER BY LifetimeSales DESC
LIMIT 10;

-- Repeat Customers
SELECT 
    CustomerName,
    COUNT(DISTINCT OrderID) AS NumberOfOrders
FROM SupermartGrocerySales
GROUP BY CustomerName
HAVING NumberOfOrders > 1
ORDER BY NumberOfOrders DESC;

-- Average Purchase Interval per Customer
WITH PurchaseDates AS (
  SELECT 
    CustomerName,
    OrderDate,
    LAG(OrderDate) OVER (PARTITION BY CustomerName ORDER BY OrderDate) AS PreviousOrderDate
  FROM SupermartGrocerySales
)
SELECT 
    CustomerName,
    AVG(DATEDIFF(OrderDate, PreviousOrderDate)) AS AverageDaysBetweenOrders
FROM PurchaseDates
WHERE PreviousOrderDate IS NOT NULL
GROUP BY CustomerName
HAVING AverageDaysBetweenOrders IS NOT NULL
ORDER BY AverageDaysBetweenOrders;

-- Output: 
| CustomerName | AverageDaysBetweenOrders |
| ------------ | ------------------------ |
| Amrish       | 6.3894                   |
| Krithika     | 6.4798                   |
| Shah         | 6.5093                   |
| Arutra       | 6.6636                   |
| Sudeep       | 6.6699                   |
| Verma        | 6.6959                   |
| Vidya        | 6.7523                   |
| Komal        | 6.7902                   |
| Suresh       | 6.8009                   |
| Surya        | 6.8894                   |
| Harish       | 6.9227                   |
| Hussain      | 7.0242                   |
| Malik        | 7.035                    |
| Peer         | 7.0493                   |
| Veronica     | 7.0545                   |
| Veena        | 7.0637                   |
| Adavan       | 7.0735                   |
| Ridhesh      | 7.0837                   |
| Mathew       | 7.0931                   |
| Arvind       | 7.1139                   |
| Ravi         | 7.1256                   |
| Jonas        | 7.1269                   |
| Muneer       | 7.1527                   |
| Vinne        | 7.1881                   |
| Yusuf        | 7.2                      |
| Alan         | 7.2183                   |
| Sharon       | 7.2239                   |
| Haseena      | 7.2239                   |
| Roshan       | 7.23                     |
| Shree        | 7.2714                   |
| Ram          | 7.3061                   |
| Willams      | 7.3454                   |
| Amy          | 7.3795                   |
| James        | 7.3827                   |
| Sheeba       | 7.4433                   |
| Akash        | 7.4462                   |
| Aditi        | 7.4731                   |
| Ganesh       | 7.474                    |
| Rumaiza      | 7.4845                   |
| Yadav        | 7.5435                   |
| Ramesh       | 7.6043                   |
| Sabeela      | 7.6738                   |
| Sudha        | 7.6968                   |
| Esther       | 7.7234                   |
| Vince        | 7.7433                   |
| Anu          | 7.7514                   |
| Sundar       | 7.8118                   |
| Kumar        | 8.0111                   |
| Jackson      | 8.0166                   |
| Hafiz        | 8.2139                   |
    

-- Customers by Region and their Average Sales Amount
SELECT 
    Region,
    CustomerName,
    AVG(Sales) AS AverageSaleAmount
FROM SupermartGrocerySales
GROUP BY Region, CustomerName
ORDER BY Region, AverageSaleAmount DESC;


-- Top Selling Products
SELECT 
    SubCategory,
    Description,
    SUM(Quantity) AS TotalQuantitySold
FROM SupermartGrocerySales
GROUP BY SubCategory, Description
ORDER BY TotalQuantitySold DESC
LIMIT 10;

-- Category Popularity by Region
SELECT 
    Region,
    Category,
    COUNT(*) AS OrderCount
FROM SupermartGrocerySales
GROUP BY Region, Category
ORDER BY Region, OrderCount DESC;

-- Profitability of Discounted Sales
SELECT 
    Discount,
    SUM(Profit) AS TotalProfit,
    AVG(Profit) AS AverageProfit,
    COUNT(*) AS NumberOfDiscountedSales
FROM SupermartGrocerySales
WHERE Discount > 0
GROUP BY Discount
ORDER BY TotalProfit DESC;







