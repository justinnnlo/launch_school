There are 2 ways to load SQL files into a PostgreSQL database.

# `psql`
We can pipe the SQL file into the `psql` program using redirection from the command line.

```
$ psql -d my_database < file_to_import.sql
```

But if you're in `psql` you can use the `\i` metacommand with the SQL file's location from within the database you want to import the file to:
```sql
my_database=# \i ~/some/files/file_to_import.sql
```
Both commands have the same result.


```sql
SELECT title, extract("year" from current_date) - "year" AS age
  FROM films
  ORDER BY age ASC;
```