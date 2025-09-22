
-- ======================================
-- Products & Profitability
-- ======================================

-WITH product_revenue AS (
    SELECT 
        p.productCode,
        p.productName,
        p.productLine,
        SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
        SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS profit
    FROM 
        products p
        JOIN orderdetails od ON p.productCode = od.productCode
    GROUP BY 
        p.productCode, p.productName, p.productLine
),
product_with_ranks AS (
    SELECT 
        pr.*,
        RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
        SUM(total_revenue) OVER () AS company_total_revenue,
        ROUND(
            100 * total_revenue / SUM(total_revenue) OVER (), 2
        ) AS percent_of_total,
        AVG(total_revenue) OVER (PARTITION BY productLine) AS avg_line_revenue
    FROM product_revenue pr
)
SELECT 
    productName,
    productLine,
    total_revenue,
    profit,
    revenue_rank,
    percent_of_total,
    ROUND(
        100 * (total_revenue - avg_line_revenue) / avg_line_revenue, 2
    ) AS diff_from_line_avg_percent
FROM product_with_ranks
ORDER BY revenue_rank;


-- ======================================
-- Customers
-- ======================================

WITH customer_data AS (
    SELECT 
        c.customerNumber,
        c.customerName,
        c.country,
        MAX(o.orderDate) AS last_order_date,
        COUNT(DISTINCT o.orderNumber) AS frequency,
        SUM(od.quantityOrdered * od.priceEach) AS total_revenue
    FROM customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY c.customerNumber, c.customerName, c.country
)
SELECT 
    customerNumber,
    customerName,
    country,
    last_order_date,
    frequency,
    total_revenue
FROM customer_data
ORDER BY total_revenue DESC;


-- ======================================
-- Markets & Geography
-- ======================================

SELECT 
    c.country,
    SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
    COUNT(DISTINCT o.orderNumber) AS order_count
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY total_revenue DESC;


-- ======================================
-- Revenue Dynamics & Seasonality
-- ======================================

WITH monthly_sales AS (
    SELECT
        YEAR(o.orderDate) as sales_year,
        MONTH(o.orderDate) as sales_month,
        DATE_FORMAT(o.orderDate, '%Y-%m') as year_month_str,
        COUNT(DISTINCT o.orderNumber) as order_count,
        ROUND(SUM(od.quantityOrdered * od.priceEach), 2) as monthly_revenue,
        ROUND(AVG(od.quantityOrdered * od.priceEach), 2) as avg_order_value
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE o.status != 'Cancelled'
    GROUP BY YEAR(o.orderDate), MONTH(o.orderDate), DATE_FORMAT(o.orderDate, '%Y-%m')
),
sales_analytics AS (
    SELECT
        sales_year,
        sales_month,
        year_month_str,
        order_count,
        monthly_revenue,
        avg_order_value,
        LAG(monthly_revenue) OVER (ORDER BY sales_year, sales_month) as prev_month_revenue,
        ROUND(
            (monthly_revenue / LAG(monthly_revenue) OVER (ORDER BY sales_year, sales_month) - 1) * 100, 2
        ) as mom_growth_percent,
        SUM(monthly_revenue) OVER (
            PARTITION BY sales_year
            ORDER BY sales_month
            ROWS UNBOUNDED PRECEDING
        ) as yearly_cumulative,
        ROUND(
            AVG(monthly_revenue) OVER (
                ORDER BY sales_year, sales_month
                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
            ), 2
        ) as rolling_3month_avg,
        ROW_NUMBER() OVER (ORDER BY monthly_revenue DESC) as revenue_rank
    FROM monthly_sales
)
SELECT * FROM sales_analytics
ORDER BY sales_year, sales_month


-- ======================================
-- Payments Analysis
-- ======================================

SELECT 
    c.customerNumber,
    c.customerName,
    c.country,
    p.paymentDate,
    o.requiredDate,
    DATEDIFF(p.paymentDate, o.requiredDate) AS delay_days
FROM 
    customers c
    JOIN payments p ON c.customerNumber = p.customerNumber
    JOIN orders o ON c.customerNumber = o.customerNumber
WHERE 
    p.paymentDate IS NOT NULL
    AND o.requiredDate IS NOT NULL;

