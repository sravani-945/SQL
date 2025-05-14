# SQL Task Management System

A simple SQL database project for managing tasks, projects, and users.

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