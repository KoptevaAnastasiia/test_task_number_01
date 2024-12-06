USE test_task_work12;

CREATE TABLE IF NOT EXISTS orders_table (
    order_email VARCHAR(255),
    event_date DATE,
    order_id VARCHAR(255),
    subscription_id VARCHAR(255),
    order_country VARCHAR(100),
    order_amount DECIMAL(10, 2),
    product_id VARCHAR(255),
    order_status VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS users_table (
    user_email VARCHAR(255),
    user_id VARCHAR(255),
    user_country VARCHAR(100),
    user_age INT,
    user_gender VARCHAR(10),
    user_utm_source VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS quizzes_table (
    quiz_submit_email VARCHAR(255),
    quiz_id VARCHAR(255),
    datetime DATETIME,
    quiz_funnel VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS products_table (
    product_name VARCHAR(255),
    duration VARCHAR(100),
    datetime DATETIME,
    amount_USD DECIMAL(10, 2),
    product_id VARCHAR(255)
);

LOAD DATA INFILE '/var/lib/mysql-files/orders_new01.csv'
INTO TABLE orders_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/users_table.csv'
INTO TABLE users_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/quizzes_table.csv'
INTO TABLE quizzes_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql-files/products_table.csv'
INTO TABLE products_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM orders_table;
SELECT * FROM users_table;
SELECT * FROM quizzes_table;
SELECT * FROM products_table;
