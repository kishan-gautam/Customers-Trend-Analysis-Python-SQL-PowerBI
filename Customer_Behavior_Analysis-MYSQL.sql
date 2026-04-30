-- ============================================================
-- PROJECT     : Customers Behaviour Analysis
-- TOOL        : MySQL Workbench
-- AUTHOR      : Kishan Gautam
-- DATE        : April 2026
-- DESCRIPTION : A Customers Behaviour Analysis project simulating
--               a business scenario. Includes dataset cleaned using
--               Python, data insertion, and BI analysis queries.
-- ============================================================


USE customers_behaviour_analysis;

SELECT * FROM customer_shopping_behavior;


-- ============================================================
--                   BUSINESS ANALYSIS QUERIES
-- ============================================================


-- ------------------------------------------------------------
-- Q1. Total Amount Purchased Based on Gender
-- Finding: Male customers contribute higher total purchases
--          compared to Female customers, suggesting that
--          marketing campaigns should target male audiences
--          while also exploring strategies to increase
--          female customer spending.
-- ------------------------------------------------------------

SELECT
    gender,
    SUM(purchase_amount) AS Total_Purchased
FROM customer_shopping_behavior
GROUP BY gender
ORDER BY Total_Purchased DESC;


-- ------------------------------------------------------------
-- Q2. Customers Purchasing Above Average Even After Getting Discount
-- Finding: A significant number of customers spend above the
--          average purchase amount even when a discount is applied.
--          This indicates a group of high-value customers who are
--          not purely discount-driven and represent strong
--          revenue contributors worth retaining.
-- ------------------------------------------------------------

SELECT
    customer_id,
    purchase_amount,
    (SELECT AVG(purchase_amount) FROM customer_shopping_behavior) AS Avg_Purchase_Amt
FROM customer_shopping_behavior
WHERE
    discount_applied = 'Yes'
    AND purchase_amount > (SELECT AVG(purchase_amount) FROM customer_shopping_behavior)
ORDER BY customer_id;


-- ------------------------------------------------------------
-- Q3. Top 5 Products With Highest Average Review Rating
-- Finding: The top rated products reflect strong customer
--          satisfaction in specific items. The company should
--          maintain quality in these products and use them
--          as flagship items in marketing to build brand trust.
-- ------------------------------------------------------------

SELECT
    item_purchased AS Product,
    ROUND(AVG(review_rating), 2) AS Rating
FROM customer_shopping_behavior
GROUP BY item_purchased
ORDER BY Rating DESC
LIMIT 5;


-- ------------------------------------------------------------
-- Q4. Average Spending by Customers on Express vs Standard Shipping
-- Finding: Customers using Express shipping tend to spend more
--          on average compared to Standard shipping users.
--          This suggests that faster delivery attracts higher
--          value purchases. The company should invest more in
--          Express delivery infrastructure to encourage
--          premium spending behavior.
-- ------------------------------------------------------------

SELECT
    shipping_type,
    ROUND(AVG(purchase_amount), 2) AS Average_Purchase
FROM customer_shopping_behavior
WHERE shipping_type IN ('Standard', 'Express')
GROUP BY shipping_type
ORDER BY Average_Purchase DESC;


-- ------------------------------------------------------------
-- Q5. Do Subscribed Customers Spend More?
--     Compare Avg Spending vs Total Revenue: Subscribed vs Non-Subscribed
-- Finding: Subscribed customers spend less on average compared
--          to non-subscribed customers. Additionally, subscribed
--          customers account for only 26.88% of total revenue.
--          This suggests the current subscription plan lacks
--          enough incentive. The company should redesign its
--          subscription benefits to drive higher spending and
--          increase subscriber count.
-- ------------------------------------------------------------

SELECT
    subscription_status,
    COUNT(customer_id) AS Total_Customers,
    ROUND(AVG(purchase_amount), 2) AS Avg_Spending,
    ROUND(SUM(purchase_amount), 2) AS Total_Revenue,
    ROUND(SUM(purchase_amount) * 100.0 /
        (SELECT SUM(purchase_amount) FROM customer_shopping_behavior), 2) AS Sales_in_Percent
FROM customer_shopping_behavior
GROUP BY subscription_status
ORDER BY Total_Revenue DESC;


-- ------------------------------------------------------------
-- Q6. Top 5 Products With Highest Sales When Discount is Applied
-- Finding: The top 5 products show a heavy reliance on discounts
--          to drive sales. While discounts boost volume, they
--          may reduce profit margins. The company should evaluate
--          whether these products can sustain sales without
--          discounts or if loyalty rewards could replace
--          aggressive discounting strategies.
-- ------------------------------------------------------------

SELECT
    item_purchased,
    SUM(purchase_amount) AS Sales_in_Discount,
    ROUND(100 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Sales_in_Discount_Percent
FROM customer_shopping_behavior
GROUP BY item_purchased
ORDER BY Sales_in_Discount DESC
LIMIT 5;


-- ------------------------------------------------------------
-- Q7. Customer Classification (New / Returning / Loyal)
--     Used for Customer Retention and Acquisition Analysis
-- Finding: The majority of customers fall under the New category,
--          indicating that the business struggles with customer
--          retention. The company should focus heavily on
--          Customer Acquisition strategies while also improving
--          retention programs such as loyalty rewards,
--          personalized offers, and follow-up engagement
--          to convert New customers into Returning and Loyal ones.
-- ------------------------------------------------------------

WITH customer_type AS (
    SELECT
        customer_id,
        previous_purchases,
        CASE
            WHEN previous_purchases = 1 THEN 'New'
            WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
            ELSE 'Loyal'
        END AS customer_segment
    FROM customer_shopping_behavior
)
SELECT
    customer_segment,
    COUNT(*) AS Number_of_Customers
FROM customer_type
GROUP BY customer_segment
ORDER BY Number_of_Customers DESC;


-- ------------------------------------------------------------
-- Q8. Top 3 Most Sold Products From Each Category
-- Finding: Each category has clear top performing products
--          that drive the majority of sales within that category.
--          The company should ensure consistent stock availability
--          for these products and prioritize them in promotions,
--          seasonal campaigns, and bundle offers to maximize
--          category revenue.
-- ------------------------------------------------------------

WITH item_counts AS (
    SELECT
        category,
        item_purchased,
        COUNT(customer_id) AS total_orders,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
    FROM customer_shopping_behavior
    GROUP BY category, item_purchased
)
SELECT
    item_rank,
    category,
    item_purchased,
    total_orders
FROM item_counts
WHERE item_rank <= 3
ORDER BY category, item_rank;


-- ------------------------------------------------------------
-- Q9. Are Repeat Buyers (More Than 5 Purchases) Likely to Subscribe?
-- Finding: Even customers who have made more than 5 purchases
--          are not converting into subscribers. This is a major
--          concern as repeat buyers are the most likely candidates
--          for subscription. The company must urgently revisit
--          its subscription model and offer exclusive perks,
--          discounts, or early access to loyal repeat buyers
--          to drive subscription conversions.
-- ------------------------------------------------------------

SELECT
    subscription_status,
    COUNT(customer_id) AS Repeat_Buyers
FROM customer_shopping_behavior
WHERE previous_purchases > 5
GROUP BY subscription_status
ORDER BY Repeat_Buyers DESC;


-- ------------------------------------------------------------
-- Q10. Revenue Generated From Different Age Groups
-- Finding: Younger age groups generate the highest revenue,
--          suggesting that products and marketing strategies
--          are resonating strongly with younger audiences,
--          likely driven by social media influence and
--          youth-targeted product lines. The company should
--          continue investing in digital and social media
--          marketing while also exploring strategies to attract
--          older age groups to diversify revenue sources.
-- ------------------------------------------------------------

SELECT
    age_group AS Age_Group,
    COUNT(customer_id) AS Total_Customers,
    ROUND(SUM(purchase_amount), 2) AS Total_Purchase
FROM customer_shopping_behavior
GROUP BY age_group
ORDER BY Total_Purchase DESC;


-- ============================================================
--                        END OF FILE
-- ============================================================