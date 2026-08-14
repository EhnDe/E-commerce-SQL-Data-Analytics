CREATE DATABASE zepto_SQL_project;
USE zepto_SQL_project;

drop table if exists zepto;

create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,	
quantity INTEGER
);

SELECT * FROM zepto_v2;

ALTER TABLE zepto_v2
RENAME COLUMN ï»¿Category TO category;

-- DATA EXPLORATION

-- count of rows
select count(*) from zepto_v2;

-- sample data
SELECT * FROM zepto_v2
LIMIT 10;

-- null values
SELECT * FROM zepto_v2
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

-- different product categories
SELECT DISTINCT category
FROM zepto_v2
ORDER BY category;

SELECT * FROM zepto_v2;

ALTER TABLE zepto_v2
MODIFY COLUMN sku_id INT FIRST;

UPDATE zepto_v2 z
JOIN (
    SELECT sku_id AS old_sku_id,
           ROW_NUMBER() OVER () AS new_sku_id
    FROM zepto_v2
) x
ON z.sku_id = x.old_sku_id
SET z.sku_id = x.new_sku_id;

SELECT * FROM zepto_v2;

-- products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id)
FROM zepto_v2
GROUP BY outOfStock;

-- product names present multiple times
SELECT name, COUNT(sku_id) AS "Number of SKUs"
FROM zepto_v2
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;

-- DATA CLEANING

-- products with price = 0
SELECT * FROM zepto_v2
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto_v2
WHERE mrp = 0;

-- convert paise to rupees
UPDATE zepto_v2
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT mrp, discountedSellingPrice FROM zepto_v2;

-- DATA ANALYSIS

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_V2
ORDER BY discountPercent DESC
LIMIT 10;

SELECT * FROM zepto_v2;

-- Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name, mrp
FROM zepto_v2
WHERE outOfStock = 'TRUE'
  AND mrp > 300
ORDER BY mrp DESC;

-- Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_v2
GROUP BY category
ORDER BY total_revenue DESC;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto_v2
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the top 10 price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto_v2
WHERE weightInGms >= 100
ORDER BY price_per_gram
LIMIT 10;

-- Q7.Group the products into categories like Low, Medium, Bulk. (top 10)
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto_v2
LIMIT 10;

-- Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto_v2
GROUP BY category
ORDER BY total_weight;