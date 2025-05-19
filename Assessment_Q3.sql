-- 3. Account Inactivity Alert

SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE(), MAX(s.transaction_date)) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.id = s.plan_id
WHERE 
    p.status_id = 1
GROUP BY 
    p.id, p.owner_id
HAVING 
    MAX(s.transaction_date) IS NOT NULL
    AND DATEDIFF(CURRENT_DATE(), MAX(s.transaction_date)) > 365
ORDER BY 
    inactivity_days DESC;