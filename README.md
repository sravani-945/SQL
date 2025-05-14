# SQL Task Management System

A simple SQL database project for managing tasks, projects, and users.

[![Open in GitHub Codespaces](https://img.shields.io/badge/Open%20in-GitHub%20Codespaces-blue?logo=github)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=sravani-945/SQL)
[![Try on SQLite Online](https://img.shields.io/badge/Try%20on-SQLite%20Online-orange?logo=sqlite)](https://sqliteonline.com/)

## Demo

This project can be demoed in multiple ways:

### 1. Try Online with GitHub Codespaces

The easiest way to run this project is using GitHub Codespaces:

1. Click the "Open in GitHub Codespaces" badge above
2. Wait for the environment to load (it looks like VS Code in your browser)
3. Open a terminal and run:
   ```bash
   chmod +x run_database.sh
   ./run_database.sh
   ```
4. Interact with the demo menu to explore different queries

### 2. Try Online with SQLite Online

You can also explore the database using [SQLite Online](https://sqliteonline.com/):

1. Visit [SQLite Online](https://sqliteonline.com/)
2. Copy and paste the contents of `init_database.sql` into the editor
3. Click "Run" to create and populate the database
4. Try running queries from `queries.sql` to explore the data

## Project Structure

- `schema.sql`: Database schema definition with tables for users, projects, tasks, tags, and comments
- `sample_data.sql`: Sample data to populate the database
- `queries.sql`: Example SQL queries to interact with the database
- `init_database.sql`: Combined script to create tables and populate with sample data
- `run_database.bat`: Windows batch script to initialize and run SQL queries on the database
- `run_database.sh`: Linux/Mac shell script to initialize and run SQL queries on the database

## Database Schema

The database consists of the following tables:

- **Users**: Stores user information
- **Projects**: Groups related tasks together
- **Tasks**: Contains individual tasks with status, priority, and due dates
- **Tags**: Categorizes tasks
- **TaskTags**: Junction table for the many-to-many relationship between tasks and tags
- **Comments**: Stores comments on tasks

![Database Schema](https://mermaid.ink/img/pako:eNqNksFqwzAMhl_F-JQVkrRNCg3JodDB2I7bYbeQg5pqDUtiY8tjo-Tdp9RptwyWXWzhn_8PIclDJJQhimpqNNw5Jc2OZnYsmgOZyvyR7Ygb0xY3YXS_PnqQ9eWieMxvixNPL6A6g9LU1tLe8BuUbnLjHFQtEQWnxLdaGH4FWcMGDFI-KD8uVr5s1NQ54tHXRQnnQ_zFEI9TH5XWktcnP5VQxYxdSOTAG9uBw8DWCBmDNL54R5jzvDc5pOlGdkI6YNFEYyH9U10BuoNWJUwTUfUWGnRCMhFJv4TTXP35xnlq0eLbVXkQ9T8TGsaLGaU8qB4_eYT5BxsbtVA)

## How to Use

### Quick Start

#### Windows
Simply run the provided batch script:
```
run_database.bat
```

#### Linux/Mac
Make the script executable and run it:
```
chmod +x run_database.sh
./run_database.sh
```

The scripts will:
1. Check if SQLite is installed
2. Initialize the database with the schema and sample data
3. Provide a menu to run various queries on the database

### Manual Setup

If you prefer to set up and run the database manually:

1. Create a new database in your preferred SQL database system (SQLite, MySQL, PostgreSQL)
2. Run the `schema.sql` script to create tables
3. Run the `sample_data.sql` script to populate with sample data

For SQLite:
```bash
sqlite3 taskmanager.db < schema.sql
sqlite3 taskmanager.db < sample_data.sql
```

For MySQL:
```bash
mysql -u username -p database_name < schema.sql
mysql -u username -p database_name < sample_data.sql
```

For PostgreSQL:
```bash
psql -U username -d database_name -a -f schema.sql
psql -U username -d database_name -a -f sample_data.sql
```

### Running Queries

The `queries.sql` file contains example queries for common operations:

1. Getting tasks for a specific user
2. Finding tasks with specific tags
3. Finding overdue tasks
4. Calculating task completion rates
5. Updating task status
6. Finding tasks with associated tags
7. Getting comments for a task
8. Calculating project progress
9. Finding tasks without tags
10. Deleting tasks with related records

You can run these queries individually or modify them as needed for your use case.

## Example Query Results

Here are some example results from running the queries:

### Tasks for User 1
```
task_id  title                  status       priority  due_date    project_name
-------  ---------------------  -----------  --------  ----------  -------------
3        Prepare presentation   in_progress  3         2023-12-08  Work Tasks
2        Buy paint supplies     pending      1         2023-12-10  Home Renovation
```

### Tasks with 'urgent' tag
```
task_id  title                status
-------  -------------------  -----------
3        Prepare presentation in_progress
```

### Project Progress Overview
```
project_name      total_tasks  completed_tasks  in_progress_tasks  pending_tasks
---------------   -----------  ---------------  -----------------  -------------
Work Tasks        1            0                1                  0
Home Renovation   1            0                0                  1
Learning SQL      2            0                1                  1
Vacation Planning 1            1                0                  0
```

## Extending the Project

Some ideas for extending this project:

- Add more complex queries for reporting
- Create views for common queries
- Add triggers for task status changes
- Implement stored procedures for common operations
- Add indexes for performance optimization
- Create a simple front-end interface using HTML/CSS/JavaScript
- Implement a REST API to access the data

## Requirements

- SQLite 3 (for running the included scripts)
- For other database systems: MySQL or PostgreSQL installed

## License

This project is available under the MIT License. 