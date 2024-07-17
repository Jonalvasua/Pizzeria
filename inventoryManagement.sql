/*  CLIENT BRIEF - PIZZERIA:
 
		STOCK CONTROL REQUIREMENTS:
    
			* Wants to be able to know when it's time to order new stock
			* To do this we're going to need more info about
				- what ingredients go into each pizza
				- their quantity based on the size of the pizza
				- the existing stock level
			* We'll assume the lead time for delivery by suppliers is the same for all ingredients.
            
		STAFF DATA REQUIREMENTS:
			
            * Wants to know which staff members are working when
            * Based on the staff salary information, how much each pizza costs (ingredients + chefs + delivery)

*/

/* DASHBOARD 1 - ORDER ACTIVITY
	
    For this, we will need a dashboard with the following data:
		1. Total orders
        2. Total sales
        3. Total items
        4. Average order value
        5. Sales by category
        6. Top selling intems
        7. Orders by hour
        8. Sles by hour
        9. Orders by address
        10. Orders by delivery/pick up
stock1
*/

SELECT 
	o.order_id,
    i.item_price,
	o.quantity,
    i.item_cat,
    i.item_name,
    o.created_at,
    a.delivery_address1,
    a.delivery_city,
    a.delivery_zipcode,
    o.delivery
FROM 
	orders o
    LEFT JOIN item i ON o.item_id = i.item_id
    LEFT JOIN address a ON o.add_id = a.add_id;
    
/* DASHBOARD 2 - INVENTORY MANAGEMENT

	This will be a lot more complicated than the orders. Mainly because we need to calculate how much inventory we're using and then identify inventory that needs reordering.
    We also want to calculate how much pizza costs to make based on the cost of the ingredients so we can keep an eye on pricing and P/L.
    
    Here is what we need:
		1. Total quantity by ingredient
        2. Total cost of ingredients
        3. Calculated cost of pizza
        4. Percentage stock remaining by ingredient

*/
/* VIEW CREATED AS stock1

SELECT 
s1.item_name,
s1.ing_id,
s1.ing_name,
s1.ing_weight,
s1.ing_price,
s1.order_quantity,
s1.recipe_quantity,
s1.order_quantity*s1.recipe_quantity AS ordered_weight,
s1.ing_price/s1.ing_weight AS unit_cost,
(s1.order_quantity*s1.recipe_quantity)*(s1.ing_price/s1.ing_weight) AS ingredient_cost
FROM (SELECT 
	o.item_id,
	i.sku,
	i.item_name,
	r.ing_id,
	ing.ing_name,
	r.quantity AS recipe_quantity,
	SUM(o.quantity) AS order_quantity,
	ing.ing_weight,
    ing.ing_price
FROM 
	orders o
	LEFT JOIN item i ON o.item_id = i.item_id
    LEFT JOIN recipe r ON i.sku = r.recipe_id
    LEFT JOIN ingredient ing ON ing.ing_id = r.ing_id
GROUP BY 
	o.item_id, 
	i.sku, 
    i.item_name,
    r.ing_id,
    r.quantity,
    ing.ing_name,
    ing.ing_weight,
    ing.ing_price) s1 */

SELECT * FROM stock1;


