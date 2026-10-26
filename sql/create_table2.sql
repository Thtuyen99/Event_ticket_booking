CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_customer
        PRIMARY KEY (customer_id),

    CONSTRAINT uq_customer_email
        UNIQUE (email)
) ENGINE = InnoDB
COMMENT = 'Stores customer information';

CREATE TABLE ticket_type (
    ticket_type_id INT AUTO_INCREMENT,
    event_id INT NOT NULL,
    type_name VARCHAR(100) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    quantity_issued INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_ticket_type
        PRIMARY KEY (ticket_type_id),

    CONSTRAINT fk_ticket_type_event
        FOREIGN KEY (event_id)
        REFERENCES `event`(event_id),

    CONSTRAINT uq_ticket_type_event_name
        UNIQUE (event_id, type_name),

    CONSTRAINT chk_ticket_price
        CHECK (price >= 0),

    CONSTRAINT chk_ticket_quantity
        CHECK (quantity_issued >= 0)
) ENGINE = InnoDB
COMMENT = 'Stores ticket categories, prices and issue limits';

CREATE TABLE ticket_order (
    order_id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM(
        'Pending', 'Confirmed', 'Cancelled', 'Completed'
    ) NOT NULL DEFAULT 'Pending',

    CONSTRAINT pk_ticket_order
        PRIMARY KEY (order_id),

    CONSTRAINT fk_ticket_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
) ENGINE = InnoDB
COMMENT = 'Stores ticket orders';

CREATE TABLE order_item (
    order_item_id INT AUTO_INCREMENT,
    order_id INT NOT NULL,
    ticket_type_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,

    CONSTRAINT pk_order_item
        PRIMARY KEY (order_item_id),

    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id)
        REFERENCES ticket_order(order_id),

    CONSTRAINT fk_order_item_ticket_type
        FOREIGN KEY (ticket_type_id)
        REFERENCES ticket_type(ticket_type_id),

    CONSTRAINT uq_order_item_order_type
        UNIQUE (order_id, ticket_type_id),

    CONSTRAINT chk_order_item_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_order_item_price
        CHECK (unit_price >= 0)
) ENGINE = InnoDB
COMMENT = 'Stores ticket types and quantities in each order';

CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT,
    order_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_method ENUM(
        'Credit Card', 'Bank Transfer', 'E-Wallet'
    ) NOT NULL,
    payment_status ENUM(
        'Pending', 'Successful', 'Failed', 'Refunded'
    ) NOT NULL DEFAULT 'Pending',
    transaction_reference VARCHAR(100),
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_payment
        PRIMARY KEY (payment_id),

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES ticket_order(order_id),

    CONSTRAINT uq_payment_transaction_reference
        UNIQUE (transaction_reference),

    CONSTRAINT chk_payment_amount
        CHECK (amount >= 0)
) ENGINE = InnoDB
COMMENT = 'Stores payment attempts and transaction results';

CREATE TABLE ticket (
    ticket_id INT AUTO_INCREMENT,
    order_item_id INT NOT NULL,
    ticket_code CHAR(36) NOT NULL,
    ticket_status ENUM(
        'Valid', 'Used', 'Cancelled'
    ) NOT NULL DEFAULT 'Valid',
    issued_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    used_at DATETIME,

    CONSTRAINT pk_ticket
        PRIMARY KEY (ticket_id),

    CONSTRAINT uq_ticket_code
        UNIQUE (ticket_code),

    CONSTRAINT fk_ticket_order_item
        FOREIGN KEY (order_item_id)
        REFERENCES order_item(order_item_id)
) ENGINE = InnoDB
COMMENT = 'Stores individual issued tickets';