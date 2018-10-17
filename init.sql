-- -- -- Joins -- -- --
-- 1 --
SELECT *
FROM Invoice i
JOIN InvoiceLine il
on i.InvoiceId = il.InvoiceId
WHERE il.UnitPrice > 0.99;

-- 2 --
SELECT i.InvoiceDate, c.FirstName, c.LastName, i.Total
FROM Customer c
JOIN Invoice i
ON i.CustomerId = c.CustomerId;

-- 3 --
SELECT c.FirstName, c.LastName, e.FirstName, e.LastName
FROM Customer c
JOIN Employee e
ON e.EmployeeId = c.SupportRepId;

-- 4 --
SELECT ar.Name, al.Title
FROM Album al
JOIN Artist ar
ON al.ArtistId = ar.ArtistId;

-- 5 --
SELECT pt.TrackId
FROM PlaylistTrack pt
JOIN Playlist pl 
ON pl.PlaylistId = pt.PlaylistId
WHERE pl.Name = "Music";

-- 6 --
SELECT tr.Name
FROM Track tr
JOIN PlaylistTrack pt
ON tr.TrackId = pt.TrackId
WHERE pt.PlaylistId = 5;

-- 7 --
SELECT tr.Name, pl.Name
FROM Playlist pl
JOIN PlaylistTrack pt
ON pl.PlaylistId = pt.PlaylistId
JOIN Track tr
ON tr.TrackId = pt.TrackId;

-- 8 --
SELECT tr.name, al.Title
FROM Track tr
JOIN Genre gn
ON tr.GenreId = gn.GenreId
JOIN Album al
ON tr.AlbumId = al.AlbumId
WHERE gn.Name = "Alternative";

-- Black Diamond --
SELECT tr.Name, ar.Name, al.Title, gn.Name
FROM Track tr
JOIN Album al
ON al.AlbumId = tr.AlbumId
JOIN Artist ar
ON ar.ArtistId = al.ArtistId
JOIN Genre gn
ON gn.GenreId = tr.GenreId
JOIN PlaylistTrack pt
ON pt.TrackId = tr.TrackId
JOIN Playlist pl
ON pt.PlaylistId = pl.PlaylistId
WHERE pl.Name = "Music";

-- -- -- NESTING QUERIES -- -- --
-- 1 --
SELECT *
FROM Invoice
WHERE InvoiceId 
IN (
  SELECT InvoiceId 
  FROM InvoiceLine 
  WHERE UnitPrice > .99
);

-- 2 --
SELECT TrackId
FROM PlaylistTrack
WHERE PlaylistId
IN (
  SELECT PLaylistId
  FROM Playlist
  WHERE Name = "Music"
);

-- 3 --
SELECT Name FROM Track
WHERE TrackId
IN (
  SELECT TrackId FROM PlaylistTrack
  WHERE PlaylistId = 5
);

-- 4 --
SELECT Name FROM Track
WHERE GenreId
IN (
  SELECT GenreId FROM Genre
  WHERE Name = 'Comedy'
);

-- 5 --
SELECT Name FROM Track
WHERE AlbumId
IN (
  SELECT AlbumId FROM Album
  WHERE Title = 'Fireball'
);

-- 6 --
SELECT Name FROM Track
WHERE AlbumId
IN (
  SELECT AlbumId FROM Album
  WHERE ArtistId
  IN (
    SELECT ArtistId FROM Artist
    WHERE Name = "Queen"
  )
);

-- -- -- UPDATING ROWS -- -- --
-- 1 --
UPDATE Customer
SET Fax = NULL
WHERE Fax IS NOT NULL;

-- 2 --
UPDATE Customer
SET Company = 'Self'
WHERE Company IS NULL;

-- 3 --
UPDATE Customer
SET LastName = 'Thompson'
WHERE FirstName = 'Julia' AND LastName = 'Barnett';

-- 4 --
UPDATE Customer
SET SupportRepId = 4
WHERE Email = 'luisrojas@yahoo.cl';

-- 5 --
UPDATE Track
SET Composer = 'The darkness around us'
WHERE Composer IS NULL AND GenreId IN (SELECT GenreId FROM Genre WHERE Name = 'Metal');

-- -- -- GROUP BY -- -- --
-- 1 --
SELECT gn.Name, COUNT(tr.TrackId)
FROM Track tr
JOIN Genre gn 
ON gn.GenreId = tr.GenreId
GROUP BY gn.Name;

-- 2 --
SELECT gn.Name, COUNT(tr.TrackId)
FROM Track tr
JOIN Genre gn 
ON gn.GenreId = tr.GenreId
WHERE gn.Name in ("Pop", "Rock")
GROUP BY gn.Name;

-- 3 --
SELECT ar.Name, COUNT(al.ArtistId) 
FROM Artist ar
JOIN Album al
ON al.ArtistId = ar.ArtistId
GROUP BY ar.ArtistId;

-- -- -- DISTINCT -- -- --
-- 1 --
SELECT DISTINCT Composer FROM Track;

-- 2 --
SELECT DISTINCT BillingPostalCode FROM Invoice;

-- 3 --
SELECT DISTINCT Company FROM Customer;

-- -- -- DELETE -- -- --
-- 1 --
DELETE FROM practice_delete WHERE Type = 'bronze';

-- 2 --
DELETE FROM practice_delete WHERE Type = 'silver';

-- 3 --
DELETE FROM practice_delete WHERE Value = 150;

-- -- -- eCommerce Simulation -- -- --
CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, email TEXT);
CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT, price INTEGER);
CREATE TABLE orders (id INTEGER PRIMARY KEY, orderId INTEGER, productId INTEGER);

INSERT INTO users (name, email) VALUES
('Chris','wut@yes.no'),
('James','beard@long.really'),
('Noah','bird@are.light');

INSERT INTO products (name, price) VALUES
('Plunger',5),
('Desk',100),
('Computer',200);

INSERT INTO orders (orderId, productId) VALUES
(1,1),
(1,2),
(1,3),
(2,1),
(2,2),
(3,2),
(3,3);

-- Get all products in the first order --
SELECT * FROM products
WHERE id IN (SELECT productId FROM orders WHERE orderId = 1);

-- Get all ordors --
SELECT * FROM orders;

-- Get total cost of an order --
SELECT SUM(price) FROM products
WHERE id IN (SELECT productId FROM orders WHERE orderId = 1);

-- Add foreign key reference from orders to users --
ALTER TABLE orders
ADD COLUMN userId INTEGER REFERENCES users (id);

-- Update the orders table to link a user to each order --
UPDATE orders SET userId = 1 WHERE orderId = 1;
UPDATE orders SET userId = 2 WHERE orderId = 3;
UPDATE orders SET userId = 3 WHERE orderId = 2;

-- Get all orders for a user --
SELECT u.name, p.name, p.price
FROM users u
JOIN orders o
ON u.id = o.userId
JOIN products p
ON p.id = o.productId
WHERE u.id = 1;

-- Get how many orders each user has --
SELECT u.name, COUNT(*)
FROM users u
JOIN orders o
ON u.id = o.userId
JOIN products p
ON p.id = o.productId
GROUP BY u.name;

-- Black Diamond --
SELECT u.name, SUM(p.price)
FROM users u
JOIN orders o
ON u.id = o.userId
JOIN products p
ON p.id = o.productId
GROUP BY u.name;