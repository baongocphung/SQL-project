---ex1
select name from students
where marks>75
order by right(name,3),
ID ASC
---ex2
select user_id, 
concat (upper(left(name,1)), lower(substring(name,2))) as name
from Users
order by user_id
---ex3
select manufacturer,
concat('$',round(sum(total_sales)/1000000),' million') as sale
from pharmacy_sales
group by manufacturer
order by sum(total_sales) desc, manufacturer
---ex4
select extract(month from submit_date) as mth,
product_id as product,
round(avg(stars),2) as avg_stars
from reviews
group by mth, product
order by mth, product
---ex5
select sender_id,
count(message_id) as message_count
from messages
where extract(month from sent_date)=8
and extract(year from sent_date)=2022
group by sender_id
order by message_count desc 
limit 2
---ex6
select tweet_id from Tweets
where length(content)>15
---ex7
select activity_date day,
count(distinct user_id) as active_users
from activity
where datediff('2019-07-27',activity_date) between 0 and 29
group by activity_date
---ex8
select count(id) as number_employee
from employees
where extract(month from joining_date)between 1 and 7
and extract(year month from joining_date)=2022
---ex9
select position('a') in first_name
from worker
where first_name = 'Amitah'
---ex10
select substring(title,length(winery)+2,4) from winemag_p2
where country = 'Macedonia'
