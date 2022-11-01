CREATE TABLE IF NOT EXISTS music_genre (
	genre_id SERIAL PRIMARY KEY,
	genre_name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS musician (
	musician_id SERIAL PRIMARY KEY,
	musician_name VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS musician_genre (
	musician_id INTEGER REFERENCES musician(musician_id),
	genre_id INTEGER REFERENCES music_genre(genre_id),
	CONSTRAINT pk_mg PRIMARY KEY (musician_id, genre_id)
);

CREATE TABLE IF NOT EXISTS album (
	album_id SERIAL PRIMARY KEY,
	album_name VARCHAR(40) NOT NULL,
	release_year date CHECK(release_year > '1900-01-01') 
);

CREATE TABLE IF NOT EXISTS album_musician (
	musician_id INTEGER REFERENCES musician(musician_id),
	album_id INTEGER REFERENCES album(album_id),
	CONSTRAINT pk_am PRIMARY KEY (musician_id, album_id)
);

CREATE TABLE IF NOT EXISTS track (
	track_id SERIAL PRIMARY KEY,
	track_name VARCHAR(40) NOT NULL,
	duration INTEGER NOT NULL CHECK(duration > 10),
	album_id INTEGER NOT NULL REFERENCES album(album_id)
);

CREATE TABLE IF NOT EXISTS collection (
	collection_id SERIAL PRIMARY KEY,
	collection_name VARCHAR(40) NOT NULL,
	release_year date CHECK(release_year > '1900-01-01')
);

CREATE TABLE IF NOT EXISTS collection_list (
	collection_id INTEGER REFERENCES collection(collection_id),
	track_id INTEGER REFERENCES track(track_id),
	CONSTRAINT pk_cl PRIMARY KEY (collection_id, track_id)
);
