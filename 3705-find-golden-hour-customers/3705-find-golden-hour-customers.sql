# Write your MySQL query statement below
select  
    customer_id, 
    count(customer_id) as total_orders, 
    round(avg(case when ((time(order_timestamp) >= '11:00:00' and time(order_timestamp) <= '14:00:00') or (time(order_timestamp) >= '18:00:00' and time(order_timestamp) <= '21:00:00')) then 1 else 0 end) * 100, 0) as peak_hour_percentage,
    round(avg(order_rating), 2) as average_rating
from restaurant_orders
group by customer_id
having total_orders > 2 and average_rating >= 4.0 and peak_hour_percentage >= 60 and round(avg(case when order_rating is not NULL then 1 else 0 end)*100, 0) >= 50
order by average_rating desc, customer_id desc