# Declarative languages

SQL is a declarative language. SQL syntax declares what output it wants and the language works under the hood to produce the desired result.

This results in high abstraction for the user in how they interact with a database. Thus, this allows users to think at a higher level.

Conversely, this also means that the database may sometimes execute a query inefficiently because the only way it know how long a query will take is by executing it. We can give the database a few hints or requirements for how to execute a query but query and database optimization is beyond the scope of the course.

# Executing a PostgreSQL `SELECT` query

1. Rows are collected into a virtual derived table
  - The database creates a new temporary table using the data from the tables listed in the `FROM` clause and `JOIN` clauses
2. Rows are filtered using `WHERE` conditions
  - Each row is evaluated for the `WHERE` conditions
  - Rows that don't meet the `WHERE` conditions are removed
3. Rows are divided into groups if `GROUP BY` clause is used
4. Groups are filtered using `HAVING` conditions
  - `HAVING` conditions are applied to groups, unlike `WHERE` conditions
5. Compute values to return in the select list of columns
  - Each list element is evaluated and the values are associated with the column names
6. Sort results with `ORDER BY` or in the order of the database execution
7. Limit results with `LIMIT` or `OFFSET`