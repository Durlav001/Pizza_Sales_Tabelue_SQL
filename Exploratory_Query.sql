select * from [pizza_DB].[dbo].[pizza_sales_excel_file];

-- SQL CLEANING PROJECT

-- CREATING STAGING TABLE FROM OUR ORIGINAL TABLE SO THAT ANY CHANGES WON'T AFFECT THE ORIGINAL TABLE
-- SQL EXPLORING DATA WITH KIPS	


-- 1. TOTAL REVENUE OF THE PIZZA FOR THE WHOLE YEAR

SELECT ROUND (SUM(total_price),2) AS Total_Revenue
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]

-- AVERAGE SALES VALUE PER ORDER

SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id),2) as Avg_Order_Value
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]

-- TOTAL PIZZA SOLD
SELECT SUM(quantity) as TOTAL_PIZZA_SOLD
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]

-- TOTAL ORDER PLACES

SELECT COUNT(DISTINCT order_id) as TOTAL_ORDER_PLACED
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]

-- AVERAGE PIZZA PER ORDER

SELECT SUM(quantity) / COUNT(DISTINCT order_id)
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]
-- TOTAL PIZZA SOLD PER HOUR

SELECT DATEPART(HOUR,order_time) as Order_Hour, SUM(quantity) as Total_Pizza_Sold_Hourly
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]
GROUP BY DATEPART(HOUR,order_time)
ORDER BY DATEPART(HOUR,order_time) ASC;

-- WEEKELY TREND FOR TOTAL ORDERS

SELECT DATEPART(ISO_WEEK,order_date) as Week_Number, YEAR(order_date) as Order_Year,
COUNT(order_id) as Total_Orders
From [pizza_DB].[dbo].[pizza_sales_excel_file]
GROUP BY DATEPART(ISO_WEEK,order_date),YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK,order_date),YEAR(order_date);

-- PERCENTAGE OF SALES BY PIZZA CATEGORY 

SELECT pizza_category, ROUND(SUM(total_price) *100 /
	(SELECT SUM(total_price) from [pizza_DB].[dbo].[pizza_sales_excel_file]
	WHERE MONTH(order_date)=1),2) AS Sales_Percentage
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]
WHERE MONTH(order_date)=1
GROUP BY pizza_category;

-- PERCENTAGE OF SALES BY PIZZA SIZE

SELECT pizza_size, ROUND(SUM(total_price) *100 /
	(SELECT SUM(total_price) from [pizza_DB].[dbo].[pizza_sales_excel_file]),2) AS Sales_Percentage
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]
GROUP BY pizza_size
ORDER BY Sales_Percentage DESC;

-- TOP 5 BEST SELLING PIZZA BY TOTAL SALES PRICE

SELECT TOP 5 pizza_name_id, ROUND(SUM(total_price),2) as TOTAL_SALES
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]
GROUP BY pizza_name_id
ORDER BY TOTAL_SALES DESC;

-- BOTTOM 5 PIZZA BY TOTAL SALES PRICE
SELECT TOP 5 pizza_name_id, ROUND(SUM(total_price),2) as TOTAL_SALES
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]
GROUP BY pizza_name_id
ORDER BY TOTAL_SALES ASC;

--TOP 5 PIZZA BY PIZZA QUANTITY
SELECT TOP 5 pizza_name_id, SUM(quantity) as TOTAL_QUANTITY
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]
GROUP BY pizza_name_id
ORDER BY TOTAL_QUANTITY DESC;

-- BOTTOM 5 PIZZA BY PIZZA QUANTITY

SELECT TOP 5 pizza_name_id, SUM(quantity) as TOTAL_QUANTITY
FROM [pizza_DB].[dbo].[pizza_sales_excel_file]
GROUP BY pizza_name_id
ORDER BY TOTAL_QUANTITY ASC;



