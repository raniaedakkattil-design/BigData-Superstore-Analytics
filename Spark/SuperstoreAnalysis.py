from pyspark.sql import SparkSession
from pyspark.sql.functions import *

# =====================================================
# Create Spark Session
# =====================================================

spark = SparkSession.builder \
    .appName("Superstore Analytics") \
    .getOrCreate()

# =====================================================
# Load Dataset
# =====================================================

df = spark.read.csv(
    "SampleSuperstore.csv",
    header=True,
    inferSchema=True
)

# =====================================================
# JOB 1 : Category-wise Sales
# =====================================================

category_sales = df.groupBy("Category") \
    .agg(sum("Sales").alias("TotalSales"))

category_sales.show()

# =====================================================
# JOB 2 : Category-wise Profit
# =====================================================

category_profit = df.groupBy("Category") \
    .agg(sum("Profit").alias("TotalProfit"))

category_profit.show()

# =====================================================
# JOB 3 : Region-wise Sales
# =====================================================

region_sales = df.groupBy("Region") \
    .agg(sum("Sales").alias("TotalSales"))

region_sales.show()

# =====================================================
# JOB 4 : Region-wise Profit
# =====================================================

region_profit = df.groupBy("Region") \
    .agg(sum("Profit").alias("TotalProfit"))

region_profit.show()

# =====================================================
# ADVANCED ANALYTICS
# =====================================================

print("\nTotal Sales")
df.agg(sum("Sales")).show()

print("\nTotal Profit")
df.agg(sum("Profit")).show()

print("\nAverage Discount")
df.agg(avg("Discount")).show()

print("\nLoss Orders")
loss_orders = df.filter(col("Profit") < 0)
print(loss_orders.count())

print("\nHighest Profit Orders")
highest_profit = df.orderBy(col("Profit").desc())
highest_profit.show(10)

print("\nState-wise Sales")
state_sales = df.groupBy("State") \
    .agg(sum("Sales").alias("TotalSales"))

state_sales.show()

print("\nCity-wise Sales")
city_sales = df.groupBy("City") \
    .agg(sum("Sales").alias("TotalSales"))

city_sales.show()

print("\nLoss Making Orders")
loss_orders.show()

# =====================================================
# Save Outputs
# =====================================================

category_sales.coalesce(1).write.mode("overwrite").option("header", True).csv("CategorySales")
category_profit.coalesce(1).write.mode("overwrite").option("header", True).csv("CategoryProfit")
region_sales.coalesce(1).write.mode("overwrite").option("header", True).csv("RegionSales")
region_profit.coalesce(1).write.mode("overwrite").option("header", True).csv("RegionProfit")
state_sales.coalesce(1).write.mode("overwrite").option("header", True).csv("StateSales")
city_sales.coalesce(1).write.mode("overwrite").option("header", True).csv("CitySales")

spark.stop()
