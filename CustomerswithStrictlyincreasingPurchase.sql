with a as (select customer_id, year(order_date) as o_year, sum(price) as amount
from orders
group by 1,2),

b as (select customer_id, 
(max(o_year) over(partition by customer_id) - min(o_year) over(partition by customer_id)) as year_gap,
count(*) over(partition by customer_id) as year_cnt, 
rank() over(partition by customer_id order by o_year) as year_rk, 
rank() over(partition by customer_id order by amount) as purchase_rk
from a)


select distinct customer_id
from b
where customer_id not in 
(select customer_id from b where (year_gap+1 != year_cnt) or (year_rk!= purchase_rk))
