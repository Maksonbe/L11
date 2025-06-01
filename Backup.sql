--
-- Файл сгенерирован с помощью SQLiteStudio v3.4.17 в Вс июн 1 12:12:15 2025
--
-- Использованная кодировка текста: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Таблица: achievements
CREATE TABLE IF NOT EXISTS achievements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    points_required INTEGER DEFAULT 0
);
INSERT INTO achievements (id, title, description, points_required) VALUES (1, 'Первый шаг', 'Посетил первую достопримечательность', 1);
INSERT INTO achievements (id, title, description, points_required) VALUES (2, 'Путешественник', 'Посетил 5 достопримечательностей', 5);
INSERT INTO achievements (id, title, description, points_required) VALUES (3, 'Эксперт', 'Посетил 20 достопримечательностей', 20);

-- Таблица: location_tags
CREATE TABLE IF NOT EXISTS location_tags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);
INSERT INTO location_tags (id, name) VALUES (1, 'музей');
INSERT INTO location_tags (id, name) VALUES (2, 'памятник');
INSERT INTO location_tags (id, name) VALUES (3, 'парк');
INSERT INTO location_tags (id, name) VALUES (4, 'церковь');
INSERT INTO location_tags (id, name) VALUES (5, 'ресторан');

-- Таблица: location_to_tag
CREATE TABLE IF NOT EXISTS location_to_tag (
    location_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (location_id, tag_id),
    FOREIGN KEY (location_id) REFERENCES locations(id),
    FOREIGN KEY (tag_id) REFERENCES location_tags(id)
);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (1, 1);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (2, 2);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (3, 3);

-- Таблица: locations
CREATE TABLE IF NOT EXISTS locations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    latitude REAL,
    longitude REAL
);
INSERT INTO locations (id, name, description, latitude, longitude) VALUES (1, 'Эрмитаж', 'Крупнейший художественный музей России', 59.9398, 30.3146);
INSERT INTO locations (id, name, description, latitude, longitude) VALUES (2, 'Петропавловская крепость', 'Историческое ядро Санкт-Петербурга', 59.95, 30.3167);
INSERT INTO locations (id, name, description, latitude, longitude) VALUES (3, 'Летний сад', 'Старейший парк Санкт-Петербурга', 59.9456, 30.337);

-- Таблица: notification_frequencies
CREATE TABLE IF NOT EXISTS notification_frequencies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    frequency TEXT NOT NULL CHECK(frequency IN ('daily', 'weekly', 'monthly', 'never'))
);
INSERT INTO notification_frequencies (id, frequency) VALUES (1, 'daily');
INSERT INTO notification_frequencies (id, frequency) VALUES (2, 'weekly');
INSERT INTO notification_frequencies (id, frequency) VALUES (3, 'monthly');
INSERT INTO notification_frequencies (id, frequency) VALUES (4, 'never');

-- Таблица: roles
CREATE TABLE IF NOT EXISTS roles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);
INSERT INTO roles (id, name) VALUES (1, 'user');
INSERT INTO roles (id, name) VALUES (2, 'moderator');
INSERT INTO roles (id, name) VALUES (3, 'admin');

-- Таблица: user_achievements
CREATE TABLE IF NOT EXISTS user_achievements (
    user_id INTEGER NOT NULL,
    achievement_id INTEGER NOT NULL,
    achieved_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, achievement_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (achievement_id) REFERENCES achievements(id)
);
INSERT INTO user_achievements (user_id, achievement_id, achieved_at) VALUES (1, 1, '2025-06-01 09:10:17');
INSERT INTO user_achievements (user_id, achievement_id, achieved_at) VALUES (2, 1, '2025-06-01 09:10:17');
INSERT INTO user_achievements (user_id, achievement_id, achieved_at) VALUES (2, 2, '2025-06-01 09:10:17');

-- Таблица: users
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    telegram_id INTEGER UNIQUE NOT NULL,
    username TEXT,
    gender TEXT CHECK(gender IN ('male', 'female', 'other')),
    notification_frequency_id INTEGER,
    notification_time TEXT,
    role_id INTEGER NOT NULL,
    password_hash TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (notification_frequency_id) REFERENCES notification_frequencies(id)
);
INSERT INTO users (id, telegram_id, username, gender, notification_frequency_id, notification_time, role_id, password_hash, email) VALUES (1, 123456789, 'ivan_ivanov', 'male', 1, '09:00', 1, 'hashed_password_1', 'ivan@example.com');
INSERT INTO users (id, telegram_id, username, gender, notification_frequency_id, notification_time, role_id, password_hash, email) VALUES (2, 987654321, 'anna_smith', 'female', 2, '18:30', 2, 'hashed_password_2', 'anna@example.com');
INSERT INTO users (id, telegram_id, username, gender, notification_frequency_id, notification_time, role_id, password_hash, email) VALUES (3, 555555555, 'admin_user', 'other', 4, NULL, 3, 'hashed_password_3', 'admin@example.com');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
