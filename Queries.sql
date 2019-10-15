-- The query below brings out all lines per order within an invoice
-- which contains customer information, date, address, costs and products
-- used within tables of order_header, order_lines, customers.
-- This particular order is set to display all lines and information
-- of order_number 1, but can be adjust easily for other orders or
-- for all order_numbers.

SELECT c.customer_name, oh.customer_id, oh.order_number, 
    oh.order_date, oh.total_order_value,  
    oh.ship_address, oh.ship_zip_code,oh.ship_state,oh.ship_phone, 
    oh.bill_address, oh.bill_zip_code,oh.bill_state, oh.bill_phone, 
    ol.order_seq, ol.partcode, ol.quantity, ol.line_value 
FROM order_header oh JOIN order_lines ol JOIN customers c 
    ON oh.order_number = ol.order_number  
    AND oh.customer_id = c.customer_id
    WHERE oh.order_number = 1;
    
-- This query displays all orders by order_number, and date
-- Sorted by Date
SELECT c.customer_name , oh.order_number, oh.order_date
FROM order_header oh JOIN customers c
    ON oh.customer_id = c.customer_id
    ORDER BY order_date;


