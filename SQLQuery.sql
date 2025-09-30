use PizzaDB;

select * from pizza_sales;

select sum(total_price) as Total_Revenue from pizza_sales;

select sum(total_price)/ count(distinct order_id) as Avg_Order_Value from pizza_sales;

select sum(quantity) as Total_Pizza_Sold from pizza_sales;

select count(distinct order_id) as Total_Orders from pizza_sales;

select cast(cast(sum(quantity) as decimal(10,2)) /
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as 
Avg_Pizzas_Per_Orders from pizza_sales;

--Daily Trend
select datename(DW, order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by datename(DW, order_date);

--Hourly Trend
select datepart(hour, order_time) as order_hours, count(distinct order_id) as total_orders
from pizza_sales
group by datepart(hour, order_time)
order by total_orders desc;

-- Percentage of Sales by category
select pizza_category, sum(total_price) as Total_Sales, sum(total_price)*100/(select sum(total_price) from pizza_sales)
 as PCT from pizza_sales
group by pizza_category;

-- Percentage of Sales by Pizza Size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_Sales, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales)
as decimal (10,2)) as PCT from pizza_sales
group by pizza_size
order by PCT desc;

-- Total Pizza Sold by Pizza Category
select pizza_category, sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_category;

-- Top 5 best seller 
select  top 5 pizza_name, sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc;

-- Top 5 wrostt seller 
select  top 5 pizza_name, sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_name
order by sum(quantity) asc;
