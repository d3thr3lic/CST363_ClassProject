-- inner query to check avaiable qty in table before placing order
SELECT quantity
FROM inventory
WHERE partcode = 'MNR001';

-- inner query to check if order number in header table exists
SELECT order_number
FROM order_header
WHERE order_number = 1;

-- inner query for grabbing ship/bill address info from customer
SELECT 
    s.address, s.zip_code, s.state, s.phone,
    b.address, b.zip_code, b.state, b.phone
FROM
    customer_addresses s JOIN customer_addresses b
		ON s.customer_id = b.customer_id
WHERE
    s.address_type = 'SHIP'
		AND b.address_type = 'BILL'
        AND s.customer_id = 1
        AND b.customer_id = 1;

-- query to create new order for customer (first step for order creation)    
-- This query will always start the total value off at zero dollars
INSERT INTO order_header
	(total_order_value, customer_id, ship_address, ship_zip_code,
		ship_state, ship_phone,	bill_address, bill_zip_code, bill_state, bill_phone)
SELECT 
	0, 1, -- the 0 will represent the starting line value, the 1 represents the customer ID that the user will specify
    s.address, s.zip_code, s.state, s.phone,
    b.address, b.zip_code, b.state, b.phone
FROM
    customer_addresses s JOIN customer_addresses b
		ON s.customer_id = b.customer_id
WHERE
    s.address_type = 'SHIP'
		AND b.address_type = 'BILL'
        AND s.customer_id = 1
        AND b.customer_id = 1;
        
-- get the most recently created order number and return it to the user
-- This should be performed immedaitely after the above insert statement
-- This will provide the user with an order number to insert into the order_line screen
SELECT MAX(order_number) as most_recently_created_order_number
FROM order_header;

	
-- inert new order line into table
INSERT INTO order_lines
	(order_number, order_seq, partcode, quantity, line_value)
SELECT 1, (	SELECT IFNULL(MAX(order_seq),0) AS highest_seq -- first number represents the order number that the user will enter
			FROM order_lines
			WHERE order_number = 5) + 1,
		"MNR002", 3, list_price * 3
FROM inventory
WHERE partcode = "MNR002";

-- inner query to get max sequence for that order number
SELECT ifnull(max(order_seq),0) AS highest_seq
FROM order_lines
WHERE order_number = 4;  -- order number represents the current order number that a line is attempting to be added to

-- check to see if desired quantity of product is available, and if it is, then update the inventory table
-- See https://stackoverflow.com/questions/12668701/subquery-in-where-clause-of-update-statement
UPDATE inventory i
INNER JOIN (
	SELECT i.partcode, i.quantity AS available_qty
	FROM inventory i
	WHERE i.partcode = "MNR002"
) vi ON i.partcode = vi.partcode AND 1 <= vi.available_qty -- number represents qty to be decreased.
SET i.quantity = i.quantity - 1 -- number rep. qty to be decreased
WHERE i.partcode = "MNR002";

