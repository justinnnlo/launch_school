We shouldn't use values within the data to identify rows because it can be imprecise and inconvenient. SQL uses keys as an alternative. **A key uniquely identifies a row in a database table**. 2 types of keys include:
- Natural keys
- Surrogate keys

# Natural keys

A natural key is an existing value of the dataset that can be used to uniquely identify a row of data in the dataset. Some seemlingly good candidates of natural keys are not:
- Phone numbers and emails may change hands
- Social security numbers might not change but some people may not use them
- Physical addresses may change or people might not have permanent ones

# Surrogate keys

A surrogate key is a value **created to identify a row of data in a database table**. By being created for the purpose of identifying the row/entity, it can avoid some of the problems that come with natural keys.

A common surrogate key is auto-incrementing integers. This is a sequence: a relation that generates a series of numbers. A sequence will remember the last number that it generated to generate numbers automatically in a predetermined sequence.

Auto-incrememnting integers typically use the data type `serial`, which is equivalent to:
```sql
-- This statement:
CREATE TABLE colors (id serial, name text);

-- is actually interpreted as if it were this one:
CREATE SEQUENCE colors_id_seq;
CREATE TABLE colors (
    id integer NOT NULL DEFAULT nextval('colors_id_seq'),
    name text
);
```

Thus, the next value of the sequence is accessed using `nextval`:
```sql
CREATE SEQUENCE colors_id_seq;
CREATE SEQUENCE

SELECT nextval('colors_id_seq');
 nextval
---------
       1
(1 row)

SELECT nextval('colors_id_seq');
 nextval
---------
       2
(1 row)
```
Note that once `nextval` returns an integer it ** **.

## Serial and uniqueness

`serial` data type creates a sequence — but doesn't enforce that sequence's uniqueness. Thus, we could create duplicate values — thereby not allowing us to uniquely identify a row based on an id.

We can add a `UNIQUE` constraint by:
```sql
ALTER TABLE table ADD CONSTRAINT constraint_name UNIQUE (column);
```

# Primary keys

Just as `serial` is a PostgreSQL shortcut to create auto-incrementing values, `PRIMARY KEY` is a short-cut to uniquely identify the rows in a table.

Largely, `PRIMARY KEY` enforces 2 constraints: `NOT NULL` and `UNIQUE`. Yet the difference between using `PRIMARY KEY` in a column and adding the constraints `NOT NULL` and `UNIQUE` is documenting your intention as a database designer.

# Database design conventions

1. All tables should have a primary key column `id`
2. The `id` column should automatically increment
3. The `id` column will usually be an integer but other data types like UUIDs could be used

## UUIDs

Universally Unique identifiers are large numbers that identify individual objects or, within a database, a row in a database. UUIDs are typically represented with hexadecimal strings with dashes like `f47ac10b-58cc-4372-a567-0e02b2c3d479`.

# Foreign keys

A foreign key can relate to 2 different but related things:
1. A foreign key column: it represents a relationship between 2 columns by pointing to a specific row in another table using its primary key
2. A foreign key constraint: a constraint that enforces rules about what values are permitted in foreign key relationships

Foreign key columns can be defined in 2 different ways:
- In the table definition: e.g. `product_id integer REFERENCES products (id)`
- Altering a table: e.g. `ALTER TABLE orders ADD CONSTRAINT FOREIGN KEY (product_id) REFERENCES products(id);`

## Foreign keys and referential integrity
The key benefit of foreign keys is that they ensure referential integrity. This means that the foreign key column will use an existing value (i.e., an existing value in the other table's primary key column) or return an error.

Thus, foreign keys (through  foreign key constraints) help us avoid situations where foreign key columns violate referential integrity by storing values that do not exist in the primary column that it references.