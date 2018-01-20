----------------------------------------------------------------
--          FILTERS
----------------------------------------------------------------

--IN
SELECT item_no, category_name, item_description, vendor
FROM products
WHERE vendor IN (305, 391, 370, 380)
LIMIT 100

-- NOT IN
SELECT item_no, category_name, item_description, vendor
FROM products
WHERE vendor NOT IN (305, 391, 370, 380)
LIMIT 100

--BETWEEN
SELECT item_no, category_name, item_description, vendor
FROM products
WHERE vendor BETWEEN 300 AND 400
LIMIT 100

-- ILIKE
SELECT item_no, category_name, item_description, vendor
FROM products
WHERE vendor BETWEEN 300 AND 400
AND item_description ILIKE '%APPLE%'
LIMIT 100

---------------------------------------------------------------------------------------------------
-- GROUP BY/ HAVING
---------------------------------------------------------------------------------------------------
/* GROUP BY is used whenever you aggregated a measure that also has a dimension in the results.
 you will always be GROUPING BY  the dimensions */
SELECT DISTINCT vendor,category_name, sum(bottle_price), sum(shelf_price)
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
GROUP BY vendor, category_name
ORDER BY 3 DESC;

/*HAVING is a filter for aggregations so if you wanted to only see where the sum(shelf_price) is over 20$ 
you would not put it in the WHERE but in the HAVING. */
SELECT DISTINCT vendor,category_name, sum(bottle_price), sum(shelf_price)
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
GROUP BY vendor, category_name
HAVING sum(shelf_price)>20
ORDER BY 3 DESC;

/* It's time to fix the field names using AS */

SELECT DISTINCT 
vendor,
category_name, 
sum(bottle_price) AS tot_NLC, 
sum(shelf_price) AS tot_Sell_Price

FROM products 

WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)

GROUP BY vendor, category_name

HAVING sum(shelf_price)>20
ORDER BY 3 DESC;

/* Let's say you want to subtract total_nlc from total sell to get an idea of potential profit. Try running 
the code below and review the error message*/
SELECT DISTINCT 
vendor,
category_name, 
sum(bottle_price) AS tot_NLC, 
sum(shelf_price) AS tot_Sell_Price,
sum(shelf_price) - sum(bottle_price)

FROM products 

WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
GROUP BY vendor, category_name
HAVING sum(shelf_price)>20
ORDER BY 3 DESC;

/* SOLUTION USE CAST  cast is a way to change the format of a data type. CAST(field as datatype) */

SELECT DISTINCT 
vendor,
category_name, 
sum(bottle_price) AS tot_NLC, 
sum(shelf_price) AS tot_Sell_Price,
sum(shelf_price) - CAST(sum(bottle_price) AS DEC) as profit
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
GROUP BY vendor, category_name
HAVING sum(shelf_price)>20
ORDER BY 5 DESC;

--------------------------------------------------------
-- AGGREGATES
--------------------------------------------------------
SELECT COUNT(vendor)

-- 271 records 
SELECT COUNT(DISTINCT vendor)
FROM products

SELECT vendor, AVG(shelf_price)
FROM products
GROUP BY vendor
ORDER BY 2

SELECT vendor, MIN(shelf_price)
FROM products
GROUP BY vendor
ORDER BY 2

SELECT vendor, category_name, MAX(shelf_price)
FROM products
GROUP BY vendor
ORDER BY 2

SELECT vendor, category_name, SUM(shelf_price)
FROM products
GROUP BY vendor
ORDER BY 2


SELECT vendor, category_name, SUM(shelf_price), MAX(shelf_price), MIN(shelf_price), AVG(shelf_price)
FROM products
GROUP BY vendor,category_name
ORDER BY 2

/* Example for nesting aggregates: CANNOT BE DONE unless doing a subselect.
Example of why you might do this
Count how many hours you worked in a given week then find the average for the week. */

SELECT DISTINCT AVG(COUNT(*))
FROM products


---------------------------------------------------------------------------------------------
-- * BONUS* AGGREGATES for Statistics
---------------------------------------------------------------------------------------------
/* Corr calculates the pearsons correlation a correlation of 1 means a perfect positive
a correlation of -1 means a perfect negative and a correlation of 0 means no correlation */
-- corr(Y,X)
SELECT corr(shelf_price, case_cost)
FROM products

--population covariance
SELECT covar_pop(shelf_price, case_cost)
FROM products

--sample covariance
SELECT covar_samp(shelf_price, case_cost)
FROM products

-- regr_avgx average of the independent variable (sum(X)/N)
SELECT regr_avgx(shelf_price, case_cost)
FROM products

-- regr_avgy(Y, X)average of the dependent variable (sum(Y)/N)
SELECT regr_avgy(shelf_price, case_cost)
FROM products

-- regr_count(Y, X) number of input rows in which both expressions are nonnull
SELECT regr_count(shelf_price, case_cost)
FROM products

--regr_intercept(Y,X) y-intercept of the least-squares-fit linear equation determined by 
-- the (X,Y) pairs
SELECT	regr_intercept(shelf_price, case_cost)
FROM products
   
-- regr_r2(Y,X) square of the correlation coefficient
SELECT	regr_r2(shelf_price, case_cost)
FROM products

-- regr_slope(Y,X) slope of the least squares fit
SELECT	regr_intercept(shelf_price, case_cost)
FROM products


--stddev(expression) Standard Deviation sample
SELECT vendor, stddev(shelf_price)
FROM products
GROUP BY vendor
ORDER BY 2

--stddev_pop(expression) Standard deviation population
SELECT vendor, stddev_pop(shelf_price)
FROM products
GROUP BY vendor
ORDER BY 2



