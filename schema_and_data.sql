-- Week 2 SQL Assignment: sample e-commerce database
-- Tables: customers, orders

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id  INTEGER PRIMARY KEY,
    first_name   TEXT NOT NULL,
    last_name    TEXT NOT NULL,
    email        TEXT NOT NULL,
    city         TEXT,
    signup_date  DATE
);

CREATE TABLE orders (
    order_id     INTEGER PRIMARY KEY,
    customer_id  INTEGER NOT NULL,
    order_date   DATE NOT NULL,
    amount       REAL NOT NULL,
    status       TEXT NOT NULL CHECK (status IN ('completed','cancelled','returned')),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (1, 'Ava', 'Thompson', 'ava.thompson@example.com', 'Denver', '2023-01-12');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (2, 'Liam', 'Garcia', 'liam.garcia@example.com', 'Austin', '2023-02-03');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (3, 'Noah', 'Chen', 'noah.chen@example.com', 'Seattle', '2023-02-20');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (4, 'Emma', 'Patel', 'emma.patel@example.com', 'Chicago', '2023-03-05');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (5, 'Oliver', 'Nguyen', 'oliver.nguyen@example.com', 'Boston', '2023-03-18');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (6, 'Sophia', 'Ahmed', 'sophia.ahmed@example.com', 'Portland', '2023-04-02');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (7, 'Elijah', 'Rossi', 'elijah.rossi@example.com', 'Miami', '2023-04-22');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (8, 'Isabella', 'Kim', 'isabella.kim@example.com', 'Denver', '2023-05-09');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (9, 'Mateo', 'Fischer', 'mateo.fischer@example.com', 'Austin', '2023-05-30');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (10, 'Mia', 'Johnson', 'mia.johnson@example.com', 'Seattle', '2023-06-14');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (11, 'Lucas', 'Silva', 'lucas.silva@example.com', 'Chicago', '2023-07-01');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (12, 'Charlotte', 'Novak', 'charlotte.novak@example.com', 'Boston', '2023-07-19');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (13, 'Ethan', 'Brooks', 'ethan.brooks@example.com', 'Portland', '2023-08-08');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (14, 'Amelia', 'Diaz', 'amelia.diaz@example.com', 'Miami', '2023-08-27');
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date) VALUES (15, 'James', 'Wallace', 'james.wallace@example.com', 'Denver', '2023-09-15');

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (48, 12, '2023-09-01', 237.89, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (54, 14, '2023-09-01', 86.55, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (44, 11, '2023-09-03', 34.7, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (7, 1, '2023-09-07', 131.76, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (15, 4, '2023-09-12', 38.43, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (57, 14, '2023-09-15', 132.6, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (16, 5, '2023-09-21', 201.63, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (20, 5, '2023-09-21', 349.82, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (58, 15, '2023-09-22', 344.0, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (4, 1, '2023-09-23', 279.19, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (21, 5, '2023-09-26', 235.85, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (13, 3, '2023-09-27', 165.06, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (61, 15, '2023-10-03', 175.41, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (40, 10, '2023-10-10', 183.08, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (41, 10, '2023-10-11', 192.32, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (22, 6, '2023-10-12', 105.04, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (26, 7, '2023-10-12', 92.19, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (52, 13, '2023-10-21', 119.04, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (33, 8, '2023-10-25', 210.67, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (9, 2, '2023-10-27', 48.5, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (38, 9, '2023-10-27', 81.51, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (2, 1, '2023-10-28', 283.55, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (30, 8, '2023-10-29', 356.91, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (35, 8, '2023-11-07', 323.97, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (36, 8, '2023-11-07', 338.99, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (62, 15, '2023-11-07', 127.17, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (17, 5, '2023-11-15', 353.14, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (56, 14, '2023-11-18', 131.22, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (31, 8, '2023-11-20', 228.93, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (55, 14, '2023-11-22', 113.0, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (47, 12, '2023-11-27', 244.9, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (23, 6, '2023-11-30', 93.97, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (53, 13, '2023-12-05', 87.44, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (27, 7, '2023-12-07', 111.46, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (42, 10, '2023-12-08', 134.51, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (5, 1, '2023-12-18', 246.09, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (34, 8, '2023-12-27', 191.79, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (59, 15, '2024-01-03', 332.37, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (6, 1, '2024-01-08', 225.28, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (50, 12, '2024-01-08', 264.58, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (39, 10, '2024-01-09', 104.5, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (8, 2, '2024-01-18', 51.07, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (28, 7, '2024-01-21', 187.82, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (18, 5, '2024-01-26', 202.47, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (37, 9, '2024-01-28', 46.16, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (43, 10, '2024-01-31', 235.21, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (14, 3, '2024-02-02', 159.93, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (25, 7, '2024-02-03', 95.47, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (63, 15, '2024-02-03', 220.28, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (51, 13, '2024-02-08', 74.3, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (1, 1, '2024-02-11', 295.52, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (24, 6, '2024-02-13', 105.26, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (66, 15, '2024-02-14', 313.56, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (29, 8, '2024-02-23', 196.13, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (65, 15, '2024-02-24', 276.97, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (11, 3, '2024-02-26', 121.46, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (19, 5, '2024-02-28', 406.65, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (32, 8, '2024-03-02', 265.07, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (45, 12, '2024-03-03', 285.98, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (49, 12, '2024-03-03', 194.55, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (3, 1, '2024-03-07', 298.83, 'cancelled');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (64, 15, '2024-03-12', 280.83, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (10, 3, '2024-03-13', 160.13, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (12, 3, '2024-03-14', 165.08, 'completed');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (46, 12, '2024-03-15', 275.37, 'returned');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (60, 15, '2024-03-15', 95.66, 'completed');
