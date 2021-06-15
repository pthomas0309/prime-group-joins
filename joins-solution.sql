--1. Get all customers and their addresses.

SELECT * FROM "customers"
JOIN "addresses" 
ON "customers".id = "addresses".customer_id;

--2. Get all orders and their line items (orders, quantity and product).

SELECT "orders".order_date, "line_items".quantity, "products".description FROM "orders"
JOIN "line_items"
ON "orders".id = "line_items".order_id
JOIN "products"
ON "line_items".product_id = "products".id;

--3. Which warehouses have cheetos?

SELECT "products".description, "warehouse".warehouse  
FROM "warehouse"
JOIN "warehouse_product"
ON "warehouse".id = "warehouse_product".warehouse_id
JOIN "products"
ON "products".id = "warehouse_product".product_id
WHERE "products".description LIKE '%cheetos%';

--4. Which warehouses have diet pepsi?

SELECT "products".description, "warehouse".warehouse  
FROM "warehouse"
JOIN "warehouse_product"
ON "warehouse".id = "warehouse_product".warehouse_id
JOIN "products"
ON "products".id = "warehouse_product".product_id
WHERE "products".description LIKE '%diet pepsi%';

--5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.

SELECT "customers".first_name, "customers".last_name, COUNT("orders")
FROM "customers"
JOIN "addresses" 
ON "customers".id = "addresses".customer_id
JOIN "orders"
ON "addresses".id = "orders".address_id
GROUP BY "customers".first_name, "customers".last_name;

--6. How many customers do we have?

SELECT COUNT("customers") AS "number-of-customers" FROM "customers";

--7. How many products do we carry?

SELECT COUNT("products") AS "number-of-products" FROM "products";

--8. What is the total available on-hand quantity of diet pepsi?

SELECT "products".description, SUM("warehouse_product".on_hand) AS "total_on_hand_diet_pepsi" 
FROM "products"
JOIN "warehouse_product"
ON "products".id = "warehouse_product".product_id
WHERE "products".description LIKE '%diet pepsi%'
GROUP BY "products".description;

## Stretch
--9. How much was the total cost for each order?

SELECT "orders".order_date, "line_items".quantity, "products".description, "products".unit_price*"line_items".quantity AS "order_total"
FROM "orders"
JOIN "line_items"
ON "orders".id = "line_items".order_id
JOIN "products"
ON "line_items".product_id = "products".id
GROUP BY "orders".order_date, "line_items".quantity, "products".description, "products".unit_price;

--10. How much has each customer spent in total?

--11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
