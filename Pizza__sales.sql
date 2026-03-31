use [Pizza Sale];

select * from dbo.pizza_sales;

-- 1 TOTAL REVENUE 
select SUM(total_price) AS Total_Revenue FROM dbo.pizza_sales;

-- 2 AVERAGEORDERVALUE
select (SUM(total_price)/ COUNT(DISTINCT order_id)) AS Avg_Order_Value FROM dbo.pizza_sales;

-- 3 TOTAL PIZZAS SOLD
SELECT SUM(quantity) AS Total_Pizza_Sold FROM [Pizza_Sales];

-- 4 TOTAL ORDERS
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM [Pizza_Sales];


-- 5 AVERAGE PIZZAS PER ORDERS
SELECT 
	CAST (CAST(SUM(quantity) AS DECIMAL (10,2)) / 
	CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2))
	AS DECIMAL(10,2))
	AS Avg_Pizza_Par_Order 
FROM [Pizza_Sales];

-- 6 Daily Trend for Total orders 
SELECT 
	DATENAME(DW, order_date) AS order_day,
	COUNT(DISTINCT order_id) AS total_orders
from dbo.Pizza_Sales
group BY DATENAME(DW, order_date);

-- 7 Monthly trend for orders 
SELECT
	DATENAME(MONTH, order_date) AS Month_name,
	COUNT(DISTINCT order_id) AS Total_orders
from dbo.Pizza_Sales
group by DATENAME(MONTH, order_date); 
 
-- 8 % of sales by pizza Category
SELECT 
      pizza_category, 
	  CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_revenue,
      CAST(
	  SUM(total_price)*100 /
      (SELECT SUM(total_price) FROM pizza_sales) 
	  AS DECIMAL(10,2)) AS PCT
FROM pizza_sales 
Group BY pizza_category;

-- 9 % of Sales by pizza size
SELECT
     pizza_size,
	 CAST(
	 SUM(total_price) AS DECIMAL (10,2))
	 AS total_revenue,
CAST(
    SUM(total_price) * 100 /
	(SELECT
	SUM(total_price) FROM pizza_sales) 
	AS DECIMAL (10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

-- 10 Total Pizzas Sold By Pizza Category
SELECT 
	pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
	WHERE MONTH(order_date) = 2
	GROUP BY pizza_category
	ORDER BY Total_Quantity_Sold DESC;

--11 Top 5 pizzas by Revenue
SELECT TOP 5 pizza_name, 
	SUM (total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC

-- 12 Bottom 5 Pizzas by Revenue
SELECT TOP 5pizza_name,
	SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC;

-- 13 Top Pizzas by Quantity
SELECT
	TOP 5 pizza_name, SUM (quantity) AS
	Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC;

-- 14 Bottom 5 pizzas By Quantity
SELECT 
	TOP 5 pizza_name, SUM(quantity) AS 
	total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY  total_pizza_sold ASC;

-- 15 Top 5 pizza by total orders
SELECT 
	 TOP 5 pizza_name, COUNT(DISTINCT Order_id)
	 AS Total_orders
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_orders DESC

--16 Bottom 5 pizza by total orders
SELECT 
	TOP 5 Pizza_name, COUNT(DISTINCT order_id)
	AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders ASC

