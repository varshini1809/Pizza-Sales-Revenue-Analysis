create database pizza_project;
use pizza_project;

select * from order_details; -- order_details_id ,order_id, pizza_id, quantity
select * from orders;   -- order_id, date, time
select * from pizzas;   -- pizza_id, pizza_type_id, size, price
select * from pizza_types;  -- pizza_type_id, name, category, ingredients

/*
Basic:
Retrieve the total number of orders placed.
Calculate the total revenue generated from pizza sales.
Identify the highest-priced pizza.
Identify the most common pizza size ordered.
List the top 5 most ordered pizza types along with their quantities.
*/

-- 1. Retrieve the total number of orders placed.
select  count(distinct order_id) as 'Total Orders' from orders;  -- 21338

-- 2. Calculate the total revenue generated from pizza sales.
-- to see the details
select od.pizza_id, od.quantity, p.price
from order_details od join pizzas p
on od.pizza_id = p.pizza_id;

-- to get the total revenue
select cast(sum(od.quantity * p.price) as decimal(10,2)) as 'Total Revenue'
from order_details od join pizzas p
on od.pizza_id = p.pizza_id;

-- 3. Identify the highest-priced pizza.
	-- with limit function
select ptype.name as 'Pizza Name', cast(p.price as decimal(10,2)) as 'Pizza Price'
from pizza_types ptype join pizzas p
on ptype.pizza_type_id = p.pizza_type_id
order by p.price desc limit 1;

	-- without limit function ad with window function
    
WITH cte AS (
    SELECT pizza_types.name AS `Pizza Name`,
           CAST(pizzas.price AS DECIMAL(10,2)) AS `Price`,
           RANK() OVER (ORDER BY pizzas.price DESC) AS rnk
    FROM pizzas
    JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
)
SELECT `Pizza Name`, `Price`
FROM cte
WHERE rnk = 1;

-- 4.Identify the most common pizza size ordered.

select pizzas.size, count(distinct order_id) as 'No of Orders',
sum(quantity) as 'Total Quantity Ordered' 
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by count(distinct order_id) desc;

-- 5. List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name as 'Pizzas', sum(order_details.quantity) as 'Total Ordered'
from order_details join pizzas 
on order_details.pizza_id = pizzas.pizza_id

join pizza_types
on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.name
order by sum(quantity) desc limit 5;


/* INTERMEDIATE
Intermediate:
Join the necessary tables to find the total quantity of each pizza category ordered.
Determine the distribution of orders by hour of the day.
Join relevant tables to find the category-wise distribution of pizzas.
Group the orders by date and calculate the average number of pizzas ordered per day.
Determine the top 3 most ordered pizza types based on revenue.
*/

-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category, SUM(order_details.quantity) as 'Total Quantity Ordered'
from order_details join pizzas 
on order_details.pizza_id = pizzas.pizza_id

join pizza_types
on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.category
order by SUM(order_details.quantity) desc;

-- 2. Determine the distribution of orders by hour of the day.
select hour(orders.time) as 'Hours of the day', count(distinct order_id) as 'No of Orders'
from orders
group by `Hours of the day`
order by `No of Orders` desc;


-- 3. find the category-wise distribution of pizzas.
select category, count(distinct pizza_type_id) as 'No of Pizzas'   -- count(distinct name) is also considerable
from pizza_types
group by category
order by `No of Pizzas`;


-- 4. Group the orders by date and calculate the average number of pizzas ordered per day.
with cte as (
select orders.date as 'Date' , sum(order_details.quantity) as 'Total Pizza Ordered per day'
from order_details 
join orders	on order_details.order_id = orders.order_id
group by orders.date ) 

select floor(round(avg(`Total Pizza Ordered per day`),1)) as 'Avg Pizza Ordered per day 'from cte ;

	-- solving using subquery instead of using where clause
select avg(`Avg Pizza Ordered per day`) from (
	select orders.date as `Date`, sum(order_details.quantity) as `Total Pizza Ordered per day`
    from orders 
    join order_details on orders.order_id = order_details.order_id
    group by `Date`
) as pizza_ordered;


-- 5. Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name as 'Name', sum(order_details.quantity * pizzas.price) as 'Total Pizza Revenue'
from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.name
order by `Total Pizza Revenue` desc limit 3;

		-- using window function
with cte as (
	select pizza_types.name as 'Name', sum(order_details.quantity * pizzas.price) as 'Total Pizza Revenue'
	from order_details 
	join pizzas on pizzas.pizza_id = order_details.pizza_id
	join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
	group by pizza_types.name
)
select Name, `Total Pizza Revenue` from (
	select Name, `Total Pizza Revenue`,
    rank() over (order by `Total Pizza Revenue` desc) as revenue_rank
    from cte
) as ranked_pizza
where
	revenue_rank <= 3;


