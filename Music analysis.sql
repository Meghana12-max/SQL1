create database music;
use music;

select * from track;
select * from invoice;
select * from invoice1;
select * from employee;
select * from customer;
select * from genre;
select * from artist;
select * from album2;



-- who is senior most employee from job title
SELECT 
    first_name, last_name, title, levels
FROM
    employee
ORDER BY levels DESC
LIMIT 1;

-- which country has the most invoive
SELECT 
    COUNT(*), billing_country
FROM
    invoice1
GROUP BY billing_country
ORDER BY COUNT(*) DESC;

-- what is the top 3 values of total invoice
select * from invoice1 order by total desc limit 3;

--
SELECT 
    ROUND(SUM(total), 2) AS invoice_total, billing_city
FROM
    invoice1
GROUP BY billing_city
ORDER BY invoice_total DESC;

-- 
SELECT 
    c.customer_id, c.first_name, sum(i.total)  as total_Spent
FROM
    customer c
        JOIN
    invoice1 i ON c.customer_id = i.customer_id
GROUP BY c.customer_id,c.first_name    
ORDER BY total_spent DESC
LIMIT 1;

-- 
SELECT 
    c.first_name, c.last_name, c.email
FROM
    customer c 
        JOIN
    invoice1 i ON c.customer_id = i.customer_id
        JOIN
    invoice invoice ON i.invoice_id = invoice.invoice_id
WHERE
    track_id IN (SELECT 
            t.track_id
        FROM
            track t
                JOIN
            genre g ON t.genre_id = g.genre_id
        WHERE
            g.name = 'Rock')
ORDER BY email ASC;

-- 
SELECT 
    a.name, a.artist_id, COUNT(a.artist_id) as artist_count
FROM
    track t
        JOIN
    album2 album ON t.album_id = album.album_id
        JOIN
    artist a ON album.artist_id = album.artist_id
        JOIN
    genre g ON t.genre_id = g.genre_id
WHERE
    g.name = 'Rock'
GROUP BY a.artist_id,a.name
ORDER BY artist_count desc
LIMIT 10;

SELECT 
    a.name, a.artist_id, COUNT(a.artist_id) as artist_count
FROM
    artist a
        JOIN
    album2 album ON a.artist_id= album.artist_id
        JOIN
    track t ON album.album_id = t.album_id
        JOIN
    genre g ON t.genre_id = g.genre_id
WHERE
    g.name = 'Rock'
GROUP BY a.artist_id,a.name
ORDER BY artist_count desc
LIMIT 10;

--
SELECT 
    name, milliseconds
FROM
    track
WHERE
    milliseconds > (SELECT 
            AVG(milliseconds)
        FROM
            track)
ORDER BY milliseconds DESC;
