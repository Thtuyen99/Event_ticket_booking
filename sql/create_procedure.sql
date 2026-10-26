DELIMITER //

CREATE PROCEDURE get_order_summary(
    IN p_order_id INT
)
BEGIN
    SELECT
        o.order_id,
        c.full_name AS customer_name,
        o.order_date,
        o.order_status,
        COALESCE(SUM(oi.quantity), 0) AS total_tickets,
        COALESCE(
            SUM(oi.quantity * oi.unit_price), 0
        ) AS order_total
    FROM ticket_order o
    JOIN customer c
        ON o.customer_id = c.customer_id
    LEFT JOIN order_item oi
        ON o.order_id = oi.order_id
    WHERE o.order_id = p_order_id
    GROUP BY
        o.order_id,
        c.full_name,
        o.order_date,
        o.order_status;
END //

DELIMITER ;
-- CALL get_order_summary(1); // 1 là oder_id