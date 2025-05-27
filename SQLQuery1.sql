select * from [pizza_sales excel file.xlsx - pizza_sales]

select SUM(total_price) / COUNT(DISTINCT(order_id)) AS Average_Order_Value from [pizza_sales excel file.xlsx - pizza_sales]

select SUM(quantity) as Total_Pizzas_Sold from [pizza_sales excel file.xlsx - pizza_sales]

select COUNT(DISTINCT(order_id)) as Total_Orders from [pizza_sales excel file.xlsx - pizza_sales]

select CAST(CAST(SUM(quantity) AS DECIMAL(10, 2)) / CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10, 2)) AS DECIMAL(10, 2)) as Average_Pizzas_Per_Order from [pizza_sales excel file.xlsx - pizza_sales]

--Daily Trend
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT(order_id)) as Total_Orders
from [pizza_sales excel file.xlsx - pizza_sales] 
GROUP BY DATENAME(DW, order_date)

--Hourly Trend
SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT(order_id)) as Total_Orders from [pizza_sales excel file.xlsx - pizza_sales]
GROUP BY DATEPART(HOUR, order_time) ORDER BY DATEPART(HOUR, order_time)

-- Percentage of Sales by Pizza Category for month of january
SELECT pizza_category, SUM(total_price) as Total_Sales ,
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM [pizza_sales excel file.xlsx - pizza_sales] WHERE MONTH(order_date) = 1)
AS Sales_Percentage FROM [pizza_sales excel file.xlsx - pizza_sales]
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

-- Percentage of Sales by Pizza Size
SELECT pizza_size, SUM(total_price) as Total_Sales, CAST(SUM(total_price)*100/(SELECT SUM(total_price) FROM [pizza_sales excel file.xlsx - pizza_sales]) AS DECIMAL(10, 2)) AS PCT
FROM [pizza_sales excel file.xlsx - pizza_sales] GROUP BY pizza_size ORDER BY PCT DESC

-- Percentage of Sales by Pizza Size per quarter
SELECT pizza_size, SUM(total_price) as Total_Sales, CAST(SUM(total_price)*100/(SELECT SUM(total_price) FROM [pizza_sales excel file.xlsx - pizza_sales] WHERE DATEPART(QUARTER, order_date) = 1) AS DECIMAL(10, 2)) AS PCT
FROM [pizza_sales excel file.xlsx - pizza_sales] 
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size 
ORDER BY PCT DESC

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold , CAST(SUM(total_price) AS DECIMAL(10, 2)) as Total_Sales 
FROM [pizza_sales excel file.xlsx - pizza_sales] 
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

-- Top 5 best sellers by total pizzas sold for month of january
SELECT TOP 5 pizza_name, SUM(quantity) as Quantity_Sold, CAST(SUM(total_price) AS DECIMAL(10, 2)) AS Total_Sales
FROM [pizza_sales excel file.xlsx - pizza_sales]
WHERE MONTH(order_date) = 1
GROUP BY pizza_name
ORDER BY Quantity_Sold DESC

-- Worst 5 Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, SUM(quantity) as Quantity_Sold, CAST(SUM(total_price) AS DECIMAL(10, 2)) AS Total_Sales
FROM [pizza_sales excel file.xlsx - pizza_sales]
GROUP BY pizza_name
ORDER BY Quantity_Sold