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

INSERT INTO customer_addresses VALUES(1, 'ship', '1338 Cecil Street', 60089, 'IL','398-643-9782'),
(1, 'bill', '1338 Cecil Street', 60089, 'IL','398-643-9782'),
(2, 'ship', '4413 Hill Haven Drive', 98433, 'WA','509-764-9884'),
(2, 'bill', '4605 Calico Drive', 98801, 'WA','360-823-2829'),
(3, 'ship', '2161 Sycamore Lake Road', 54301, 'WI','262-909-9892'),
(3, 'bill', '1910 Anmoore Road', 11101, 'NY','585-266-6935'),

(4, 'ship', '3317 Melm Street',  02852, 'RI','401-736-8087'),
(4, 'bill', '3317 Melm Street', 02852, 'RI','401-736-8087'),

(5, 'ship', '1230 Columbia Road', 19711, 'DE','302-498-7523'),
(5, 'bill', '1588 Myra Street', 02903, 'RI','401-271-4547'),

(6, 'ship', '4460 Poe Road', 77520, 'TX','361-391-3881'),
(6, 'bill', '4460 Poe Road', 77520, 'TX','361-391-3881'),

(7, 'ship', '3863 Hood Avenue', 92123, 'CA','209-513-9239'),
(7, 'bill', '3863 Hood Avenue', 92123, 'CA','209-513-9239'),

(8, 'ship', '3715 Kidd Avenue', 99701, 'AK','907-226-6623'),
(8, 'bill', '2801 Hickman Street', 60173, 'IL','708-412-2242'),

(9, 'ship', '4271 Hershell Hollow Road', 98119, 'WA','509-687-7931'),
(9, 'bill', '4271 Hershell Hollow Road', 98119, 'WA','509-687-7931'),

(10, 'ship', '4178 Millbrook Road', 60090, 'IL','312-258-8971'),
(10, 'bill', '3424 Willison Street', 55303, 'MN','952-277-6535');


-- Data entry for inventory ( partcode, description, quanity, list_price)

INSERT INTO inventory VALUES
('MNR001', 'Variety Pack No Grain(Lamb, Chicken, Beef, Salmon and Turkey) 50 cans/box', 100, 59),
('MNR002', 'No Grain Lamb Natural Mix 50 cans/box', 100, 59),
('MNR003', 'No Grain Beef Natural Mix 50 cans/box', 100, 59),
('MNR004', 'No Grain Chicken Natural Mix 50 cans/box', 100, 59),
('MNR005', 'No Grain Salmon Natural Mix 50 cans/box', 100, 59),
('MNR006', 'No Grain Turkey Natural Mix 50 cans/box', 100, 59),
('MNR007', 'No Grain Duck Natural Mix 50 cans/box', 100, 59),
('MNR008', 'Variety Pack All Natural (Lamb, Chicken, Beef, Salmon, Turkey and Duck) 10 sticks/pouch, 50/box', 100, 49),
('MNR009', 'All Natural Lamb Chews 10 sticks/pouch, 50/box', 100, 49), 
('MNR010', 'All Natural Beef Chews 10 sticks/pouch, 50/box', 100, 49),
('MNR011', 'All Natural Chicken Chews 10 sticks/pouch, 50/box', 100, 49),
('MNR012', 'All Natural Salmon Chews 10 sticks/pouch, 50/box', 100, 49),
('MNR013', 'All Natural Turkey Chews 10 sticks/pouch, 50/box', 100, 49),
('MNR014', 'All Natural Duck Chews 10 sticks/pouch, 50/box', 100, 49),
('MNR015', 'Variety Pack No Grain(Lamb, Chicken, Beef, Salmon and Turkey) 25 cans/box', 100, 29),
('MNR016', 'No Grain Lamb Natural Mix 25 cans/box', 100, 29),
('MNR017', 'No Grain Beef Natural Mix 25 cans/box', 100, 29),
('MNR018', 'No Grain Chicken Natural Mix 25 cans/box', 100, 29),
('MNR019', 'No Grain Turkey Natural Mix 25 cans/box', 100, 29),
('MNR020', 'No Grain Duck Natural Mix 25 cans/box', 100, 29),
('MNR021', 'Variety Pack All Natural (Lamb, Chicken, Beef, Salmon, Turkey and Duck) 10 sticks/pouch, 25/box', 100, 29),
('MNR022', 'All Natural Lamb Chews 10 sticks/pouch, 25/box', 100, 29),
('MNR023', 'All Natural Beef Chews 10 sticks/pouch, 25/box', 100, 29),
('MNR024', 'All Natural Chicken Chews 10 sticks/pouch, 25/box', 100, 29),
('MNR025', 'All Natural Salmon Chews 10 sticks/pouch, 25/box', 100, 29),
('MNR026', 'All Natural Turkey Chews 10 sticks/pouch, 25/box', 100, 29),
('MNR027', 'All Natural Duck Chews 10 sticks/pouch, 25/box', 100, 29);

