-- Data entry for customers (customer_id, customer_name):

INSERT INTO customers VALUES(1, 'Science Food'),
(2, 'Together Pet'),
(3, 'Pet Innovate'),
(4, 'Petaza'),
(5, 'Petex'),
(6, 'Dog Sturdy'),
(7, 'Dogorzo'),
(8, 'The Healthy Dog'),
(9, 'Platinum Dog'),
(10, 'Dogmart');

-- Data entry for customer_addresses (customer_id, address_type, address, zip_code, state)

INSERT INTO customer_addresses VALUES(1, 'SHIP', '1338 Cecil Street', 60089, 'IL','398-643-9782'),
(1, 'BILL', '1338 Cecil Street', 60089, 'IL','398-643-9782'),
(2, 'SHIP', '4413 Hill Haven Drive', 98433, 'WA','509-764-9884'),
(2, 'BILL', '4605 Calico Drive', 98801, 'WA','360-823-2829'),
(3, 'SHIP', '2161 Sycamore Lake Road', 54301, 'WI','262-909-9892'),
(3, 'BILL', '1910 Anmoore Road', 11101, 'NY','585-266-6935'),

(4, 'SHIP', '3317 Melm Street',  02852, 'RI','401-736-8087'),
(4, 'BILL', '3317 Melm Street', 02852, 'RI','401-736-8087'),

(5, 'SHIP', '1230 Columbia Road', 19711, 'DE','302-498-7523'),
(5, 'BILL', '1588 Myra Street', 02903, 'RI','401-271-4547'),

(6, 'SHIP', '4460 Poe Road', 77520, 'TX','361-391-3881'),
(6, 'BILL', '4460 Poe Road', 77520, 'TX','361-391-3881'),

(7, 'SHIP', '3863 Hood Avenue', 92123, 'CA','209-513-9239'),
(7, 'BILL', '3863 Hood Avenue', 92123, 'CA','209-513-9239'),

(8, 'SHIP', '3715 Kidd Avenue', 99701, 'AK','907-226-6623'),
(8, 'BILL', '2801 Hickman Street', 60173, 'IL','708-412-2242'),

(9, 'SHIP', '4271 Hershell Hollow Road', 98119, 'WA','509-687-7931'),
(9, 'BILL', '4271 Hershell Hollow Road', 98119, 'WA','509-687-7931'),

(10, 'SHIP', '4178 Millbrook Road', 60090, 'IL','312-258-8971'),
(10, 'BILL', '3424 Willison Street', 55303, 'MN','952-277-6535');


-- Data entry for inventory ( partcode, description, quanity, list_price)

INSERT INTO inventory VALUES
('MNR001', 'Variety Pack No Grain(Lamb, Chicken, Beef, Salmon and Turkey) 50 cans/box', 100, 459.99),
('MNR002', 'No Grain Lamb Natural Mix 50 cans/box', 100, 459.99),
('MNR003', 'No Grain Beef Natural Mix 50 cans/box', 100, 459.99),
('MNR004', 'No Grain Chicken Natural Mix 50 cans/box', 100, 459.99),
('MNR005', 'No Grain Salmon Natural Mix 50 cans/box', 100, 459.99),
('MNR006', 'No Grain Turkey Natural Mix 50 cans/box', 100, 459.99),
('MNR007', 'No Grain Duck Natural Mix 50 cans/box', 100, 459.99),
('MNR008', 'Variety Pack All Natural (Lamb, Chicken, Beef, Salmon, Turkey and Duck) 10 sticks/pouch, 50/box', 100, 499.99),
('MNR009', 'All Natural Lamb Chews 10 sticks/pouch, 50/box', 100, 499.99), 
('MNR010', 'All Natural Beef Chews 10 sticks/pouch, 50/box', 100, 499.99),
('MNR011', 'All Natural Chicken Chews 10 sticks/pouch, 50/box', 100, 499.99),
('MNR012', 'All Natural Salmon Chews 10 sticks/pouch, 50/box', 100, 499.99),
('MNR013', 'All Natural Turkey Chews 10 sticks/pouch, 50/box', 100, 499.99),
('MNR014', 'All Natural Duck Chews 10 sticks/pouch, 50/box', 100, 499.99),
('MNR015', 'Variety Pack No Grain(Lamb, Chicken, Beef, Salmon and Turkey) 25 cans/box', 100, 259.99),
('MNR016', 'No Grain Lamb Natural Mix 25 cans/box', 100, 259.99),
('MNR017', 'No Grain Beef Natural Mix 25 cans/box', 100, 259.99),
('MNR018', 'No Grain Chicken Natural Mix 25 cans/box', 100, 259.99),
('MNR019', 'No Grain Turkey Natural Mix 25 cans/box', 100, 259.99),
('MNR020', 'No Grain Duck Natural Mix 25 cans/box', 100, 259.99),
('MNR021', 'Variety Pack All Natural (Lamb, Chicken, Beef, Salmon, Turkey and Duck) 10 sticks/pouch, 25/box', 100, 299.99),
('MNR022', 'All Natural Lamb Chews 10 sticks/pouch, 25/box', 100, 299.99),
('MNR023', 'All Natural Beef Chews 10 sticks/pouch, 25/box', 100, 299.99),
('MNR024', 'All Natural Chicken Chews 10 sticks/pouch, 25/box', 100, 299.99),
('MNR025', 'All Natural Salmon Chews 10 sticks/pouch, 25/box', 100, 299.99),
('MNR026', 'All Natural Turkey Chews 10 sticks/pouch, 25/box', 100, 299.99),
('MNR027', 'All Natural Duck Chews 10 sticks/pouch, 25/box', 100, 299.99)

