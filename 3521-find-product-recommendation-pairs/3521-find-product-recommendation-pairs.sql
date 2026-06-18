# Write your MySQL query statement below
select  p1.product_id as product1_id,p2.product_id as product2_id,info1.category as product1_category,info2.category as product2_category,count(*) as customer_count
from ProductPurchases as p1
join ProductPurchases as p2
on p1.user_id=p2.user_id
and p1.product_id<p2.product_id
join ProductInfo as info1 on p1.product_id=info1.product_id
join ProductInfo as info2 on p2.product_id=info2.product_id
group by p1.product_id,p2.product_id,info1.category,info2.category
having customer_count >=3
order by customer_count desc,p1.product_id,p2.product_id