-- 4. Customer Lifetime Value (CLV) Estimation

WITH customer_metrics AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()) AS tenure_months,
        COUNT(s.id) AS total_transactions,
        SUM(s.confirmed_amount * 0.001) AS total_profit
    FROM 
        users_customuser u
    JOIN 
        savings_savingsaccount s ON u.id = s.owner_id
    WHERE 
        u.date_joined IS NOT NULL
    GROUP BY 
        u.id, u.name, u.date_joined
)
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    CASE 
        WHEN tenure_months > 0 THEN (total_transactions / tenure_months) * 12 * (total_profit / total_transactions)
        ELSE 0
    END AS estimated_clv
FROM 
    customer_metrics
WHERE 
    tenure_months > 0
ORDER BY 
    estimated_clv DESC;