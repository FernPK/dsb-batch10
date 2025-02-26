/*
  [/] Create at least 3 tables: restaurant -> create_tables.sql
  - transactions
  - staff
  - menu
  - ingredients
  - ...
  [/] Write SQL queries at least 3 queries -> main.sql
  - WITH clause
  - subquery
  - aggregate function & group by

  replit: https://replit.com/@PornnapatK/homeworksqldsb10pornnapat#main.sql
*/

.mode table
.header on
.read create_tables.sql

-- The top 3 best-selling dishes that have more protein than fat and carbohydrates.
-- WITH clause
WITH protein AS (
  SELECT
    me.menu_id,
    me.name,
    mn.amount protein
  FROM menus me
  JOIN menu_nutrients mn
    ON me.menu_id = mn.menu_id
  JOIN nutrients nu
    ON mn.nutrient_id = nu.nutrient_id
  WHERE nu.nutrient_name = 'Protein'
), 
  carbohydrates AS (
  SELECT
    me.menu_id,
    me.name,
    mn.amount carbohydrates
  FROM menus me
  JOIN menu_nutrients mn
    ON me.menu_id = mn.menu_id
  JOIN nutrients nu
    ON mn.nutrient_id = nu.nutrient_id
  WHERE nu.nutrient_name = 'Carbohydrates'
),
  fat AS (
  SELECT
    me.menu_id,
    me.name,
    mn.amount fat
  FROM menus me
  JOIN menu_nutrients mn
    ON me.menu_id = mn.menu_id
  JOIN nutrients nu
    ON mn.nutrient_id = nu.nutrient_id
  WHERE nu.nutrient_name = 'Fat'
)

SELECT
  p.name,
  p.protein,
  c.carbohydrates,
  f.fat
FROM protein p
JOIN carbohydrates c
  ON p.menu_id = c.menu_id
JOIN fat f
  ON c.menu_id = f.menu_id
WHERE p.protein > c.carbohydrates AND p.protein > f.fat -- assume all nutrients have same unit
ORDER BY p.protein DESC
LIMIT 3;

/* There is only one menu that has more protein than fat and carbohydrates.
+----------------+---------+---------------+------+
|      name      | protein | carbohydrates | fat  |
+----------------+---------+---------------+------+
| Grilled Salmon | 20.0    | 5.0           | 15.5 |
+----------------+---------+---------------+------+
*/


-- Find the priciest main course, then see which other menus are most often ordered with it.
-- Use this to create targeted dessert combos for promotions.
-- subquery
WITH priciest_main_course AS (
  SELECT menu_id
  FROM menus
  WHERE price = (
    SELECT MAX(price)
    FROM menus
  )
)
  
SELECT 
  me.name,
  me.category,
  COUNT(*) AS total_orders
FROM menus me
JOIN transaction_details td
  ON me.menu_id = td.menu_id
WHERE td.transaction_id IN (
  SELECT transaction_id
  FROM transaction_details
  WHERE menu_id IN priciest_main_course
) AND me.menu_id NOT IN priciest_main_course
GROUP BY me.menu_id;

/*
+------------------+-------------+--------------+
|       name       |  category   | total_orders |
+------------------+-------------+--------------+
| Margherita Pizza | Main Course | 1            |
| Caesar Salad     | Appetizer   | 1            |
+------------------+-------------+--------------+
*/


-- Find the average total revenue per order for each menu category.
-- aggregate function & group by
WITH category_revenue AS (
  SELECT
    me.category,
    td.transaction_id,
    SUM(me.price) AS total_revenue
  FROM menus me
  JOIN transaction_details td
    ON me.menu_id = td.menu_id
  GROUP BY me.category, td.transaction_id
)

SELECT
  category,
  AVG(total_revenue) AS avg_revenue_per_order
FROM category_revenue
GROUP BY category
ORDER BY avg_revenue_per_order DESC;

/*
+-------------+-----------------------+
|  category   | avg_revenue_per_order |
+-------------+-----------------------+
| Main Course | 21.32                 |
| Dessert     | 9.388                 |
| Appetizer   | 9.24                  |
+-------------+-----------------------+
*/
