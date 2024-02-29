---ex1
select 
sum(case when device_type = 'laptop' then 1 else 0 end) 
as laptop_views, 
sum(case when device_type in ('tablet', 'phone') then 1 else 0 end) 
as mobile_views 
from viewership
---ex2
select*,
case when x<y+z and y<x+z and z<x+y then "Yes" else "No" 
end as triangle
from triangle
---ex3 (lỗi division by zero)
select round (100.0*count(case_id) 
filter (where call_category is NULL or call_category = 'n/a')
/count (case_id), 1) 
as uncategorised_call_pct
from callers
---ex4
select name from Customer
where referee_id <> 2 or referee_id is null
---ex5
select survived,
sum(case when pclass=1 then 1 else 0 end) as first_class,
sum(case when pclass=2 then 1 else 0 end) as second_class,
sum(case when pclass=3 then 1 else 0 end) as third_class
from titanic
group by survived
