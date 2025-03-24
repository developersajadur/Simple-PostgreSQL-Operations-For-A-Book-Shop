-- Database Creation --
CREATE DATABASE bookstore_db;

-- Create books Table --
CREATE TABLE books (
    id SERIAL PRIMARY KEY ,
    title VARCHAR(80) NOT NULL,
    author VARCHAR(50) NOT NULL,
    price INT NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    published_date DATE NOT NULL
);

-- Create Customer Table --
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    joined_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Create orders Table --
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) NOT NULL,
    book_id INT REFERENCES books(id) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
   order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Insert sample books into the books table --
INSERT INTO books (title, author, price, stock, published_date) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 15, 10, '1925-04-10'),
('To Kill a Mockingbird', 'Harper Lee', 18, 8, '1960-07-11'),
('1984', 'George Orwell', 20, 15, '1949-06-08'),
('Pride and Prejudice', 'Jane Austen', 12, 20, '1813-01-28'),
('The Catcher in the Rye', 'J.D. Salinger', 14, 12, '1951-07-16'),
('Moby-Dick', 'Herman Melville', 22, 5, '1851-10-18'),
('War and Peace', 'Leo Tolstoy', 25, 7, '1869-01-09'),
('The Hobbit', 'J.R.R. Tolkien', 18, 14, '1937-09-21'),
('The Lord of the Rings', 'J.R.R. Tolkien', 30, 9, '1954-07-29'),
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 25, 20, '1997-06-26');


-- Insert sample customers
INSERT INTO customers (name, email) VALUES
('John Doe', 'johndoe@example.com'),
('Jane Smith', 'janesmith@example.com'),
('Michael Johnson', 'michael.j@example.com'),
('Emily Davis', 'emily.d@example.com'),
('David Brown', 'david.b@example.com');


-- Insert sample orders --
INSERT INTO orders (customer_id, book_id, quantity) VALUES
(1, 3, 2),
(2, 5, 1),
(3, 2, 4),
(4, 7, 3),
(5, 1, 2);


-- Find books that are out of stock --
SELECT * FROM books WHERE stock = 0;


-- Retrieve the most expensive book in the store --
SELECT * FROM books ORDER BY price DESC LIMIT 1;


--  Find the total number of orders placed by each customer --
SELECT customers.name, ROUND(AVG(orders.quantity)) as total_orders from customers
JOIN orders ON orders.customer_id = customers.id
GROUP BY customers.id, customers.name;




-- Calculate the total revenue generated from book sales --
SELECT SUM(books.price * orders.quantity) as total_revenue FROM books
JOIN orders ON orders.book_id = books.id;



-- List all customers who have placed more than one order --
SELECT customers.name, COUNT(orders.id) as orders_count FROM customers
JOIN orders ON orders.customer_id = customers.id
GROUP BY customers.id, customers.name
HAVING COUNT(orders.id) > 1;


--  Find the average price of books in the store --
SELECT ROUND(AVG(books.price)) as average_price FROM books;



-- Increase the price of all books published before 2000 by 10% --
UPDATE books SET price = price * 1.1 WHERE published_date < '2000-01-01'; 


-- Delete customers who haven't placed any orders --
DELETE FROM customers WHERE id NOT IN (
    SELECT DISTINCT customer_id FROM orders
);




-- Show the list of customers --
SELECT * FROM customers;


-- Show the list of books --
SELECT * FROM books;


-- Show the list of orders --
SELECT * FROM orders;