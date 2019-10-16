
--@NicholasSaunders
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
-- END OF QUERIES @NicholasSaunders

