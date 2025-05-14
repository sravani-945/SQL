-- Sample data for Task Management System

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