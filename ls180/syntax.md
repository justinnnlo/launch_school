# Keys

## Adding a Key
```sql
ALTER TABLE users ADD PRIMARY KEY (id);
```

## One-to-one

```sql
CREATE TABLE addresses (
  user_id int, -- Both a primary and foreign key
  street varchar(30) NOT NULL,
  city varchar(30) NOT NULL,
  state varchar(30) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);
```

## One-to-many
```sql
CREATE TABLE books (
  id serial,
  title varchar(100) NOT NULL,
  author varchar(100) NOT NULL,
  published_date timestamp NOT NULL,
  isbn char(12),
  PRIMARY KEY (id),
  UNIQUE (isbn)
);

/*
 one-to-many: Book has many reviews
*/

CREATE TABLE reviews (
  id serial,
  book_id integer NOT NULL,
  reviewer_name varchar(255),
  content varchar(255),
  rating integer,
  published_date timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);
```

## Many-to-many
```sql
CREATE TABLE checkouts (
  id serial,
  user_id int NOT NULL,
  book_id int NOT NULL,
  checkout_date timestamp,
  return_date timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);
```

# UPDATE

```sql
UPDATE table_name SET [column_name1 = value1, ...]
WHERE (expression);
```

# DELETE

```sql
DELETE FROM table_name WHERE (expression);
```
# DISTINCT
```sql
SELECT DISTINCT column FROM table_name;
```

# JOIN

```sql
SELECT [table_name.column_name1, table_name.column_name2,..] FROM table_name1
join_type JOIN table_name2 ON (join_condition);
```

# SELECT
```sql
SELECT [*, (column_name1, column_name2, ...)]
FROM table_name WHERE (condition)
ORDER BY column_name;
```

# CREATE TABLE
```sql
CREATE TABLE table_name (
  column_1_name column_1_data_type [constraints, ...],
  column_2_name column_2_data_type [constraints, ...],
  .
  .
  .
  constraints
);
```

# Aliasing

```sql
SELECT u.full_name, b.title, c.checkout_date
FROM users AS u
INNER JOIN checkouts AS c ON (u.id = c.user_id)
INNER JOIN books AS b ON (b.id = c.book_id);
```