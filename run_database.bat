@echo off
echo Task Management System - SQLite Database Setup

REM Check if SQLite is installed
where sqlite3 >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo SQLite3 not found! Please install SQLite and add it to your PATH.
    echo Download SQLite from: https://www.sqlite.org/download.html
    pause
    exit /b 1
)

echo Creating database...
if exist taskmanager.db (
    echo Existing database found. Deleting...
    del taskmanager.db
)

echo Initializing database with schema and sample data...
sqlite3 taskmanager.db < init_database.sql

echo Database setup complete.
echo.

:menu
echo ========================================
echo Task Management System - Query Menu
echo ========================================
echo 1. Show all users
echo 2. Show all projects
echo 3. Show all tasks
echo 4. Show tasks by user
echo 5. Show tasks with 'urgent' tag
echo 6. Show overdue tasks
echo 7. Show task completion rate by user
echo 8. Show project progress overview
echo 9. Show comments for Task 1
echo 10. Exit
echo.

set /p choice=Enter your choice (1-10): 

if "%choice%"=="1" (
    echo.
    echo All Users:
    sqlite3 -header -column taskmanager.db "SELECT * FROM Users;"
    echo.
    pause
    goto menu
)

if "%choice%"=="2" (
    echo.
    echo All Projects:
    sqlite3 -header -column taskmanager.db "SELECT * FROM Projects;"
    echo.
    pause
    goto menu
)

if "%choice%"=="3" (
    echo.
    echo All Tasks:
    sqlite3 -header -column taskmanager.db "SELECT * FROM Tasks;"
    echo.
    pause
    goto menu
)

if "%choice%"=="4" (
    echo.
    set /p user_id=Enter user ID: 
    echo.
    echo Tasks for User %user_id%:
    sqlite3 -header -column taskmanager.db "SELECT t.task_id, t.title, t.status, t.priority, t.due_date, p.name AS project_name FROM Tasks t LEFT JOIN Projects p ON t.project_id = p.project_id WHERE t.user_id = %user_id% ORDER BY t.priority DESC, t.due_date ASC;"
    echo.
    pause
    goto menu
)

if "%choice%"=="5" (
    echo.
    echo Tasks with 'urgent' tag:
    sqlite3 -header -column taskmanager.db "SELECT t.task_id, t.title, t.status FROM Tasks t JOIN TaskTags tt ON t.task_id = tt.task_id JOIN Tags tag ON tt.tag_id = tag.tag_id WHERE tag.name = 'urgent' ORDER BY t.due_date ASC;"
    echo.
    pause
    goto menu
)

if "%choice%"=="6" (
    echo.
    echo Overdue Tasks:
    sqlite3 -header -column taskmanager.db "SELECT task_id, title, due_date FROM Tasks WHERE due_date < date('now') AND status != 'completed';"
    echo.
    pause
    goto menu
)

if "%choice%"=="7" (
    echo.
    echo Task Completion Rate by User:
    sqlite3 -header -column taskmanager.db "SELECT u.username, COUNT(t.task_id) AS total_tasks, SUM(CASE WHEN t.status = 'completed' THEN 1 ELSE 0 END) AS completed_tasks, (SUM(CASE WHEN t.status = 'completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(t.task_id)) AS completion_rate FROM Users u JOIN Tasks t ON u.user_id = t.user_id GROUP BY u.user_id, u.username;"
    echo.
    pause
    goto menu
)

if "%choice%"=="8" (
    echo.
    echo Project Progress Overview:
    sqlite3 -header -column taskmanager.db "SELECT p.name AS project_name, COUNT(t.task_id) AS total_tasks, SUM(CASE WHEN t.status = 'completed' THEN 1 ELSE 0 END) AS completed_tasks, SUM(CASE WHEN t.status = 'in_progress' THEN 1 ELSE 0 END) AS in_progress_tasks, SUM(CASE WHEN t.status = 'pending' THEN 1 ELSE 0 END) AS pending_tasks FROM Projects p LEFT JOIN Tasks t ON p.project_id = t.project_id GROUP BY p.project_id, p.name;"
    echo.
    pause
    goto menu
)

if "%choice%"=="9" (
    echo.
    echo Comments for Task 1:
    sqlite3 -header -column taskmanager.db "SELECT c.comment_id, c.content, u.username, c.created_at FROM Comments c JOIN Users u ON c.user_id = u.user_id WHERE c.task_id = 1 ORDER BY c.created_at DESC;"
    echo.
    pause
    goto menu
)

if "%choice%"=="10" (
    echo Exiting...
    exit /b 0
)

echo Invalid choice. Please try again.
pause
goto menu 