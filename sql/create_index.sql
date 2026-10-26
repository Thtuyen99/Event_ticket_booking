USE event_ticket_booking;

-- Index: idx_event_start_time
-- Supports filtering and sorting events by start time.
CREATE INDEX idx_event_start_time
ON `event` (start_time);

-- Index: idx_event_status_start_time
-- Supports searching published events by status and start time.
CREATE INDEX idx_event_status_start_time
ON `event` (event_status, start_time);

-- Index: idx_ticket_order_customer_date
-- Supports retrieving a customer's orders by date.
CREATE INDEX idx_ticket_order_customer_date
ON ticket_order (customer_id, order_date);

-- Index: idx_payment_order_status
-- Supports checking payment attempts for an order.
CREATE INDEX idx_payment_order_status
ON payment (order_id, payment_status);

-- Index: idx_ticket_order_item
-- Supports retrieving tickets issued for an order item.
CREATE INDEX idx_ticket_order_item
ON ticket (order_item_id);