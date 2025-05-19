-- 2. Transaction Frequency Analysis

WITH monthly_transactions AS (
    SELECT 
        owner_id,
        EXTRACT(YEAR FROM transaction_date) AS year,
        EXTRACT(MONTH FROM transaction_date) AS month,
        COUNT(*) AS num_transactions
    FROM 
        savings_savingsaccount
    GROUP BY 
        owner_id, 
        EXTRACT(YEAR FROM transaction_date), 
        EXTRACT(MONTH FROM transaction_date)
),
avg_transactions AS (
    SELECT 
        owner_id,
        AVG(num_transactions) AS avg_transactions_per_month
    FROM 
        monthly_transactions
    GROUP BY 
        owner_id
),
categorized_customers AS (
    SELECT 
        CASE 
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        owner_id
    FROM 
        avg_transactions
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    AVG(at.avg_transactions_per_month) AS avg_transactions_per_month
FROM 
    categorized_customers cc
JOIN 
    avg_transactions at ON cc.owner_id = at.owner_id
GROUP BY 
    frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        WHEN frequency_category = 'Low Frequency' THEN 3
    END;