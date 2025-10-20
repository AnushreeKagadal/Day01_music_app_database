-- Music App Database Setup
-- creating database
CREATE DATABASE music_app;
USE music_app;

-- Table to store user information
CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    password VARCHAR(100),
    created_at DATETIME,
    PRIMARY KEY (user_id)
) ENGINE=InnoDB;

-- Table to store artists info
CREATE TABLE artists (
    artist_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    genre VARCHAR(50),
    country VARCHAR(50),
    PRIMARY KEY (artist_id)
) ENGINE=InnoDB;

-- Table to store albums info
-- one artist can have many albums so 1-to-Many
CREATE TABLE albums (
    album_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100),
    artist_id INT,
    release_year YEAR,
    PRIMARY KEY (album_id),
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table to store songs info
-- Each song belongs to one artist and one album
CREATE TABLE songs (
    song_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100),
    duration INT, -- in seconds
    artist_id INT,
    album_id INT,
    PRIMARY KEY (song_id),
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (album_id) REFERENCES albums(album_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table to store playlists info
-- Each playlist is created by one user
CREATE TABLE playlists (
    playlist_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    user_id INT,
    created_at DATETIME,
    PRIMARY KEY (playlist_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table to store songs in playlists i.e. Many-to-Many
-- A playlist can contain many songs and a song can be in multiple playlists
CREATE TABLE playlists_songs (
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    PRIMARY KEY (playlist_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;
USE music_app;
show tables;

-- Sample data for checking
-- Artists
INSERT INTO artists (name, genre, country) VALUES
('Harris Jayaraj', 'Film Score', 'India'),  
('Ajaneesh Loknath', 'Film Score', 'India'), 
('Mani Sharma', 'Film Score', 'India'),    
('Ilaiyaraaja', 'Film Score', 'India'),    
('Gopi Sundar', 'Film Score', 'India');     

-- Albums (Movies)
INSERT INTO albums (title, artist_id, release_year) VALUES
('Vaaranam Aayiram', 1, 2008), 
('Ulidavaru Kandante', 4, 2014),   
('Athadu', 3, 2005),           
('Bangalore Days', 5, 2014);    

-- Songs
INSERT INTO songs (title, duration, artist_id, album_id) VALUES
('Mundhinam Parthene', 300, 1, 1), 
('Nenjukkule', 280, 1, 1),          
('Gatiya Ilidu', 250, 4, 2),
('Kaakig Banna', 260, 4, 2),
('Neetho Cheppana', 270, 3, 3),            
('Pilichinaa Raanantaava', 260, 3, 3),     
('Ente Kannil', 230, 5, 4), 
('Edu Kari Ravilum', 240, 5, 4);          

-- Users
INSERT INTO users (name, password, created_at) VALUES
('Anushree', 'pass123', NOW()),
('Aishwarya', 'pass456', NOW()),
('Amulya', 'pass789', NOW());

-- Playlists
INSERT INTO playlists (name, user_id, created_at) VALUES
('Tamil Hits', 1, NOW()),
('Kannada & Telugu', 2, NOW()),
('Malayalam Favorites', 3, NOW());

-- Playlists_Songs (many-to-many)
INSERT INTO playlists_songs (playlist_id, song_id) VALUES
(1, 1), 
(1, 2), 
(2, 3), 
(2, 4), 
(2, 5), 
(2, 6), 
(3, 7),
(3, 8); 
