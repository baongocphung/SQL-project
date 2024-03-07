---EX1
SELECT COUNT(a.company_id) AS duplicate_companies --> Đếm số công ty trùng
FROM (SELECT company_id, title, description, COUNT(job_id) --> Các tiêu chí để job trùng theo mô tả đề
FROM job_listings --> Dùng subquery để lấy ra các job trùng
GROUP BY company_id, title, description
HAVING COUNT(job_id)>1)
AS a
---EX2
WITH highest_product AS( --> Dùng CTE để chứa tạm thời dữ liệu của highest product theo yêu cầu
SELECT product, SUM(spend) AS total_spend
FROM product_spend
WHERE EXTRACT(year FROM transaction_date)= '2022'
GROUP BY product
ORDER BY total_spend DESC
LIMIT 4)
SELECT a.category, highest_product.product, highest_product.total_spend
FROM product_spend AS a
JOIN highest_product
ON a.product=highest_product.product
GROUP BY a.category, highest_product.product, highest_product.total_spend
ORDER BY category, total_spend DESC
---EX3
WITH uhg AS(
SELECT policy_holder_id, COUNT(*)
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(*)>=3)
SELECT COUNT(*) FROM uhg
---EX4
SELECT pages.page_id 
FROM pages
LEFT JOIN page_likes AS likes
ON pages.page_id=likes.page_id
WHERE likes.page_id is null
---EX5 (em bị báo sai output bài này ạ =((()
WITH 
current_month AS(
  SELECT EXTRACT(month FROM event_date) AS curmonth
  FROM user_actions
  ORDER BY EXTRACT(month FROM event_date) DESC LIMIT 1), --> lấy ra tháng bây giờ
previous_month AS(
  SELECT EXTRACT(month FROM event_date) AS premonth
  FROM user_actions
  ORDER BY EXTRACT(month FROM event_date) DESC LIMIT 1), -->lấy ra tháng trước đó
user_active_current_month AS(
  SELECT DISTINCT user_id
  FROM user_actions
  WHERE EXTRACT(month FROM event_date)=(SELECT curmonth FROM current_month)), --> lấy ra những user hoạt động tháng này
user_active_previous_month AS(
  SELECT DISTINCT user_id
  FROM user_actions
  WHERE EXTRACT(month FROM event_date)=(SELECT curmonth FROM current_month)) --> lấy ra những user hoạt động tháng trước
SELECT(SELECT curmonth FROM current_month) AS month,
COUNT(*)AS monthly_active_users 
FROM user_active_current_month AS a  
JOIN user_active_previous_month AS b 
ON a.user_id=b.user_id
---EX6
SELECT  SUBSTR(trans_date,1,7) AS month, country, COUNT(*) AS trans_count, 
SUM(CASE WHEN state = 'approved' then 1 else 0 END) AS approved_count, 
SUM(amount) AS trans_total_amount, 
SUM(CASE WHEN state = 'approved' then amount else 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country
---EX7
WITH first_year AS(
    SELECT product_id, min(year) AS first
    FROM sales
    GROUP BY product_id
)
SELECT a.product_id, a.year AS first_year, a.quantity, a.price FROM sales AS a
JOIN first_year AS b ON a.product_id=b.product_id
WHERE b.first=a.year
---EX8
WITH bought AS(
    SELECT customer_id, product_key 
    FROM Customer
    GROUP BY customer_id, product_key
)
SELECT customer_id FROM bought
GROUP BY customer_id
HAVING COUNT(*)=(
    SELECT COUNT(DISTINCT product_key)
    FROM Product
)
ORDER BY customer_id
---EX9
SELECT employee_id
FROM Employees
WHERE salary<30000
AND manager_id NOT IN (SELECT employee_id FROM Employees)
ORDER BY employee_id
---EX10
SELECT COUNT(a.company_id) AS duplicate_companies 
FROM (SELECT company_id, title, description, COUNT(job_id)
FROM job_listings
GROUP BY company_id, title, description
HAVING COUNT(job_id)>1)
AS a
---EX11
WITH name AS(
    SELECT a.name AS results
    FROM Users AS a
    JOIN MovieRating AS b ON a.user_id=b.user_id
    GROUP BY a.name
    ORDER BY COUNT(*) DESC, a.name
    LIMIT 1
),
title AS(
    SELECT c.title AS results
    FROM Movies AS c
    JOIN MovieRating AS d ON c.movie_id=d.movie_id
    WHERE EXTRACT(month FROM d.created_at)='2'
    AND EXTRACT(year FROM d.created_at)='2020'
    GROUP BY c.title
    ORDER BY AVG(rating) DESC, c.title
    LIMIT 1
)
SELECT*FROM name UNION ALL SELECT*FROM title
---EX12
SELECT id, COUNT(*) AS num 
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) AS friends_count
GROUP BY id
ORDER BY num DESC 
LIMIT 1;
