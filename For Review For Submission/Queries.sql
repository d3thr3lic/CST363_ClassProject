
-- @NicholasSaunders
-- This query below brings out all lines per order within an invoice
-- which contains customer information, date, address, costs and products
-- used within tables of order_header, order_lines, customers.
-- This particular order is set to display all lines and information
-- of order_number 1, but can be adjust easily for other orders or
-- for all order_numbers.
-- This is also contained with a View as it is rather long and 
-- using a View is a lot more managable to handle. The function of it is to
-- treat all of information gathered as it own table, but for historical
-- record keeping purposes.

CREATE VIEW DisplayInvoiceInfo AS
	SELECT c.customer_name ,oh.customer_id, oh.order_number, 
	 	oh.order_date, oh.total_order_value,  
		oh.ship_address, oh.ship_zip_code,oh.ship_state,
        oh.ship_phone, oh.bill_address,oh.bill_zip_code, 
        oh.bill_state, oh.bill_phone, ol.order_seq, ol.partcode,
        ol.quantity, ol.line_value 
	FROM order_header oh JOIN order_lines ol JOIN customers c  
	    ON oh.order_number = ol.order_number 
		AND oh.customer_id = c.customer_id;

-- This is the query that is used to use the query in the Invoice Generation Tables.
-- Please change "LIKE ?" to "= <interger>" to manually use query in database.
SELECT * FROM DisplayInvoiceInfo WHERE order_number LIKE ?;
    
-- This query displays all orders by order_number, and date
-- Sorted by Date
SELECT c.customer_name , oh.order_number, oh.order_date
FROM order_header oh JOIN customers c
    ON oh.customer_id = c.customer_id
    ORDER BY order_date;
    
-- This is an update query that updates total value of all lines in an invoice and
-- has a total of all values per lines each time it a product is added to the order.
-- Please change "LIKE ?" to "= <interger>" to manually use query in database.
UPDATE order_header 
SET total_order_value 
	= (SELECT SUM(line_value) FROM order_lines)
WHERE order_number = 1;
-- END OF QUERIES @NicholasSaunders


-- Ramon Lucindo
--SQL Queries Used in Project 2


-- main_inventory servlet uses:

SELECT * from inventory

-- to display inventory table and all fields


--total_cost servlet uses:

SELECT SUM(list_price * quantity) from inventory;

-- to display total monetary value of everything in the inventory


-- add_item servlet uses:

INSERT INTO inventory (partcode, description, quantity, list_price) VALUES (?, ?, ?, ?);

--to insert one item with all valid and corresponding values for --available fields


SELECT * from inventory;

-- to display inventory table and all fields after adding item


-- delete_item servlet uses:

DELETE FROM inventory WHERE partcode=?;

 -- to delete one entry based on item/part code


SELECT * from inventory;

-- to display inventory table and all fields after deleting item







-- Mitchell Saunders

-- query to create new order for customer (first step for order creation)    
-- This query will always start the total value off at zero dollars, and is hard coded to work with customerid 1
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
        AND s.customer_id = 1 -- custid 1
        AND b.customer_id = 1; -- custid 1
        


-- get the most recently created order number and return it to the user
-- This should be performed immedaitely after the above insert statement
-- This will provide the user with an order number to insert into the order_line screen
SELECT MAX(order_number) as most_recently_created_order_number
FROM order_header;

	

-- inert new order line into table
INSERT INTO order_lines
	(order_number, order_seq, partcode, quantity, line_value)
SELECT 1, (	SELECT IFNULL(MAX(order_seq),0) AS highest_seq -- hard-coded order number 1
			FROM order_lines
			WHERE order_number = 1) + 1, -- hard-coded for order number 1
		"MNR001", 3, list_price * 3 -- hard-coded for product MNR001
FROM inventory
WHERE partcode = "MNR001"; -- hard-coded for product MNR001



-- check to see if desired quantity of product is available, and if it is, then update the inventory table
-- See https://stackoverflow.com/questions/12668701/subquery-in-where-clause-of-update-statement
UPDATE inventory i
INNER JOIN (
	SELECT i.partcode, i.quantity AS available_qty
	FROM inventory i
	WHERE i.partcode = "MNR001" -- hard-coded for product MNR001
) vi ON i.partcode = vi.partcode AND 1 <= vi.available_qty -- hard-coded to remove just 1 from inventory.
SET i.quantity = i.quantity - 1 -- again, hard-coded to decrease 1 from inventory
WHERE i.partcode = "MNR001"; -- hard coded to for product MNR001




-- select statement to show all customers from the customer table to help user pick a customer id
SELECT *
FROM customers;
