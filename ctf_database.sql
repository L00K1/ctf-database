-- ctf_database_setup.sql
-- Creates CTF database and inserts sample data

DROP DATABASE IF EXISTS ctf_database;
CREATE DATABASE ctf_database;
USE ctf_database;

-- 1) Teams
CREATE TABLE teams (
  team_id   INT AUTO_INCREMENT PRIMARY KEY,
  team_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2) Players
CREATE TABLE players (
  player_id   INT AUTO_INCREMENT PRIMARY KEY,
  player_name VARCHAR(100) NOT NULL,
  email       VARCHAR(120) NOT NULL UNIQUE
);

-- 3) Team Members (Many-to-Many relationship)
CREATE TABLE team_members (
  team_id   INT NOT NULL,
  player_id INT NOT NULL,
  PRIMARY KEY (team_id, player_id),
  FOREIGN KEY (team_id) REFERENCES teams(team_id) ON DELETE CASCADE,
  FOREIGN KEY (player_id) REFERENCES players(player_id) ON DELETE CASCADE
);

-- 4) Events
CREATE TABLE events (
  event_id   INT AUTO_INCREMENT PRIMARY KEY,
  event_name VARCHAR(120) NOT NULL,
  event_date DATE NOT NULL
);

-- 5) Challenges
CREATE TABLE challenges (
  challenge_id INT AUTO_INCREMENT PRIMARY KEY,
  event_id     INT NOT NULL,
  title        VARCHAR(150) NOT NULL,
  category     VARCHAR(50) NOT NULL,
  points       INT NOT NULL,
  FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE,
  CHECK (points > 0)
);

-- 6) Submissions
CREATE TABLE submissions (
  submission_id INT AUTO_INCREMENT PRIMARY KEY,
  team_id       INT NOT NULL,
  challenge_id  INT NOT NULL,
  submitted_at  DATETIME NOT NULL,
  is_correct    TINYINT(1) NOT NULL,
  score         INT NOT NULL,
  FOREIGN KEY (team_id) REFERENCES teams(team_id) ON DELETE CASCADE,
  FOREIGN KEY (challenge_id) REFERENCES challenges(challenge_id) ON DELETE CASCADE,
  CHECK (is_correct IN (0,1)),
  CHECK (score >= 0)
);

-- -----------------------
-- Example data
-- -----------------------

INSERT INTO teams (team_name) VALUES
('Red Tigers'),
('Blue Owls'),
('Green Hackers');

INSERT INTO players (player_name, email) VALUES
('Alice Nguyen',  'alice@example.com'),
('Bruno Costa',   'bruno@example.com'),
('Chen Li',       'chen@example.com'),
('Dina Karlsen',  'dina@example.com'),
('Emil Johansen', 'emil@example.com'),
('Fatima Ali',    'fatima@example.com');

INSERT INTO team_members (team_id, player_id) VALUES
(1, 1), (1, 2),
(2, 3), (2, 4),
(3, 5), (3, 6);

INSERT INTO events (event_name, event_date) VALUES
('HK-CTF 2025',     '2025-10-20'),
('Winter Mini-CTF', '2025-12-05');

INSERT INTO challenges (event_id, title, category, points) VALUES
(1, 'Warmup Web',  'web',       100),
(1, 'Easy Crypto', 'crypto',    150),
(1, 'Log Sleuth',  'forensics', 200),
(1, 'SQL Basics',  'web',       150),
(1, 'Stego Intro', 'forensics', 150),
(2, 'Mini Web',    'web',       100),
(2, 'Baby Crypto', 'crypto',    100);

INSERT INTO submissions (team_id, challenge_id, submitted_at, is_correct, score) VALUES
(1, 1, '2025-10-20 10:05:00', 1, 100),
(1, 2, '2025-10-20 11:15:00', 0,   0),
(1, 4, '2025-10-20 11:45:00', 1, 150),

(2, 1, '2025-10-20 10:10:00', 1, 100),
(2, 2, '2025-10-20 11:40:00', 1, 150),
(2, 3, '2025-10-20 12:20:00', 0,   0),

(3, 3, '2025-10-20 11:55:00', 1, 200),
(3, 5, '2025-10-20 12:30:00', 1, 150);
