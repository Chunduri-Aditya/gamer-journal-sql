-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE
);
-- The users table stores user information with unique constraints on username and email

CREATE TABLE games (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    genre TEXT NOT NULL,
    platform TEXT NOT NULL,
    developer TEXT,
    release_year INTEGER CHECK (release_year > 1950)
);
-- The games table stores information about games, including title, genre, platform, developer, and release year with a check constraint

CREATE TABLE friends (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    nickname TEXT,
    platform TEXT
);
-- The friends table stores information about friends, including name, nickname, and platform

CREATE TABLE sessions(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    game_id INTEGER NOT NULL,
    date_played DATE NOT NULL,
    duration_minutes INTEGER CHECK (duration_minutes > 0),
    mood TEXT CHECK (mood IN ('happy', 'neutral', 'sad')),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES games(id)
);
-- The sessions table records gaming sessions with user and game references, date played, duration, and mood

CREATE TABLE reviews(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    game_id INTEGER NOT NULL,
    rating INTEGER CHECK (rating BETWEEN 1 AND 10),
    thoughts TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES games(id)
);
-- The reviews table stores user reviews for games, including rating and thoughts

CREATE TABLE session_friends (
    session_id INTEGER NOT NULL,
    friend_id INTEGER NOT NULL,
    PRIMARY KEY (session_id, friend_id),
    FOREIGN KEY (session_id) REFERENCES sessions(id),
    FOREIGN KEY (friend_id) REFERENCES friends(id)
);
-- The session_friends table links sessions to friends, allowing multiple friends to be associated with a single session

-- Create indexes to optimize common queries
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_games_title ON games(title);
CREATE INDEX idx_sessions_user_id ON sessions(user_id);
CREATE INDEX idx_reviews_game_id ON reviews(game_id);
CREATE INDEX idx_session_friends_session_id ON session_friends(session_id);
CREATE INDEX idx_session_friends_friend_id ON session_friends(friend_id);
-- The indexes improve performance for queries filtering by username, game title, user ID in sessions, game ID in reviews, and session-friend relationships
-- The schema.sql file defines the structure of the database, including tables, constraints, and indexes
