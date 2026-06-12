Create Database retail_price_analysis;

Select Top 10 *
from retail_price_analysis.dbo.retail_price;

---  How many total rows and unique products do we have?
Select
	count (*) as total_row,
	count (distinct product_id) as unique_product,
	count (distinct product_category_name) as unique_categories 
from retail_price_analysis.dbo.retail_price;


--- What are the 9 categories?
SELECT 
    product_category_name,
    COUNT(DISTINCT product_id) AS products_in_category,
    COUNT(*) AS total_rows
FROM retail_price_analysis.dbo.retail_price
GROUP BY product_category_name
ORDER BY total_rows DESC;


--- Price range per product 
SELECT 
    product_id,
    product_category_name,
    COUNT(*) AS observations,
    MIN(unit_price) AS min_price,
    MAX(unit_price) AS max_price,
    ROUND(MAX(unit_price) - MIN(unit_price), 2) AS price_range,
    ROUND(AVG(unit_price), 2) AS avg_price
FROM retail_price_analysis.dbo.retail_price
GROUP BY product_id, product_category_name
ORDER BY price_range DESC;


--- This is to get clean list of products we will drop from the analysis
SELECT 
    product_id,
    product_category_name,
    COUNT(*) AS observations,
    ROUND(MAX(unit_price) - MIN(unit_price), 2) AS price_range
FROM retail_price_analysis.dbo.retail_price
GROUP BY product_id, product_category_name
HAVING COUNT(*) < 6 
    OR ROUND(MAX(unit_price) - MIN(unit_price), 2) = 0
ORDER BY price_range ASC;


-- Create a clean working dataset
-- Excludes products with zero price variation or fewer than 6 observations
SELECT *
INTO retail_pricing_clean
FROM dbo.retail_price
WHERE product_id NOT IN (
    SELECT product_id
    FROM retail_price_analysis.dbo.retail_price
    GROUP BY product_id
    HAVING COUNT(*) < 6 
        OR ROUND(MAX(unit_price) - MIN(unit_price), 2) = 0
);

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_products
FROM retail_pricing_clean;


-- Create updated table with lag_qty
SELECT 
    product_id,
    product_category_name,
    month_year,
    unit_price,
    lag_price,
    qty,
    customers,
    weekday,
    weekend,
    holiday,
    month,
    year,
    comp_1,
    comp_2,
    comp_3,
    LAG(qty) OVER (
        PARTITION BY product_id 
        ORDER BY month_year
    ) AS lag_qty
INTO retail_pricing_clean_v2
FROM retail_pricing_clean;

-- Drop the old table
DROP TABLE retail_pricing_clean;

-- Rename the new table to retail_pricing_clean
EXEC sp_rename 'retail_pricing_clean_v2', 'retail_pricing_clean';

SELECT TOP 5 *
FROM dbo.retail_pricing_clean;


-- Build final table with all calculations in one step
SELECT
    product_id,
    product_category_name,
    month_year,
    unit_price,
    lag_price,
    qty,
    lag_qty,
    comp_1,
    comp_2,
    comp_3,
    ROUND((unit_price - lag_price) / lag_price * 100, 4) AS pct_price_change,
    ROUND((qty - lag_qty) / CAST(lag_qty AS FLOAT) * 100, 4) AS pct_demand_change,
    ROUND((comp_1 + comp_2 + comp_3) / 3, 4) AS avg_comp_price,
    ROUND(unit_price - ((comp_1 + comp_2 + comp_3) / 3), 4) AS price_vs_competitor
INTO retail_pricing_final
FROM dbo.retail_pricing_clean
WHERE unit_price <> lag_price
  AND lag_price IS NOT NULL
  AND lag_qty IS NOT NULL;

-- Confirm final table
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_products
FROM retail_pricing_final;

SELECT TOP 5 * 
FROM retail_pricing_final;

DROP TABLE dbo.retail_pricing_changes;