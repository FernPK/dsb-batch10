-- Create tables
CREATE TABLE menus (
  menu_id INT PRIMARY KEY,
  name TEXT,
  category TEXT,
  price REAL
);

INSERT INTO menus (menu_id, name, category, price) VALUES
(1, 'Margherita Pizza', 'Main Course', 12.99),
(2, 'Caesar Salad', 'Appetizer', 8.49),
(3, 'Chocolate Lava Cake', 'Dessert', 6.99),
(4, 'Grilled Salmon', 'Main Course', 18.99),
(5, 'Caprese Salad', 'Appetizer', 9.99),
(6, 'Tiramisu', 'Dessert', 7.49),
(7, 'Beef Burger', 'Main Course', 14.99),
(8, 'Spinach Artichoke Dip', 'Appetizer', 10.49),
(9, 'Cheesecake', 'Dessert', 8.99),
(10, 'Pasta Carbonara', 'Main Course', 16.99),
(11, 'Bruschetta', 'Appetizer', 7.99),
(12, 'Key Lime Pie', 'Dessert', 6.49),
(13, 'Chicken Alfredo', 'Main Course', 15.99),
(14, 'Mozzarella Sticks', 'Appetizer', 9.49),
(15, 'Apple Pie', 'Dessert', 7.99),
(16, 'Fish Tacos', 'Main Course', 13.99),
(17, 'Garlic Bread', 'Appetizer', 5.99),
(18, 'Banana Split', 'Dessert', 9.99),
(19, 'Vegetable Stir-Fry', 'Main Course', 12.99),
(20, 'Calamari', 'Appetizer', 11.99);

CREATE TABLE nutrients (
  nutrient_id INT PRIMARY KEY,
  nutrient_name TEXT
);

INSERT INTO nutrients (nutrient_id, nutrient_name) VALUES
(1, 'Protein'),
(2, 'Carbohydrates'),
(3, 'Fat');

CREATE TABLE menu_nutrients (
  menu_id INT,
  nutrient_id INT,
  amount REAL,
  FOREIGN KEY (menu_id) REFERENCES menus(menu_id)
  FOREIGN KEY (nutrient_id) REFERENCES nutrients(nutrient_id)
);

INSERT INTO menu_nutrients (menu_id, nutrient_id, amount) VALUES
(1, 1, 12.5),
(1, 2, 30.0),
(1, 3, 8.2),
(2, 1, 4.8),
(2, 2, 15.5),
(2, 3, 5.7),
(3, 1, 3.2),
(3, 2, 25.0),
(3, 3, 10.1),
(4, 1, 20.0),
(4, 2, 5.0),
(4, 3, 15.5),
(5, 1, 7.0),
(5, 2, 12.0),
(5, 3, 5.8),
(6, 1, 4.5),
(6, 2, 30.0),
(6, 3, 9.3),
(7, 1, 25.0),
(7, 2, 35.0),
(7, 3, 18.0),
(8, 1, 3.5),
(8, 2, 20.0),
(8, 3, 15.2),
(9, 1, 5.0),
(9, 2, 25.0),
(9, 3, 12.0),
(10, 1, 15.0),
(10, 2, 40.0),
(10, 3, 10.5),
(11, 1, 2.0),
(11, 2, 15.0),
(11, 3, 4.0),
(12, 1, 3.0),
(12, 2, 20.0),
(12, 3, 8.0),
(13, 1, 18.0),
(13, 2, 30.0),
(13, 3, 12.5),
(14, 1, 8.0),
(14, 2, 15.0),
(14, 3, 10.0),
(15, 1, 3.5),
(15, 2, 30.0),
(15, 3, 8.0),
(16, 1, 10.0),
(16, 2, 20.0),
(16, 3, 5.5),
(17, 1, 4.0),
(17, 2, 10.0),
(17, 3, 3.5),
(18, 1, 3.0),
(18, 2, 25.0),
(18, 3, 10.0),
(19, 1, 6.5),
(19, 2, 20.0),
(19, 3, 5.0),
(20, 1, 15.0),
(20, 2, 25.0),
(20, 3, 10.0);

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  firstname TEXT,
  lastname TEXT,
  email TEXT
);

INSERT INTO customers (customer_id, firstname, lastname, email) VALUES
(1, 'John', 'Doe', 'john.doe@example.com'),
(2, 'Jane', 'Smith', 'jane.smith@example.com'),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com'),
(4, 'Emily', 'Williams', 'emily.williams@example.com'),
(5, 'Daniel', 'Brown', 'daniel.brown@example.com'),
(6, 'Sarah', 'Jones', 'sarah.jones@example.com'),
(7, 'David', 'Garcia', 'david.garcia@example.com'),
(8, 'Jessica', 'Martinez', 'jessica.martinez@example.com');

CREATE TABLE transaction_details (
  transaction_id INT,
  menu_id INT,
  amount INT,
  PRIMARY KEY (transaction_id, menu_id),
  FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
  FOREIGN KEY (menu_id) REFERENCES menus(menu_id)
);

INSERT INTO transaction_details (transaction_id, menu_id, amount) VALUES
(1, 2, 1),
(1, 3, 2),
(2, 5, 1),
(2, 7, 2),
(3, 1, 1),
(3, 4, 1),
(4, 6, 2),
(4, 9, 1),
(5, 10, 2),
(5, 11, 1),
(6, 3, 2),
(6, 5, 1),
(7, 8, 2),
(7, 9, 1),
(8, 2, 1),
(8, 4, 1),
(9, 7, 2),
(9, 10, 1),
(10, 1, 2),
(10, 6, 1);

CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY,
  customer_id INT,
  transaction_datetime TEXT,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO transactions (transaction_id, customer_id, transaction_datetime) VALUES
(1, 1, '2023-01-01 10:30:00'),
(2, 2, '2023-01-02 11:15:00'),
(3, 3, '2023-01-03 12:00:00'),
(4, 4, '2023-01-04 13:45:00'),
(5, 5, '2023-01-05 14:20:00'),
(6, 6, '2023-01-06 15:00:00'),
(7, 7, '2023-01-07 16:30:00'),
(8, 8, '2023-01-08 17:10:00'),
(9, 1, '2023-01-09 18:00:00'),
(10, 2, '2023-01-10 19:45:00');

SELECT * FROM menus;
SELECT * FROM nutrients;
SELECT * FROM menu_nutrients;
SELECT * FROM customers;
SELECT * FROM transactions;
SELECT * FROM transaction_details;
