--devrlope a database to anaylize and visualize Hotel Booking Data

--Buid a database
--develope SQL query
--connect it to Power BI
--Visualize
--summarise

----has buid a database named Project
create database Project
use Project

-----KPI

---1. Total Revenue:

select * from pizza_sales
select SUM(total_price) as total_revenue from pizza_sales

---2. Average Order Value
select SUM(total_price)/ count(distinct order_id) as average_order_value from pizza_sales

--3.Total Pizzas Sold
select sum(quantity) as pizza_sold from pizza_sales

--4.Total Orders
select count(distinct order_id) as total_orders from pizza_sales

--5. Average Pizzas Per Order
select cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) 
as decimal(10,2)) as avd_pizza_per_order from pizza_sales
--if you want to cast whole result then we can 
select CAST( cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) 
as decimal(10,2)) as decimal(10,2)) as avg_pizza_per_orders from pizza_sales

------- B. Daily Trend for Total Orders
select * from pizza_sales
select DATENAME(DW,order_date),count(distinct order_id) from pizza_sales 
group by DATENAME(DW,order_date)

---C. Hourly Trend for Orders
select datepart(hour,order_time),count(distinct order_id) from pizza_sales
group by datepart(hour,order_time) order by datepart(hour,order_time) asc

--D. % of Sales by Pizza Category
select pizza_category, cast (sum(total_price)*100/(select sum(total_price) from pizza_sales where MONTH(order_date)=1  ) as decimal(10,2))
from pizza_sales
where MONTH(order_date)=1 --- filter for january you can kleep it for any moth 
group by pizza_category

---E. % of Sales by Pizza Size
select pizza_size,cast(sum(total_price)*100/(select sum(total_price) from pizza_sales) as decimal(10,2)) from pizza_sales
group by pizza_size order by pizza_size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size


----F.Total Pizzas Sold by Pizza Category
select * from pizza_sales
select pizza_category, sum(quantity)   from pizza_sales
group by pizza_category
order by sum(quantity)  desc
---G. Top 5 Best Sellers by Total Pizzas Sold
select  top 5 pizza_name,sum(quantity)from pizza_sales
group by pizza_name 
order by sum(quantity) desc

--H. Bottom 5 Best Sellers by Total Pizzas Sold
select  top 5 pizza_name,sum(quantity)from pizza_sales
group by pizza_name 
order by sum(quantity) asc

