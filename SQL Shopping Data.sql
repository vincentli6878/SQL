--Answers how much on average each age group spends (Question 1)
SELECT
	CASE
		WHEN age BETWEEN 18 AND 24 THEN '18-24'
		WHEN age BETWEEN 25 AND 34 THEN '25-34'
		WHEN age BETWEEN 35 AND 44 THEN '35-44'
		WHEN age BETWEEN 45 AND 54 THEN '45-54'
		WHEN age BETWEEN 55 AND 64 THEN '55-64'
		ELSE '65+'
	END AS age_group,
	ROUND(AVG(purchase_amount),2) AS avg_purchase_amount
FROM consumer
GROUP BY age_group;

--Answers if promo codes factor if people spend more or not and how many people actually used the marketing promo (Question 2)
SELECT 
  COUNT(CASE WHEN promo_code_used = 'Y' AND discount_applied = 'Y' THEN customer_id ELSE NULL END) AS number_marketing_promo_used,
  ROUND(AVG(CASE WHEN promo_code_used = 'Y' AND discount_applied = 'Y' THEN purchase_amount ELSE NULL END), 2) AS avg_yes_marketing_promo,
  COUNT(CASE WHEN promo_code_used = 'N' AND discount_applied = 'N' THEN customer_id ELSE NULL END) AS number_marketing_promo_not_used,
  ROUND(AVG(CASE WHEN promo_code_used = 'N' AND discount_applied = 'N' THEN purchase_amount ELSE NULL END), 2) AS avg_no_marketing_promo
FROM 
  consumer;

--Answers which location has the highest average purchases and with highest category (Question 3)
SELECT location, category, ROUND(AVG(purchase_amount),2) AS average_purchases
FROM consumer
GROUP BY location, category
ORDER BY average_purchases DESC;

--Answers the frequency of purchases among subscribers vs. non-subscribers and average purchases (Question 4)
SELECT
	frequency_of_purchase,
	COUNT(CASE WHEN subscription_status = 'Y' THEN (frequency_of_purchase) ELSE NULL END) AS has_subscription,
	ROUND(AVG(CASE WHEN subscription_status = 'Y' THEN (purchase_amount) ELSE NULL END),2) AS avg_purchases_subscriber,
	COUNT(CASE WHEN subscription_status = 'N' THEN (frequency_of_purchase) ELSE NULL END) AS no_subscription,
	ROUND(AVG(CASE WHEN subscription_status = 'N' THEN (purchase_amount) ELSE NULL END),2) AS avg_purchases_nonsubscriber
FROM consumer
GROUP BY frequency_of_purchase;

--Answers what is the most popular shipping method and payment method (Question 5)
SELECT 
  shipping_type, payment_method, COUNT(*) AS combination_count
FROM consumer
GROUP BY shipping_type, payment_method
ORDER BY combination_count DESC;

