---EX1
select country.continent,
floor(avg(city.population))
from country
inner join city on country.code=city.countrycode
group by country.continent
---EX2
select 
round(count(texts.email_id)::decimal/count(distinct emails.email_id),2) as activation_rate
from emails
left join texts 
on emails.email_id=texts.email_id
and texts.signup_action='Confirmed'
---EX3 (Bài này khó quá em tham khảo solution nhiều)
select age.age_bucket, 
--Round the percentage to 2 decimal places in the output
--time spent sending / (Time spent sending + Time spent opening)
--To avoid integer division in percentages, multiply by 100.0 and not 100.
round(100.0*sum(activities.time_spent) filter 
(where activities.activity_type = 'send')
/sum(activities.time_spent),2) as send_perc,
--Round the percentage to 2 decimal places in the output.
--Time spent opening / (Time spent sending + Time spent opening)
round(100.0*sum(activities.time_spent) filter
(where activities.activity_type = 'open')
/sum(activities.time_spent),2) as open_perc
from activities
--Write a query to obtain a breakdown of the time spent sending vs. opening snaps 
--as a percentage of total time spent on these activities grouped by age group.
inner join age_breakdown as age 
on activities.user_id = age.user_id 
where activities.activity_type in ('send', 'open') 
group by age.age_bucket
---EX4
with supercloud as (
select 
customers.customer_id, 
count(distinct products.product_category) as unique_count
from customer_contracts as customers
left join products
on customers.product_id=products.product_id
group by customers.customer_id
)
select customer_id from supercloud
where unique_count=(select count(distinct product_category) from products)
order by customer_id
---EX5
select
--report the ids and the names of all managers
e1.employee_id, 
e1.name, 
--the number of employees who report directly to them
--and the average age of the reports rounded to the nearest integer
count(e2.employee_id) as reports_count, 
round(avg(e2.age)) as average_age
from employees e1 
inner join employees e2 
on e1.employee_id = e2.reports_to 
group by e1.employee_id, e1.name 
order by employee_id;
---EX6
select products.product_name as product_name, 
sum(orders.unit) as unit
from products
left join orders using (product_id)
where year(orders.order_date)='2020' and month(orders.order_date)='02'
group by products.product_id
having sum(orders.unit)>=100
---EX7
select pages.page_id 
from pages
left join page_likes as likes
on pages.page_id=likes.page_id
where likes.page_id is null
