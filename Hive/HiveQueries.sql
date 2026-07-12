-- ==========================================
-- Create Table
-- ==========================================

CREATE EXTERNAL TABLE superstore (
    row_id INT,
    order_id STRING,
    order_date STRING,
    ship_date STRING,
    ship_mode STRING,
    customer_id STRING,
    customer_name STRING,
    segment STRING,
    country STRING,
    city STRING,
    state STRING,
    postal_code INT,
    region STRING,
    product_id STRING,
    category STRING,
    sub_category STRING,
    product_name STRING,
    sales DOUBLE,
    quantity INT,
    discount DOUBLE,
    profit DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

---------------------------------------------------

LOAD DATA LOCAL INPATH '/tmp/SampleSuperstore.csv'
OVERWRITE INTO TABLE superstore;

---------------------------------------------------

-- Category-wise Sales

SELECT
Category,
SUM(Sales) AS TotalSales
FROM superstore
GROUP BY Category;

---------------------------------------------------

-- Category-wise Profit

SELECT
Category,
SUM(Profit) AS TotalProfit
FROM superstore
GROUP BY Category;

---------------------------------------------------

-- Region-wise Sales

SELECT
Region,
SUM(Sales) AS TotalSales
FROM superstore
GROUP BY Region;

---------------------------------------------------

-- Region-wise Profit

SELECT
Region,
SUM(Profit) AS TotalProfit
FROM superstore
GROUP BY Region;
