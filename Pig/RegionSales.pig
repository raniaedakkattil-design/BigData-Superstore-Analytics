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

region_group = GROUP sales_data BY Region;

region_sales =
FOREACH region_group
GENERATE
group AS Region,
SUM(sales_data.Sales) AS TotalSales;

STORE region_sales
INTO 'RegionSalesOutput'
USING PigStorage(',');
