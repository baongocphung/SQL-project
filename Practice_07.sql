---EX1
WITH new AS (
SELECT EXTRACT(year FROM transaction_date) AS year,
product_id, 
spend AS curr_year_spend,
LAG(spend) OVER(PARTITION BY product_id ORDER BY product_id,
EXTRACT(year FROM transaction_date)) AS prev_year_spend
FROM user_transactions)
SELECT*,
ROUND(100*(curr_year_spend-prev_year_spend)/prev_year_spend,2)
AS yoy_rate FROM new 
---EX2
WITH new AS(
SELECT*, RANK()OVER(PARTITION BY card_name 
ORDER BY issue_year, issue_month) AS ranking
FROM monthly_cards_issued)
SELECT card_name, 	issued_amount FROM new
WHERE ranking = 1
ORDER BY issued_amount DESC
---EX3
WITH new AS(
SELECT user_id, spend,	transaction_date, ROW_NUMBER() OVER(PARTITION BY user_id 
ORDER BY transaction_date) AS row
FROM transactions)
SELECT user_id, spend,	transaction_date FROM new
WHERE row=3
---EX4
WITH new AS(
SELECT*, RANK() OVER(PARTITION BY user_id 
ORDER BY transaction_date DESC) AS ranking
FROM user_transactions)
SELECT transaction_date, user_id, COUNT(user_id) AS purchase_count
FROM new
WHERE ranking=1
GROUP BY transaction_date, user_id
---EX5
SELECT user_id, tweet_date, 
ROUND(AVG(tweet_count) 
OVER(PARTITION BY user_id ORDER BY tweet_date
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS tweet_count
FROM tweets
---EX6
WITH new AS(
SELECT transaction_id, transaction_timestamp AS time01,
LAG(transaction_timestamp) 
OVER(PARTITION BY merchant_id, credit_card_id
ORDER BY transaction_timestamp) AS time02
FROM transactions)
SELECT COUNT(transaction_id) FROM new
WHERE EXTRACT(minute FROM (time01-time02))<10
--EX7
WITH highest_product AS(
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
---EX8
WITH new AS(
SELECT a.artist_name,
DENSE_RANK() OVER(ORDER BY COUNT(s.song_id)DESC)
AS artist_ranking
FROM artists AS a
JOIN songs AS s ON a.artist_id=s.artist_id
JOIN global_song_rank AS r ON r.song_id=s.song_id
WHERE r.rank<=10
GROUP BY a.artist_name)
SELECT artist_name,artist_ranking FROM new
WHERE artist_ranking <=5
