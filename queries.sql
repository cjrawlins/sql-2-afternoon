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