# CTF Database

This project is a relational database designed for Capture The Flag (CTF) competitions.

It models:
- Teams and players
- Events and challenges
- Submissions and scoring

Built using MySQL with proper normalization and relationships (1NF–3NF).

## Database Structure

The database includes the following tables:

- `teams` – stores team information  
- `players` – stores individual player data  
- `team_members` – links players to teams (many-to-many)  
- `events` – stores CTF events  
- `challenges` – stores challenges per event  
- `submissions` – tracks team submissions and scoring

## How to Run

1. Open MySQL Workbench (or any MySQL client)
2. Run the `ctf_database.sql` file
3. The database and tables will be created automatically

## Example Queries

Get all challenges for an event:
````SQL
SELECT * FROM challenges WHERE event_id = 1;

SELECT team_id, SUM(score) AS total_score
FROM submissions
GROUP BY team_id;
