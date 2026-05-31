# Write your MySQL query statement below

select rt.product_name,lt.year,lt.price 
from Sales as lt
left join Product as rt
on lt.product_id=rt.product_id;