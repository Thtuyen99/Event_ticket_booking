


-- =========================================
-- 1. EVENT_CATEGORY: 4 records
-- =========================================
INSERT INTO event_category (category_id, category_name, description)
VALUES
(1, 'Music', 'Concerts and live music performances'),
(2, 'Sports', 'Sports competitions and tournaments'),
(3, 'Conference', 'Professional conferences and seminars'),
(4, 'Festival', 'Cultural festivals and community events');

-- =========================================
-- 2. VENUE: 4 records
-- =========================================
INSERT INTO venue (venue_id, venue_name, address, capacity)
VALUES
(1, 'SECC', '799 Nguyen Van Linh, District 7, Ho Chi Minh City', 10000),
(2, 'My Dinh National Stadium', 'Nam Tu Liem, Hanoi', 40000),
(3, 'Hoa Binh Theater', '240 Ba Thang Hai, District 10, Ho Chi Minh City', 2000),
(4, 'National Convention Center', 'Pham Hung, Nam Tu Liem, Hanoi', 3500);

-- =========================================
-- 3. EVENT: 5 records
-- =========================================
INSERT INTO `event`
(event_id, category_id, venue_id, event_name,
 description, start_time, end_time, event_status)
VALUES
(1, 1, 1, 'Summer Music Night 2027',
 'A live music concert featuring Vietnamese artists',
 '2027-06-15 19:00:00', '2027-06-15 22:00:00', 'Published'),

(2, 2, 2, 'Hanoi Football Cup 2027',
 'A football exhibition match',
 '2027-07-20 18:00:00', '2027-07-20 21:00:00', 'Published'),

(3, 3, 4, 'Vietnam Technology Summit 2027',
 'Technology and digital transformation conference',
 '2027-08-10 08:30:00', '2027-08-10 17:00:00', 'Published'),

(4, 1, 3, 'Acoustic Evening',
 'An intimate acoustic music performance',
 '2027-05-20 19:30:00', '2027-05-20 21:30:00', 'Completed'),

(5, 4, 1, 'Vietnam Cultural Festival 2027',
 'A festival celebrating Vietnamese culture',
 '2027-09-02 09:00:00', '2027-09-02 21:00:00', 'Draft');

-- =========================================
-- 4. CUSTOMER: 7 records
-- =========================================
INSERT INTO customer
(customer_id, full_name, email, phone)
VALUES
(1, 'Nguyen Minh Anh', 'minhanh01@example.com', '0901234501'),
(2, 'Tran Quoc Bao', 'quocbao02@example.com', '0901234502'),
(3, 'Le Thu Ha', 'thuha03@example.com', '0901234503'),
(4, 'Pham Gia Huy', 'giahuy04@example.com', '0901234504'),
(5, 'Vo Ngoc Linh', 'ngoclinh05@example.com', '0901234505'),
(6, 'Dang Hoang Nam', 'hoangnam06@example.com', '0901234506'),
(7, 'Bui Khanh Vy', 'khanhvy07@example.com', '0901234507');

-- =========================================
-- 5. TICKET_TYPE: 7 records
-- =========================================
INSERT INTO ticket_type
(ticket_type_id, event_id, type_name, price, quantity_issued)
VALUES
(1, 1, 'Standard', 500000, 5000),
(2, 1, 'VIP', 1500000, 500),
(3, 2, 'General Admission', 300000, 15000),
(4, 2, 'Premium Seat', 800000, 3000),
(5, 3, 'Regular Pass', 1000000, 2000),
(6, 3, 'Business Pass', 2500000, 500),
(7, 4, 'Acoustic Ticket', 350000, 1000);

-- =========================================
-- 6. TICKET_ORDER: 6 records
-- =========================================
INSERT INTO ticket_order
(order_id, customer_id, order_date, order_status)
VALUES
(1, 1, '2027-04-01 09:15:00', 'Confirmed'),
(2, 2, '2027-04-02 10:30:00', 'Confirmed'),
(3, 3, '2027-04-03 14:20:00', 'Confirmed'),
(4, 4, '2027-04-04 16:45:00', 'Completed'),
(5, 5, '2027-04-05 11:00:00', 'Confirmed'),
(6, 6, '2027-04-06 08:10:00', 'Pending');

-- =========================================
-- 7. ORDER_ITEM: 6 records
-- =========================================
INSERT INTO order_item
(order_item_id, order_id, ticket_type_id, quantity, unit_price)
VALUES
(1, 1, 1, 2, 500000),
(2, 2, 2, 1, 1500000),
(3, 3, 3, 2, 300000),
(4, 4, 5, 1, 1000000),
(5, 5, 7, 2, 350000),
(6, 6, 6, 1, 2500000);

-- =========================================
-- 8. PAYMENT: 5 records
-- Order 6 has no payment yet.
-- =========================================
INSERT INTO payment
(payment_id, order_id, amount, payment_method,
 payment_status, transaction_reference, payment_date)
VALUES
(1, 1, 1000000, 'E-Wallet', 'Successful',
 'TXN-DEMO-1001', '2027-04-01 09:16:00'),

(2, 2, 1500000, 'Credit Card', 'Successful',
 'TXN-DEMO-1002', '2027-04-02 10:32:00'),

(3, 3, 600000, 'Bank Transfer', 'Successful',
 'TXN-DEMO-1003', '2027-04-03 14:25:00'),

(4, 4, 1000000, 'Credit Card', 'Successful',
 'TXN-DEMO-1004', '2027-04-04 16:47:00'),

(5, 5, 700000, 'E-Wallet', 'Pending',
 'TXN-DEMO-1005', '2027-04-05 11:02:00');

-- =========================================
-- 9. TICKET: 6 records
-- Order item 6 has not been issued a ticket.
-- =========================================
INSERT INTO ticket
(ticket_id, order_item_id, ticket_code, ticket_status, issued_at, used_at)
VALUES
(1, 1, '11111111-1111-4111-8111-111111111111',
 'Valid', '2027-04-01 09:17:00', NULL),

(2, 1, '22222222-2222-4222-8222-222222222222',
 'Valid', '2027-04-01 09:17:00', NULL),

(3, 2, '33333333-3333-4333-8333-333333333333',
 'Valid', '2027-04-02 10:33:00', NULL),

(4, 3, '44444444-4444-4444-8444-444444444444',
 'Valid', '2027-04-03 14:26:00', NULL),

(5, 3, '55555555-5555-4555-8555-555555555555',
 'Valid', '2027-04-03 14:26:00', NULL),

(6, 4, '66666666-6666-4666-8666-666666666666',
 'Used', '2027-04-04 16:48:00', '2027-05-20 19:20:00');
