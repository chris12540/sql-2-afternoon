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
FROM Playlist pl
JOIN PlaylistTrack pt
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


-- 3 --


-- 4 --


-- 5 --


-- 6 --


