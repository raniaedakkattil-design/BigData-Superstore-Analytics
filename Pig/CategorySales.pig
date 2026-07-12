sales_data = LOAD 'SampleSuperstore.csv'
USING PigStorage(',')
SKIP 1
AS (
    Ship_Mode:chararray,
    Segment:chararray,
    Country:chararray,
    City:chararray,
    State:chararray,
    Postal_Code:int,
    Region:chararray,
    Category:chararray,
    Sub_Category:chararray,
    Sales:double,
    Quantity:int,
    Discount:double,
    Profit:double
);

category_group = GROUP sales_data BY Category;

category_sales =
FOREACH category_group
GENERATE
group AS Category,
SUM(sales_data.Sales) AS TotalSales;

STORE category_sales
INTO 'CategorySalesOutput'
USING PigStorage(',');
