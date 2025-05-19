# DataAnalytics-Assessment

Question 1: High-Value Customers with Multiple Products
The SQL query identifies customers who have both a savings plan (is_regular_savings = 1) and an investment plan (is_a_fund = 1). It joins the users_customuser first_name and last_name and also joins the tables users_customuser, plans_plan, and savings_savingsaccount to calculate the number of each plan type and sum up deposit amounts, then sorts by total deposits in descending order to highlight high-value customers.

Question 2: Transaction Frequency Analysis
The SQL query calculates the average number of transactions per customer per month and categorize them into "High Frequency" (≥10 transactions/month), "Medium Frequency" (3-9 transactions/month) and "Low Frequency" (≤2 transactions/month)
It was gotten by calculating the total monthly_transactions per customer by grouping the customers transactions by year and month and then using the result to calculate the average_transactions by the customers before categorizing the customers into High, Medium and Low frequency based on their average transaction counts. and then aggregating the results based on the frquency of average transactions.

Question 3: Account Inactivity Alert
The SQL query wants to flag accounts with no inflow transactions for over one year by first selecting plans with status_id = 1 (active) before finding the most recent transaction date for each account and then calculating the inactivity period in days before filtering for accounts inactive for more than 365 days

Question 4: Customer Lifetime Value Estimation
The SQL query calculates CLV using the customers account tenure i.e the number of months since they signed up, and then calculating the total transaction count by each customer and also calculatin the profit per transaction (i.e 0.1% of transaction value) using the formula: (transactions/tenure) × 12 × avg_profit_per_transaction
