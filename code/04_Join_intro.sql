/* Before creating your joins draw a model of your database 
and how your data will connect. 

All tables will often be able to link directly into a Primary transaction table
or Fact Table.

In some cases you may need to join one table to another table and then to a primary table
in effect daisy chaining tables together. You would do this because you need info from 2 tables that have
no way to connect and a third table assists in this. */

SELECT DISTINCT a.store,a.county, b.population
FROM sales a
JOIN counties b
ON a.county=b.county
WHERE a.county='Scott'

/*
a = sales
b = counties
c = stores
d = products
*/

SELECT DISTINCT b.county, c.name, c.store_status,a.description, a.state_btl_cost, d.shelf_price
FROM sales a
JOIN counties b
ON a.county=b.county
JOIN stores c
ON a.store = c.store
JOIN products d
ON a.item = d.item_no
WHERE a.county='Scott'
LIMIT 100




