-- Common SQL Queries for Task Management System

-- 1. Get all tasks for a specific user
SELECT t.task_id, t.title, t.status, t.priority, t.due_date, p.name AS project_name
FROM Tasks t
LEFT JOIN Projects p ON t.project_id = p.project_id
WHERE t.user_id = 1
ORDER BY t.priority DESC, t.due_date ASC;

-- 2. Get tasks with specific tag
SELECT t.task_id, t.title, t.status
FROM Tasks t
JOIN TaskTags tt ON t.task_id = tt.task_id
JOIN Tags tag ON tt.tag_id = tag.tag_id
WHERE tag.name = 'urgent'
ORDER BY t.due_date ASC;

-- 3. Get overdue tasks
SELECT task_id, title, due_date
FROM Tasks
WHERE due_date < CURRENT_DATE AND status != 'completed';

-- 4. Task completion rate by user
SELECT u.username, 
       COUNT(t.task_id) AS total_tasks,
       SUM(CASE WHEN t.status = 'completed' THEN 1 ELSE 0 END) AS completed_tasks,
       (SUM(CASE WHEN t.status = 'completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(t.task_id)) AS completion_rate
FROM Users u
JOIN Tasks t ON u.user_id = t.user_id
GROUP BY u.user_id, u.username;

-- 5. Update task status to completed
UPDATE Tasks
SET status = 'completed', completed_at = CURRENT_TIMESTAMP
WHERE task_id = 3;

-- 6. Get all tasks with their associated tags
SELECT t.task_id, t.title, GROUP_CONCAT(tag.name) AS tags
FROM Tasks t
LEFT JOIN TaskTags tt ON t.task_id = tt.task_id
LEFT JOIN Tags tag ON tt.tag_id = tag.tag_id
GROUP BY t.task_id;

-- 7. Get all comments for a specific task
SELECT c.comment_id, c.content, u.username, c.created_at
FROM Comments c
JOIN Users u ON c.user_id = u.user_id
WHERE c.task_id = 1
ORDER BY c.created_at DESC;

-- 8. Get project progress overview
SELECT p.name AS project_name,
       COUNT(t.task_id) AS total_tasks,
       SUM(CASE WHEN t.status = 'completed' THEN 1 ELSE 0 END) AS completed_tasks,
       SUM(CASE WHEN t.status = 'in_progress' THEN 1 ELSE 0 END) AS in_progress_tasks,
       SUM(CASE WHEN t.status = 'pending' THEN 1 ELSE 0 END) AS pending_tasks
FROM Projects p
LEFT JOIN Tasks t ON p.project_id = t.project_id
GROUP BY p.project_id, p.name;

-- 9. Find tasks that have no tags
SELECT t.task_id, t.title
FROM Tasks t
LEFT JOIN TaskTags tt ON t.task_id = tt.task_id
WHERE tt.task_id IS NULL;

-- 10. Delete a completed task and its comments
BEGIN TRANSACTION;
DELETE FROM TaskTags WHERE task_id = 4;
DELETE FROM Comments WHERE task_id = 4;
DELETE FROM Tasks WHERE task_id = 4;
COMMIT; 