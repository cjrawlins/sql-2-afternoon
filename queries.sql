-- Practice Joins --

-- 1. Get all invoices where the `unit_price` on the `invoice_line` is greater than $0.99.
SELECT * FROM invoice
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price >= 1;

-- 2. Get the `invoice_date`, customer `first_name` and `last_name`, and `total` from all invoices.
SELECT c.first_name, c.last_name, i.invoice_date, i.total 
FROM customer c
JOIN invoice i 
ON c.customer_id = i.customer_id;

-- 3. Get the customer `first_name` and `last_name` and the support rep's `first_name` and `last_name` from all customers. 
--     * Support reps are on the employee table.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e 
ON c.support_rep_id = e.employee_id;

-- 4. Get the album `title` and the artist `name` from all albums.
SELECT al.title, ar.name
FROM album al
JOIN artist ar
ON al.artist_id = ar.artist_id;

-- 5. Get all playlist_track track_ids where the playlist `name` is Music.
SELECT pt.track_id, pl.name
FROM playlist_track pt
JOIN playlist pl
ON pt.playlist_id = pl.playlist_id
WHERE pl.name = 'Music';

-- 6. Get all track `name`s for `playlist_id` 5.
SELECT t.name, pt.playlist_id
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
WHERE pt.playlist_id = 5;

-- 7. Get all track `name`s and the playlist `name` that they're on Alternative & Punk ( 2 joins ).
SELECT t.name, pl.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
JOIN playlist pl
ON pt.playlist_id = pl.playlist_id
WHERE pl.name = 'Alternative & Punk';

-- 8. Get all track `name`s and album `title`s that are the genre `Alternative & Punk` ( 2 joins ).
SELECT t.name, a.title, g.name
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

----- Practice nested queries -----

-- Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT invoice_id, unit_price 
FROM invoice_line
WHERE unit_price IN ( 
  SELECT unit_price
  FROM invoice_line
  WHERE unit_price >= 1
    );

-- Get all playlist tracks where the playlist name is Music.
SELECT track_id 
FROM playlist_track
WHERE playlist_id IN ( 
  SELECT playlist_id
  FROM playlist
  WHERE name = 'Music'
	);


-- Get all track names for playlist_id 5.
SELECT name 
FROM track
WHERE track_id IN ( 
  SELECT track_id
  FROM playlist_track
  WHERE playlist_id = 5
	);

-- Get all tracks where the genre is Comedy.
SELECT track_id, name 
FROM track
WHERE genre_id IN ( 
  SELECT genre_id
  FROM genre
  WHERE name = 'Comedy'
	);

-- Get all tracks where the album is Fireball.
SELECT track_id
FROM track
WHERE album_id IN ( 
  SELECT album_id
  FROM album
  WHERE title = 'Fireball'
	);

-- Get all tracks for the artist Queen ( 2 nested subqueries )
SELECT track_id
FROM track
WHERE album_id IN ( 
  SELECT album_id
  FROM album
  WHERE artist_id IN ( 
  	SELECT artist_id
  	FROM artist
  	WHERE name = 'Queen'
	));

----- Practice updating Rows -----

-- Find all customers with fax numbers and set those numbers to null.
UPDATE customer
SET fax = null;

-- Find all customers with no company (null) and set their company to "Self".
UPDATE customer
SET company = 'Self'
WHERE company IS null;

-- Find the customer Julia Barnett and change her last name to Thompson.
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
UPDATE track
SET composer = 'The darkness around us'
WHERE composer IS null AND genre_id (
  SELECT genre_id
  FROM genre
  WHERE name = 'Metal'
  );

-- Refresh your page to remove all database changes.

----- Group By -----
--Find a count of how many tracks there are per genre. Display the genre name with the count.
SELECT count(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

--Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
SELECT count(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

--Find a list of all artists and how many albums they have.
SELECT ar.name, count(*)
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id
GROUP BY ar.name;

----- Use Distinct -----
-- From the track table find a unique list of all composers.
SELECT DISTINCT composer
FROM track
ORDER BY composer;

-- From the invoice table find a unique list of all billing_postal_codes.
SELECT DISTINCT billing_postal_code
FROM invoice
ORDER BY billing_postal_code;

-- From the customer table find a unique list of all companys.
SELECT DISTINCT company
FROM customer
ORDER BY company;

----- Delete Rows -----
-- Always do a select before a delete to make sure you get back exactly what you want and only what you want to delete! Since we cannot delete anything from the pre-defined tables ( foreign key restraints ), use the following SQL code to create a dummy table:
-- SEE GITHUB FOR TABLE--

-- Copy, paste, and run the SQL code from the summary.
<DONE>

-- Delete all 'bronze' entries from the table.
DELETE FROM practice_delete
WHERE type = 'bronze';

SELECT * FROM practice_delete;

-- Delete all 'silver' entries from the table.
DELETE FROM practice_delete
WHERE type = 'silver';

SELECT * FROM practice_delete;

-- Delete all entries whose value is equal to 150.
DELETE FROM practice_delete
WHERE value = 150;

SELECT * FROM practice_delete;

----- eCommerce Simulation - No Hints -----
-- Let's simulate an e-commerce site. We're going to need users, products, and orders.

-- users need a name and an email.
-- products need a name and a price
-- orders need a ref to product.
-- All 3 need primary keys.


-- Instructions --
-- Create 3 tables following the criteria in the summary.

--NOTE: To do effectivly 4 tables are needed
CREATE TABLE users ( 
  user_id SERIAL PRIMARY KEY, 
  name TEXT , 
  email TEXT 
  );

CREATE TABLE products ( 
  product_id SERIAL PRIMARY KEY, 
  prod_name TEXT, 
  price INT );

CREATE TABLE orders ( 
  order_id SERIAL PRIMARY KEY, 
  user_id INT REFERENCES users(user_id) 
  );

CREATE TABLE order_items ( 
  order_item_id SERIAL PRIMARY KEY, 
  order_id INT REFERENCES orders(order_id), 
  product_id INT REFERENCES products(product_id),
  qty INT
  );


-- Add some data to fill up each table.
    -- At least 3 users, 3 products, 3 orders.
INSERT INTO users
( name, email )
VALUES
( 'User1', 'Email1' ),
( 'User2', 'Email2' ),
( 'User3', 'Email3' );


INSERT INTO products
( prod_name, price )
VALUES
( 'Prod1', 10 ),
( 'Prod2', 20 ),
( 'Prod3', 30 ),
( 'Prod4', 40 ),
( 'Prod5', 50 ),
( 'Prod6', 60 ),
( 'Prod7', 70 );

INSERT INTO orders
( user_id )
VALUES
( 4 ),
( 5 ),
( 6 ),
( 4 ),
( 5 ),
( 6 ),
( 4 );

INSERT INTO order_items
( order_id, product_id, qty )
VALUES
( 1, 1, 5 ),
( 1, 2, 15 ),
( 1, 3, 25 ),
( 1, 4, 1 ),
( 2, 5, 3 ),
( 2, 6, 5 ),
( 3, 7, 6 ),
( 3, 1, 2 ),
( 3, 2, 4 ),
( 4, 3, 6 ),
( 4, 4, 11 ),
( 4, 5, 12 ),
( 5, 6, 13 ),
( 5, 7, 40 ),
( 5, 7, 16 ),
( 6, 1, 2 ),
( 7, 2, 14 ),
( 7, 3, 6 ),
( 7, 4, 11 ),
( 7, 5, 12 ),
( 7, 6, 13 ),
( 7, 7, 40 );

-- Run queries against your data.

-- Get all products for the first order.
SELECT oi.order_id, p.prod_name, oi.qty, p.price, p.price*oi.qty AS total_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
WHERE oi.order_id = 1;

-- Get all orders.
SELECT oi.order_id, u.name, p.prod_name, oi.qty, p.price, p.price*oi.qty AS total_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o on o.order_id = oi.order_id
JOIN users u on u.user_id = o.user_id;

-- Get the total cost of an order ( sum the price of all products on an order ).
SELECT oi.order_id, u.name, SUM(p.price*oi.qty) AS total_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o on o.order_id = oi.order_id
JOIN users u on u.user_id = o.user_id
WHERE oi.order_id = 1
GROUP BY oi.order_id, u.name;

-- Add a foreign key reference from orders to users.
ALTER TABLE order_items
ADD user_id INT;

-- Update the orders table to link a user to each order.
ALTER TABLE order_items
ADD FOREIGN KEY (user_id) REFERENCES users(user_id);

-- Run queries against your data.
-- Get all orders for a user.
SELECT oi.order_id, u.user_id, u.name, p.prod_name, oi.qty, p.price, p.price*oi.qty AS total_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o on o.order_id = oi.order_id
JOIN users u on u.user_id = o.user_id
WHERE u.user_id = 5;

-- Get how many orders each user has.
SELECT u.name, count(*)
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.name;