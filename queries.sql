-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database


-- INSERT Queries


-- Add users
INSERT INTO users (username, email) VALUES ('aditya', 'aditya@example.com');
INSERT INTO users (username, email) VALUES ('gamer_1', 'g1@example.com');
INSERT INTO users (username, email) VALUES ('gamer_2', 'g2@example.com');

-- Add games
INSERT INTO games (title, genre, platform, developer, release_year)
VALUES ('Elden Ring', 'Action RPG', 'PS5', 'FromSoftware', 2022);

INSERT INTO games (title, genre, platform, developer, release_year)
VALUES ('Ghost of Tsushima', 'Action-Adventure', 'PS4', 'Sucker Punch', 2020);

-- Add friends
INSERT INTO friends (name, nickname, platform) VALUES ('friend_1', 'Blade', 'Steam');
INSERT INTO friends (name, nickname, platform) VALUES ('friend_2', 'Ghost', 'PlayStation');

-- Add sessions (aditya = user_id 1, gamer_1 = 2, gamer_2 = 3)
INSERT INTO sessions (user_id, game_id, date_played, duration_minutes, mood)
VALUES (1, 1, '2025-07-16', 120, 'happy');  -- Aditya played Elden Ring

INSERT INTO sessions (user_id, game_id, date_played, duration_minutes, mood)
VALUES (2, 2, '2025-07-17', 90, 'neutral');  -- Gamer_1 played Ghost of Tsushima

-- Link friends to sessions
INSERT INTO session_friends (session_id, friend_id) VALUES (1, 1);  -- friend_1 joined Aditya
INSERT INTO session_friends (session_id, friend_id) VALUES (2, 2);  -- friend_2 joined gamer_1

-- Add reviews
INSERT INTO reviews (user_id, game_id, rating, thoughts)
VALUES (1, 1, 9, 'Deep combat and incredible exploration.');  -- Aditya on Elden Ring

INSERT INTO reviews (user_id, game_id, rating, thoughts)
VALUES (2, 2, 8, 'Gorgeous world and smooth swordplay.');  -- gamer_1 on Ghost of Tsushima




-- SELECT Queries


-- View all users
SELECT * FROM users;

-- View all games
SELECT * FROM games;

-- View all friends
SELECT * FROM friends;

-- Get all sessions by aditya
SELECT s.*
FROM sessions s
JOIN users u ON s.user_id = u.id
WHERE u.username = 'aditya';

-- Get all sessions for the game 'Elden Ring'
SELECT s.*
FROM sessions s
JOIN games g ON s.game_id = g.id
WHERE g.title = 'Elden Ring';

-- Get all friends in session 1
SELECT f.name, f.nickname
FROM session_friends sf
JOIN friends f ON sf.friend_id = f.id
WHERE sf.session_id = 1;

-- Get all reviews for 'Ghost of Tsushima'
SELECT r.rating, r.thoughts, u.username
FROM reviews r
JOIN users u ON r.user_id = u.id
JOIN games g ON r.game_id = g.id
WHERE g.title = 'Ghost of Tsushima';

-- Get all sessions with mood 'happy'
SELECT s.*
FROM sessions s
WHERE s.mood = 'happy';

-- Get all games released after 2015
SELECT *
FROM games
WHERE release_year > 2015;

-- Get average rating per game
SELECT g.title, ROUND(AVG(r.rating), 2) AS average_rating
FROM reviews r
JOIN games g ON r.game_id = g.id
GROUP BY g.id
ORDER BY average_rating DESC;


-- UPDATE Queries


-- Update Aditya’s email
UPDATE users
SET email = 'Aditya123@gmail.com'
WHERE username = 'aditya';


-- Update Aditya’s mood in session 1
UPDATE sessions
SET mood = 'neutral'
WHERE id = 1;

-- Update friend_1’s platform
UPDATE friends
SET platform = 'Discord'
WHERE name = 'friend_1';

-- Update the genre of Elden Ring
UPDATE games
SET genre = 'Open World RPG'
WHERE title = 'Elden Ring';


-- DELETE Queries


-- Delete session 1
DELETE FROM sessions
WHERE id = 1;

-- Delete Aditya’s review for Elden Ring
DELETE FROM reviews
WHERE user_id = 1 AND game_id = 1;

-- Delete friend_2 from the friends list
DELETE FROM friends
WHERE name = 'friend_2';

-- Delete all sessions for gamer_2
DELETE FROM sessions
WHERE user_id = 3;

