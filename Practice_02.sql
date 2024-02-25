---ex1
select distinct city from station
where id%2=0
---ex2
select count(city)-count(distinct city) from station
---ex3
select ceil(avg(salary)-avg(replace(salary,0,''))) from employees
---ex4
  --Phân tích yêu cầu
  --1.output (gốc/phái sinh)
  --2.input
  --3.ĐK lọc theo trường nào (gốc/phái sinh)
select round(
cast(sum(item_count*order_occurrences)/sum(order_occurrences) as decimal),1)
as mean from items_per_order
---ex5
select candidate_id from candidates
where skill in ('Python','Tableau','PostgreSQL')
group by candidate_id
having count(skill)=3
---ex6
select user_id,
date(max(post_date))-date(min(post_date)) as day_between
from posts
where post_date>='2021-01-01' and post_date<'2022-01-01'
group by user_id
having count(post_id)>=2
---ex7
select card_name,
max(issued_amount)-min(issued_amount) as difference
from monthly_cards_issued
group by card_name
order by difference DESC
---ex8
select manufacturer,
count(drug) as drug_count,
abs(sum(cogs-total_sales)) as total_loss
from pharmacy_sales
where total_sales<cogs
group by manufacturer
order by total_loss DESC
---ex9
select*from cinema
where id%2=1 and description<>'boring'
order by rating DESC
---ex10
select teacher_id,
count(distinct subject_id) as cnt
from teacher
group by teacher_id
---ex11
select user_id,
count(follower_id) as followers_count
from followers
group by user_id
order by user_id ASC
---ex12
select class from courses
group by class
having count(student)>=5
