-- SQLite initialization script
-- Run with: sqlite3 taskmanager.db < init_database.sql

-- Enable foreign key constraints
PRAGMA foreign_keys = ON;

-- Drop tables if they exist
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS TaskTags;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Tasks;
DROP TABLE IF EXISTS Projects;
DROP TABLE IF EXISTS Users;

-- Create tables
-- Users table to store user information
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Projects table to organize tasks
CREATE TABLE Projects (
    project_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Tasks table to store individual tasks
CREATE TABLE Tasks (
    task_id INTEGER PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'pending',
    priority INTEGER DEFAULT 1,
    due_date DATE,
    project_id INTEGER,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Tags table for categorizing tasks
CREATE TABLE Tags (
    tag_id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Junction table for task-tag many-to-many relationship
CREATE TABLE TaskTags (
    task_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (task_id, tag_id),
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id),
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
);

-- Comments on tasks
CREATE TABLE Comments (
    comment_id INTEGER PRIMARY KEY,
    content TEXT NOT NULL,
    task_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert sample data
-- Insert sample users
INSERT INTO Users (username, email, password) VALUES
('john_doe', 'john.doe@example.com', 'hashed_password_1'),
('jane_smith', 'jane.smith@example.com', 'hashed_password_2'),
('bob_johnson', 'bob.johnson@example.com', 'hashed_password_3');

-- Insert sample projects
INSERT INTO Projects (name, description, user_id) VALUES
('Work Tasks', 'All work-related tasks and deadlines', 1),
('Home Renovation', 'Tasks for home renovation project', 1),
('Learning SQL', 'Tasks related to learning SQL programming', 2),
('Vacation Planning', 'Planning the summer vacation', 3);

-- Insert sample tasks
INSERT INTO Tasks (title, description, status, priority, due_date, project_id, user_id) VALUES
('Complete SQL project', 'Finish the database schema and queries', 'in_progress', 2, '2023-12-15', 3, 2),
('Buy paint supplies', 'Get paint, brushes, and rollers from hardware store', 'pending', 1, '2023-12-10', 2, 1),
('Prepare presentation', 'Create slides for the client meeting', 'in_progress', 3, '2023-12-08', 1, 1),
('Book flights', 'Search and book flights for vacation', 'completed', 2, '2023-11-30', 4, 3),
('Install database', 'Set up the SQL database server', 'pending', 2, '2023-12-20', 3, 2);

-- Insert sample tags
INSERT INTO Tags (name) VALUES
('urgent'),
('work'),
('personal'),
('learning'),
('travel');

-- Link tasks with tags
INSERT INTO TaskTags (task_id, tag_id) VALUES
(1, 4), -- Complete SQL project - learning
(2, 3), -- Buy paint supplies - personal
(3, 2), -- Prepare presentation - work
(3, 1), -- Prepare presentation - urgent
(4, 5), -- Book flights - travel
(5, 4); -- Install database - learning

-- Insert sample comments
INSERT INTO Comments (content, task_id, user_id) VALUES
('I found a good tutorial on this topic', 1, 2),
('Don''t forget to get eco-friendly paint', 2, 3),
('The client requested to include budget slides', 3, 1),
('Check for deals on Tuesdays', 4, 2),
('We should use PostgreSQL for this project', 5, 1);

-- Verify data was inserted correctly
SELECT 'Users: ' || COUNT(*) FROM Users;
SELECT 'Projects: ' || COUNT(*) FROM Projects;
SELECT 'Tasks: ' || COUNT(*) FROM Tasks;
SELECT 'Tags: ' || COUNT(*) FROM Tags;
SELECT 'TaskTags: ' || COUNT(*) FROM TaskTags;
SELECT 'Comments: ' || COUNT(*) FROM Comments; 