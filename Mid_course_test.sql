---QUESTION 1
select distinct replacement_cost from film
order by replacement_cost
limit 1
---QUESTION 2
select case 
  when replacement_cost between 9.99 and 19.99 then 'low'
  when replacement_cost between 20.00 and 24.99 then 'medium'
  when replacement_cost between 25.00 and 29.99 then 'high'
  end as category,
count (*)
from film
group by category
---QUESTION 3
select f.title, f.length, c.name from film as f
join film_category as fc on f.film_id=fc.film_id
join category as c on fc.category_id=c.category_id
where c.name in ('Drama','Sports')
order by length
desc
limit 1
---QUESTION 4
select c.name, 
count(*) 
from film as f
join film_category as fc on f.film_id=fc.film_id
join category as c on fc.category_id=c.category_id
where c.name in ('Drama','Sports')
group by c.name
order by count(*)
desc
limit 1
---QUESTION 5
select concat(a.first_name, ' ',a.last_name) as full_name,
count(*)
from actor as a
join film_actor as fa on a.actor_id=fa.actor_id
join film as f on fa.film_id=f.film_id
group by full_name
order by count(*)
desc
limit 1
--- QUESTION 6
select count(*)
from customer as c
right join address on c.address_id = address.address_id
where c.customer_id is null
---QUESTION 7
select sum(p.amount), c.city as revenue
from city as c
join address as a on c.city_id=a.city_id
join customer as cus on cus.address_id=a.address_id
join payment as p on p.customer_id=cus.customer_id
group by c.city
order by revenue
desc
limit 1
---QUESTION 8
select concat (c.city, ' ',co.country) as city_country, 
sum(p.amount) as revenue
from city as c
join address as a on c.city_id=a.city_id
join customer as cus on cus.address_id=a.address_id
join payment as p on p.customer_id=cus.customer_id
join country as co on c.country_id=co.country_id
group by city_country
order by revenue
desc
limit 1
