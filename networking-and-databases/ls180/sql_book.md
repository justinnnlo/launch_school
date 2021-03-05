# Introduction

## Structured data

Structured data aims to solve the problems of unstructured data. Unstructured data is data without any structure: the content of an email, the handwriting in a notebook, a book or an image.

If the content is large unstructured data becomes a problem: how do you find an annotation in a book?, an image in a photobook?

One way to store data is in a tabular format: in rows and columns as in spreadsheets or lists. This helps us manage and find information in it it more easily. Data stored tabularly can then be sorted or ordered in different ways

A common way of storing structured data is to store it in a relational database. A relational database is **a structred set of data held in a computer**.

## Spreadsheets as a database

We can think of spreadsheets as an instance of a database. Data is stored tabularly in individual worksheets. A single worksheet is a unique table in a database. The database itself is a collection of sheets.

A table in a database is a list of individual but related data antries which store values for a set of defined and shared attributes. The rows in a table store separate but related data. The columns specify a standerdized way to store data for a specific attribute.

## Relational database management systems

A relational database is a database (i.e., a collection of data stored in a computer) organized in a relational model of data. The relational model of data defines **a set of relations and describes the relationships between them**. These relationshops between data is how the data stored in the database can interact.

Relational databases can thus:
- Describe data in a more nuanced way
- Cut down on duplicated data

A relational database management system (RDBMS) is a software system to manage relational databases. They allow a user or app to interact with the database by issuing commands with a syntax that conforms to a standard.

RDBMS include: MySQL, SQLite, MS SQL, PostgreSQL. Though each of these systems makes their own tradeoffs, they all use the SQL language.

### NoSQL

"NoSQL" is the term used for structured data models that do not use the relational model. The term uses SQL in its name because that's the most used language to work with relational databases. A NoSQL database software is MongoDB, which uses a document-oriented data storage model.

## SQL

Structured Query Language (SQL) is a programming language used to communicate with a relational database.

SQL allows us to conveniently:
- Select (find)
- Insert (add)
- Update (change)
- Delete (remove)
with a large amount of data with simple English sentences.

A particularity of SQL is that it's a **declarative languge**: you declare what you want — not how you want it to be done, which are handled internally by the RDBMS.

SQL dates to a paper from the 70s by E.F. Codd called "A relational model for large data banks", which set the theoretical foundation.

### Why learn SQL

Relational databases are widespread to manage data. For example, even browsers like Firefox use SQLite to track a user's history and data. Similarly, a Ruby on Rail program typically generates SQL behind the scenes.

## Vocabulary

|Term|Definition|
|-|-|
|Database|Structured data stored in a computer|
|Relational database|A databased organized with a relational data model|
|Relational data|Individual but related data entries|
|RDBMS|A system (software) to manage a relational database|
|SQL|A declarative language to interact with relational databases|
|SQL statement|A SQL command to use the database or data within the database|
|SQL query|A way to search or lookup data in a database, A subset of the SQL statement, as it doesn't update, delete, or insert data.|

# Interacting with a database

A RDBMS like PostgreSQL has many potential interfaces or clients:
- A programming language
- A GUI app
- CLI

But all of these interfaces share the underlying architecture that interacts with the database: they issue a request (declaration) and receive a response. These interfaces are different abstractions within the same model. For example, a GUI abstracts SQL syntax visually but it's still happening underneath.

This is called the "client-server" architecture (like the one used by networking devices). PostgreSQL is a "client-server" database, and this architecture is used by most relational databases.

## PostgreSQL Client apps

PostgreSQL comes packaged with "client applications". These client apps interact with PostgreSQL through commands issued by the command line. PostgreSQL client apps include:
- `createdb`: creates a new PostgreSQL database
  - This is essentially a wrapper around the SQL command `CREATE DATABASE`
- `dropdb`
- `pg_dump`
- `pg_restore`
- `pg_bench`

`psql` is another client app. It's a PostgreSQL interactive console — a terminal based front-end to PostgreSQL, much like a REP. It allows us to:
- Write queries in SQL syntax
- Issue those queries to a SQL database
- See the query results in ther terminal

Note that client apps are called from the terminal, not from `psql`.

## `psql` console

There are 2 types of commands that we can issue from the `psql` terminal:
- `psql` console meta-commands
- SQL statements using SQL syntax

### Meta-commands

A psql console meta-command is a backslash `\` followed by a command and optional arguments. For example, `\conninfo` and `\q` (which quits the psql console).

Meta-commands are used for things like:
- Connecting to a different database
- Listing tables
- Describing the strucutre of a table
- Setting environmental variables

Thus, it's for things that aren't a SQL statement (select, insert, update, delete).

|Meta-command|Description|Example|
|-|-|-|
|`\c $dbname`|**C**onnect to `$dbname`|`\c animals`|
|`\d`|**D**escribe available relations/tables||
|`\d $dbname`|**D**escribe `$dbname` relation|`\d animals`|
|`\?`|List of console commands and options||
|`\h`|List of SQL syntax **h**elp topics||
|`\h $topic`|SQL syntax **h**elp on `$topic`||
|`\q`|**Q**uit||

### SQL statements
A SQL statement is a command issues to the relational database using SQL syntax. For example, a statement could be:

```
postgres=# SELECT name FROM people WHERE id = 1;
```

Note that SQL statements end in a semicolon — so we could rewrite the above as:

```
postgres=# SELECT name
FROM people
WHERE id = 1;
```
because the SQL statement will only execute when the `;` is reached.

`SELECT` statements retrieve datase from the database. The response will look like:
```
  name
---------
 Michael
(1 row)
```

## SQL sub-languages
SQL manipulates with specific parts of the database in 3 different sub-languages:
- Data Definition Language (DDL): defines the structure of the database, and its tables and columns
- Data Manipulation Language: retrieves or modifies data in a database (e.g. `SELECT`)
- Data Control Language: determines what users are allowed to do when interacting with the database

# SQL Basics

## Create a database

1. The client app `createdb $NAME` creates a database
2. Create a file of `$NAME.sql` extension with SQL code
3. To create the database using the `$NAME.sql` table, execute `psql -d ls_burger < ls_burger.sql`
4. Connect to the database with `psql -d $NAME`

## Selecting data

### Selecting all data
We can select all the data with `SELECT * FROM $TABLE_NAME`.
- `SELECT`: a select SQL statement
- `*`: a wild card character that identifies all of the columns in a given table
- `FROM`: an SQL keyword to identify the table from which to retrieve the data
- `$TABLE_NAME`: the name of the table from which data is retrieved

### Selecting by column
But we can make more tailored SQL queries by using comma-separated columns like: `SELECT $col1, $col2, $col3 FROM $TABLE_NAME`. Note that the data would, in all cases, have the same order with these queries.

### Selecting by row

If we have unique identifier such as an `id` column we can use the `WHERE` clause to a `SELECT` statement to retrieve specific rows. For example, `SELECT * FROM $TABLE_NAME WHERE id = 1;` selects all columns of the row with id 1 from the table `$TABLE_NAME`.

`WHERE $CONDITION` creates a conditional that is checked in each table row: if the condition is met that row is returned by the `SELECT` query. For example, `id = 1` could be a `WHERE` condition.

Note that in SQL:
- `=` is used as an equality operator rather than for assignment, as in most programming languages
- Strings should be surrounded by single quotes `'`

## Data vs Schema
Data is concerned with the contetns of a database, like the values associated with rows and columns in a database table.

Schema is concerned with the structure of a database, like the names of rows and tables, the column data types, and database constraints. **Without the schema we'd have unstructured data**.

# Schema (structure)

## Create and view databases

- We can create a database with `psql $NAME`
- We can connect to the database with `psql -d $NAME`, where `$NAME` is the databases' name

Note that within a `psql` console we can list all of the databases with the meta-command `\list`.

Alternatively, within `psql` we can create a database with a SQL statement: `CREATE DATABASE $NAME`. When doing so, we're passing `$NAME` as a single parameter. However, `CREATE DATABASE` has multiple optional parameters that cover database encoding, collation, collection limit and more (PostgreSQL uses the default options unless otherwise indicated).

Regarding conventions, note that:
- SQL statements are typically written in all caps
- Database names are typically written in downcase
  - The name itself should be **self-descriptive**
- SQL is not case-sensitive, so we could write it in any caps

### Connecting to databases
We need to be connected to a database to issue commands.

- Command line: we can connect with `psql` using `psql -d $NAME`
- `psql`: we can connect to a different database with `\c` or `\connect` meta-commands

Note that as with `CREATE DATABASE`, the `\c` and `\connect` meta-commands can take more than one argument. When only the database name is passed it reuses the arguments of the previous connection. However, in a local connection these can generally be ommitted.

### Deleting databases

- `psql`: SQL statement `DROP DATABASE`
  - You can't delete the database you're currently connected to
- Command line: `dropdb $NAME` using the `dropdb` client app.

Note that database deletion is permanent and cannot be reversed: all data and scheme are deleted.

## Create and view tables

- Database tables are sometimes called relations
- Tables represent abstractions, such as of a customer or an order
- The relationship between tables provides the structure to house our data

### Table creation syntax

A table is created with the SQL statement `CREATE TABLE $NAME();`

When we create a column, it's name and data type are obligatory but the constraints are optional. For example, a table creation can look like:

```sql
CREATE TABLE users (
  id serial UNIQUE NOT NULL,
  username char(25),
  enabled boolean DEFAULT TRUE
);
```
Where:
- SQL command: `CREATE TABLE`
- The information within `()` is related to the table columns
- Table name: `users`
- Column names: `id`, `username` and `enabled`
- Data types: `serial`, `char(25)`, and `boolean`
- Constraints: `UNIQUE`, `NOT NULL`
- Column default value: `DEFAULT TRUE`
- Commas (`,`): used to separate columns (except the last)

### Data types
A column data types determines what values are allowed in the column. This protects the data against invalid data types.

|Column data type|Description|
|-|-|
|serial|Auto-incrementing integers to create identifier columns|
|char(N)|Strings of up to N characters; if less than N the remaining space is filled with space characters|
|varchar(N)|Strings of up to N characters; if less than N the remaining space is not used|
|boolean|`true` (`t`) or `false` (`f`), though be wary of `NULL`!|
|integer or INT|A whole number|
|decimal(precision, scale)|Precision is the total number of digits on both sides of the decimal; scale is the number of digits on the right (fractional) side of the decimal|
|timestamp|Date and time in YYYY-MM-DD HH:MM:SS format|
|date|Date in YYYY-MM-DD format|

### Keys and Constraints
Unlike data types, constraints are optional in column definitions. However, they're helpful in maintaininf the integrity and quality of the data stored in the columns.

A constraint can be applied to:
- A specific column
- An entire table
- Multiple tables
- An entire schema

The above code has 2 constraints: `UNIQUE` and `NOT NULL`.
- `UNIQUE`: prevents duplicate values in a column
- `NOT NULL`: a column value cannot be empty (i.e. `NULL`)

And the related `DEFAULT` isn't strictly a constraint, but has the special property of using the `DEFAULT` value when no value is set.

### Viewing a table
We can view all of the tables (i.e. relations) in a database through the `\dt` meta-command. This is helpful to quickly view all of a database's tables.

The `\d $NAME` command allows us to view a more detailed analysis of a specific table of name `$NAME`. Unlike `\dt`, `\d $NAME` gives us each column of a table with its data type and properties.

### Schema and DCL
The SQL sub-language Data Control Language is used to determine the user control settings. This relates to scheme in the sense that setting user permissions is part of creating the structure of a table and database.

## Alter a table
Data Definition Language (DDL) allows us to also change an existing table in some way like:
- Altering a column's name
- Creating or deleting a column
- Changing it's data type

A table can be altered with the SQL statement `ALTER TABLE`, which changes the table schema.

### Renaming a table
We can rename a table with the `ALTER TABLE` statement and the `RENAME` clause followed by the `TO` clause. For example: `ALTER TABLE users RENAME TO all_users;` changes the table name `users` to `all_users`.

### Renaming a column
We can use the `ALTER TABLE` statement and `RENAME` clause to rename columns rather than the table itself. To do so, we need to use the `COLUMN $NAME` clause before `TO`. For example, `ALTER TABLE all_users RENAME COLUMN username TO full_name;` changes the `all_users` table's `username` column to `full_name`.

### Changing a column's data type
We need to use `ALTER TABLE $TABLE ALTER COLUMN $NAME TYPE $TYPE;`. Thus, we use the:
- `ALTER TABLE` statement
- Table name: `$TABLE`
- Clauses: `ALTER COLUMN`, `TYPE`
- Column name: `NAME`
- New data type: `$TYPE`

### Adding a constraint
Changing constraints depends on the type of constraints we're working with:
- Table constraints
- Column constraints: `NOT NULL`
- Both: e.g. `PRIMARY KEY`, `UNIQUE`, `CHECK`

The `CREATE TABLE` SQL statement lets us use both table and column constraints but most other statements only allow us to use column constraints.

Since `NOT NULL` is always a column constrate to add it to an existing table we need to use the special clause `ALTER TABLE $TABLE **ALTER COLUMN** $NAME SET NOT NULL;`.

Other constraints can be added with the `ADD CONSTRAINT` clause.

### Removing contraints
Constraints can be removed with:
```sql
ALTER TABLE $TABLE
DROP CONSTRAINT $CONSTRAINT;
```

For example,
```sql
ALTER TABLE all_users
ALTER COLUMN id DROP DEFAULT;
```

### Adding and removing columns
We can add a column with the `ADD COLUMN` clause followed by the new column's name, data type and constraints.

Columns can be removed with the `DROP COLUMN` clause followed by the column's name.

Both are clauses of the `ALTER TABLE` statement.

### Dropping tables
We can remove a table from the database with `DROP TABLE $TABLE`. This action cannot be undone.


# Data (content)

Data Manipulation Language (DML) finds (queries), adds, removes and modifies pieces of data in a database.

DML statements can be categorized in:
- `INSERT`: add new data to a database table
- `SELECT`: retrieve existing data from a database table
- `UPDATE`: update existing data in a database table
- `DELETE`: delete existing data from a database table

These 4 functionalities are commonly refered to as CRUD:
- Create (`INSERT`)
- Read (`SELECT`)
- Update (`UPDATE`)
- Delete (`DELETE`)

Web apps that provide an interface to execute these operations are typically referred to as CRUD apps.

## Add data with INSERT
An `INSERT` SQL statement has the form of:
```sql
INSERT INTO table_name (column1_name, column2_name, ...)
  VALUES (data_for_column1, data_for_column2, ...);
```
Which requires 3 pieces of information:
- The table name
- The names of the columns in the table
- The values stored in the table's columns

Implication: when inserting data we can specify some or all of the columns in a table.

### Adding rows
Rows (or tuples) contain the table's data. Each row is an individual entity, and has a value for each column in the table.

We can create a row via the `INSERT` statement and the `INTO` clause:
```sql
sql_book=# INSERT INTO users (full_name, enabled)
sql_book-# VALUES ('John Smith', false);
```

When we add a row the last digit returned is the number of rows added to the database.

If we're adding multiple rows we only need to separate them by commas:
```sql
sql_book=# INSERT INTO users (full_name)
sql_book-# VALUES ('Jane Smith'), ('Harry Potter');
INSERT 0 2
```

Note that when you're adding a new row you need to insert a value for columns with `NOT NULL` or `UNIQUE` constraints, or you'll get an error.

### CHECK constraints
A `CHECK` constraints verifies that the values entered in the columns conform to specific rules. The data is first checked before it's added to the database.

An example `CHECK` constraint would be:
```sql
sql_book=# ALTER TABLE users ADD CHECK (full_name <> '');
ALTER TABLE
```
Where `<>` is the not equals SQL operator (equivalent to Ruby's `!=`). Thus, if an entry for the `full_name` column is empty it'll now return an error given that it doesn't conform to the check constraint.

## Select queries
`SELECT` has the following syntax:
```sql
SELECT [*, (column_name1, column_name2, ...)]
FROM table_name WHERE (condition);
```
Where:
- `[*, (column_name1, column_name2, ...)]` is the column list
  - It can either be everything (`*`) or specific columns
- `FROM` clause specifies the table
  - `table_name` is the table used
- `WHERE` clause allows su to filter data based on a condition
  - The condition will typically use one of the table's columns

### Keywords vs identifiers
Keywords are SQL commands that tell PostgreSQL to do something. FOr example, `INSERT`, `ALTER TABLE` and `SELECT`.

Identifiers specify tables or columns. For example, `SELECT * FROM table WHERE id=1` has 3 identifiers: `*`, `table` and `id`.

### ORDER BY clause
The `ORDER BY` clause orders the result by a criteria. We can specify the sorting direction with `ASC` (the default value) and `DESC`. Furthermore, we can sort by more than 1 column by comma-separating expressions in the `ORDER BY` clause.

```sql
SELECT *
FROM users
ORDER BY
  enabled DESC,
  full_name ASC;
```
This query orders in descending order by the `enabled` column and then orders those results by the `full_name` column in ascending order.

### Operators
Operators are typically used in the conditionals of the `WHERE` clause. Operators can be grouped into a few types:

1. Comparison
  - `<`, `>`, `<>` or `!=` (not equal), `<=`, `>=`, and `=` (equal)
  - Note: besides comparison operators there are comparison predicates
    - Comparison predicates behave like comparison operators but have special syntax
      - Correct: `... WHERE my_column IS NULL;`
      - Incorrect: `... WHERE my_column = NULL;`
    - Comparison predicates include: `BETWEEN`, `NOT BETWEEN`, `IS NULL`, `IS NOT NULL`
2. Logical
  - `AND`, `OR` and `NOT`
  - E.g. `... WHERE name = 'Harry' OR enabled = 'true';`
3. String matching
  - This searches a sub-set of data within a column
  - Most common operator: the case-sensitive `LIKE`
    - E.g. `SELECT * FROM users WHERE full_name LIKE '%Smith';`
  - Case insensitive alternative: `ILIKE`
  - `%` stands for any number of characters
    - E.g. `%Smith` means anything that ends with Smith
  - `_` stands for a single character

### `LIMIT` and `OFFSET`
Sometimes we want results to be displayed by portions. For example, in Reddit we don't want all of the results to appear simultaneously.

"Pagination" is displaying data as pages. Pagination is can be achieved with SQL through the `LIMIT` and `OFFSET` clauses.

`LIMIT $number` limits the number of rows returned up to the number set by `$number`. But what if we want to see a batch that isn't the first one?

This is what `OFFSET` achieves — it allows us to skip data. `OFFSET $number` skips the first `$number` rows.

### `DISTINCT`
`DISTINCT` is a clause used right before the column and after `SELECT` to restrict the selection to the column's unique data.

```sql
SELECT DISTINCT full_name FROM users;
 full_name
--------------
 John Smith
 Jane Smith
 Harry Potter
(3 rows)
```

### Functions
Functions are commands included in the RDBMS that performs operations on fields or data.

Common types of function include:
- String: operation on string values
  - `length`: returns the length of every row's value
    - E.g. `SELECT length(name) FROM users;`
  - `trim`: removes spaces
    - E.g. `SELECT trim(leading ' ' from name) FROM users;`
- Date/time
  - Operations on date and time data
    - `date_part`: view a table with only part of a row's timestamp
      - E.g. `SELECT name, date_part('year', last_login) FROM users;`
    - `age`: returns the time difference between the current time and the timestamp passed as an argument
      - E.g. `SELECT name, age(last_login) FROM users;`
- Aggregate: compute a **single** result from a set of inputs
  - `count`: `SELECT count(id) FROM users;`
  - `sum`: `SELECT sum(revenue) from orders;`
  - `min`: `SELECT min(revenue) from orders;`
  - `max`: `SELECT max(revenue) from orders;`
  - `avg`: `SELECT avg(revenue) from orders;`

Aggregate functions are bolstered by the `GROUP BY` clause. This caluse allows us to analyze data in more detail by producing individual results per entry.
```sql
SELECT first_name, count(first_name)
FROM famous_people
GROUP BY first_name;
 first_name | count 
------------+-------
 Frank      |     1
 Madonna    |     1
 Bruce      |     1
 Elvis      |     1
 Tom        |     1
 Scarlett   |     1
 Prince     |     1
(7 rows)
```
## Update data
`UPDATE` and `DELETE` statements allow us to change values in a database.

### UPDATE
Its syntax is
```sql
UPDATE table_name SET [column_name1 = value1, ...]
WHERE (expression);
```
Note that if the `WHERE` statement is omitted PostgreSQL will update every applicable value in the table!

The hassle in this is that we need to specify a change to specific values. For example, if we want to change 2 column values we'd need to do something like:
```sql
UPDATE celebrities SET occupation = 'Singer' WHERE id = 5 OR id = 6;
```

### DELETE
The syntax is:
```sql
DELETE FROM table_name WHERE (expression);
```

As with `UPDATE`, if we exclude the `WHERE` condition this would delete all rows. Note that unlike `UPDATE`, `DELETE` doesn't use the `SET` clause.

The key difference between `UPDATE` and `DELETE` is that `UPDATE` can modify values in a row whereas `DELETE` **can only delete entire rows**. To approximate the deletion of specific values in a row without deleting the entire row we should use `UPDATE` to replace those values with `NULL` (i.e. unknown value).

# Working with multiple tables
If we were to hold all data in a single table we'd have issues like:
- Data duplication
  - E.g. details of the same book being checked out multiple times
- Data integrity
  - A value could be incorrectly entered — and we wouldn't know which entries of the same item are correct or incorrect

Splitting up data to remove duplication and improve data integrity is caller normalization.
- The reason for normalization is to **reduce data redundancy and improve data integrity**
- The mechanism through which data is normalized is:
  - Arranging data in multiple tables
  - Defining the relationships between tables

## Creating multiple tables
Designing a database involves:
- Defining entities to represent different sorts of data
- Designing relationships between those entities

### Entities
An entity represents a real world object or set of data we want to model in the database. An entity could be in a single or (more commonly in the real world) multiple tables of data.

For example, in a book application the tables and entities could be:
- `users`: data on individual users who use the app
- `addresses`: address information for each user
  - Note: here it's separate from users because it'll be used occassionally — not for every user interaction
- `books`: the books in the book app
- `checkouts`: an entity that exists between users and books (since books can be checked out)
- `reviews`: for users to leave reviews of book's they've read

Each of these 5 entities would have its own table with its respective columns.

### Relationships
We also need to establish the relationships between the entities of the database. These relationships are sometimes illustrated as Entity Relationship Diagrams (ERD), which display entities and their relationships. This is common in database design.

![](https://d186loudes4jlv.cloudfront.net/sql/images/table_relationships/simple-erd-fixed.png)

### Keys
We can implement the relationships between entities in the table schema with keys.

Keys are a special type of constraint to establish relationships and uniqueness. Keys identify a specific row in a current or another table.

- Primary keys: a unique identifier for a row of data in a table
  - Being a unique identifier requires the row to:
    - Have data (`NOT NULL`)
    - The data should be unique (`UNIQUE`)
  - Thus, making a column `PRIMARY KEY` is like adding `NOT NULL` and `UNIQUE` constraints
  - Note: **each table can only have 1 primary key**, which is typically called `id`
  - E.g. `ALTER TABLE users ADD PRIMARY KEY id;`
- Foreign keys: help us associate rows in different tables
 - How: referencing the primary key column of another table

Note: a single column can be both the primary and foreign key

```sql
/*
one-to-one: User has one address
*/

CREATE TABLE addresses (
  user_id int, -- Both a primary and foreign key
  street varchar(30) NOT NULL,
  city varchar(30) NOT NULL,
  state varchar(30) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);
```
In the example above, `user_id` is the primary key which references `id`, the primary key of the `users` table.

There are 3 relationship types:
- One-to-one
  - The same primary key is used in both tables
    - I.e., one table has a PRIMARY KEY and no FOREIGN KEY, the other table has as its PRIMARY KEY and FOREIGN KEY the first column's PRIMARY KEY
      - Implication: NOT NULL and UNIQUE to the PRIMARY/FOREIGN KEY values
- One-to-many
  - The table whose rows can be referenced multiple times has its PRIMARY KEY used as FOREIGN KEY in the second table
- Many-to-many
  - Both tables have their PRIMARY KEY and as a FOREIGN KEY reference the other's PRIMARY KEY

### ON DELETE clause

`ON DELETE` is a clause that specifies what happens to the rows referencing another table's primary key if the primary key value is deleted. `ON DELETE CASCADE` deletes the row that references the deleted row. Alternatives to `CASCADE` include `SET NULL` (sets the referencing row's values to `NULL`) and `SET DEFAULT`.

### Referential integrity
A value needs to reference an existing value or return an error. Thus, the foreign key column of a table can't add a value that does not exist in the primary key column being referenced.

## SQL joins
If we want to select data that's split across different tables we need to join the tables before selecting the data that we need.

`JOIN`s is how SQL handles queries across more than one table. `JOIN` is an SQL clause that links 2 tables together, typically based on the keys that define the relationship of the tables.

There are several type of `JOIN`s:
- `INNER`
- `LEFT OUTER`
- `RIGHT OUTER`
- `FULL OUTER`
- `CROSS`

The general syntax is
```sql
SELECT [table_name.column_name1, table_name.column_name2,..] FROM table_name1
join_type JOIN table_name2 ON (join_condition);
```
To join 2 tables together PostgreSQL needs to know a few pieces of information:
- The name of the first table
- The type of join
- the name of the second table
- The join condition (logic that joins rows of different tables)

### Multi-table queries and keys
Tables that share information about a single entity have a primary key that uniquely identifies that entity across the database. It's typically an auto-incrementing integer because it's space-efficient, but could also be other types of values.

## Aliasing

We can create useful tables using SQL by setting the columns up using `SELECT`. However, what if we don't want to use a column? What if we want to perform an operation using multiple columns? In those cases, we need to use aliasing to give it an easy-to-understand column name.

```sql
SELECT
item AS name, menu_price - ingredient_cost AS profit
FROM menu_items
ORDER BY profit DESC
LIMIT 1 ;

 name  | profit
-------+--------
 tacos |   6.99
(1 row)
```

We can also use aliasing with tables:
```sql
SELECT * FROM table_name AS t
```

This is particualrly useful when working with long queries and multiple databases. Instead of referencing `table_name` in the query we'd be able to reference `t`.

## Subqueries

A subquery is a SQL query (i.e., `SELECT` statement) nested within another query.

PostgreSQL provdes **subquery expressions**: expressions that can be used specifically with subqueries. They include: `IN`, `NOT IN`, `ANY`, `SOME` and `ALL`. They're all used to comapre values to a subquery result.

Subqueries are common substitutes of `JOIN` statements. Since they can regularly create the same results, the difference is how they're executed under the hood — which related to query optimization and using `EXAMINE` and `EXAMINE ANALYZE`. However, bear in mind that `JOIN`s are typically (but not always) faster than subqueries.

Subqueries are used to generate a set of values and generally use them as a condition for the outer query.

# Referencing columns with SQL keywords

Sometimes you'll work with tables that share the name of an SQL **reserved** keyword like `WHERE` or `WHEN`. To use that name you need to place the column name in double quotation marks:

```sql
INSERT INTO calls ("when", duration, contact_id) VALUES ('2016-01-18 14:47:00', 632, 6);
```

[See the full list here.](https://www.postgresql.org/docs/9.5/sql-keywords-appendix.html)

# Type conversion — key topic!

We can convert data types by writing `data::new_type`

# Queries within queries — critical!

We can execute a query within a query.
```sql
UPDATE parts
SET device_id=2
WHERE part_number=(SELECT min(part_number) FROM parts);
```