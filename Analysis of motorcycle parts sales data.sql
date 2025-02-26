/* he board of directors a company that sells motorcycle parts wants to gain a better understanding of wholesale revenue by product line, 
and how this varies month-to-month and across warehouses. Therefore, in this project, i cleaned the sales data, calculated net revenue for each
product year and group the results by month and warehouse
*/


-- Extracted wholesale data using common table expression
WITH wholesale_data AS (
SELECT product_line, warehouse, total, payment_fee, EXTRACT(month from date) as month -- extracted month from date column
FROM sales
WHERE client_type = 'Wholesale'
GROUP BY product_line,month )


-- Converted the month column to character, calculated net revenue for each product line and group the
-- results by month and warehouse
SELECT product_line,
	CASE WHEN month = 6 THEN 'June'
    	 WHEN month = 7 THEN 'July'
     	 WHEN month = 8 THEN 'August'
     	 ELSE to_char(to_date(month::text, 'month'), 'month') 
	END as month,
	warehouse,
	SUM(total) - SUM(payment_fee) as net_revenue
FROM wholesale_data 
GROUP BY product_line, month, warehouse
ORDER BY net_revenue DESC -- sorted in descending order of net_revenue









