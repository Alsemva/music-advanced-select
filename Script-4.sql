--1--

SELECT genre_name, COUNT(musician_id) FROM musician_genre mg
JOIN music_genre mg2 ON mg.genre_id = mg2.genre_id
GROUP BY genre_name
ORDER BY COUNT(musician_id) DESC;

--2--

SELECT COUNT(track_name)  FROM album a 
JOIN track t ON a.album_id = t.album_id
WHERE release_year BETWEEN '2019-01-01' AND '2020-12-31';

--3--

SELECT album_name, AVG(duration) FROM album a 
JOIN track t ON a.album_id = t.album_id
GROUP BY album_name;

--4--

SELECT DISTINCT musician_name FROM musician
WHERE musician_name != (
	SELECT musician.musician_name FROM musician 
	JOIN album_musician  ON musician.musician_id = album_musician.musician_id
	JOIN album ON album_musician.album_id = album.album_id 
	WHERE release_year BETWEEN '2020-01-01' AND '2020-12-31');

--5--

SELECT DISTINCT collection_name FROM collection c 
JOIN collection_list cl ON c.collection_id = cl.collection_id 
JOIN track t ON cl.track_id = t.track_id 
JOIN album a ON t.album_id = a.album_id 
JOIN album_musician am ON a.album_id = am.album_id 
JOIN musician m ON am.musician_id = m.musician_id 
WHERE musician_name = 'Nightwish';

--6--

SELECT album_name FROM album a 
JOIN album_musician am ON a.album_id = am.album_id 
JOIN musician_genre mg ON am.musician_id = mg.musician_id
GROUP BY album_name
HAVING COUNT(genre_id) > 1;

--7--

SELECT track_name FROM track t 
LEFT JOIN collection_list cl ON t.track_id = cl.track_id 
WHERE collection_id IS NULL;

--8-- 

SELECT musician_name FROM musician m 
JOIN album_musician am ON m.musician_id = am.musician_id 
JOIN album a ON am.album_id = a.album_id 
JOIN track t ON a.album_id = t.album_id 
WHERE duration = (SELECT MIN(duration) FROM track);

--9--

SELECT album1.album_name, album1.track_count  FROM (
	SELECT album.album_name, COUNT(track.track_name) AS track_count FROM album
	JOIN track ON album.album_id = track.album_id
	GROUP BY album.album_name
) album1
WHERE album1.track_count = (
	SELECT MIN(album2.subtrack_count) FROM (
			SELECT a.album_name, COUNT(t.track_name) AS subtrack_count FROM album a 
			JOIN track t ON a.album_id = t.album_id
			GROUP BY a.album_name
		)album2
	);
