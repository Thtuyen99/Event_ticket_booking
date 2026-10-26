CREATE TABLE event_category (
    category_id INT AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(500),

    CONSTRAINT pk_event_category
        PRIMARY KEY (category_id),

    CONSTRAINT uq_event_category_name
        UNIQUE (category_name)
) ENGINE = InnoDB
COMMENT = 'Stores event categories';

CREATE TABLE venue (
    venue_id INT AUTO_INCREMENT,
    venue_name VARCHAR(150) NOT NULL,
    address VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,

    CONSTRAINT pk_venue
        PRIMARY KEY (venue_id),

    CONSTRAINT chk_venue_capacity
        CHECK (capacity > 0)
) ENGINE = InnoDB
COMMENT = 'Stores event venues';

CREATE TABLE `event` (
    event_id INT AUTO_INCREMENT,
    category_id INT NOT NULL,
    venue_id INT NOT NULL,
    event_name VARCHAR(200) NOT NULL,
    description TEXT,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    event_status ENUM(
        'Draft', 'Published', 'Cancelled', 'Completed'
    ) NOT NULL DEFAULT 'Draft',

    CONSTRAINT pk_event
        PRIMARY KEY (event_id),

    CONSTRAINT fk_event_category
        FOREIGN KEY (category_id)
        REFERENCES event_category(category_id),

    CONSTRAINT fk_event_venue
        FOREIGN KEY (venue_id)
        REFERENCES venue(venue_id),

    CONSTRAINT chk_event_time
        CHECK (end_time > start_time)
) ENGINE = InnoDB
COMMENT = 'Stores events and their schedules';