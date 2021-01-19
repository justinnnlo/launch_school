# What are indexes?

A mechanism used by SQL engines to speed up queries.

Indexes stored indexed data in a table-like structure to quickly search them with specific search algorithms. They allow a database engine to locate column values more efficiently because they don't have to search every record in a table in sequence.

Typically, a query would go row by row. But if we index a column in a new table, then we'd just have to find the index referenced in the query within that table to find its rows.

For example, you can have a table of books with their authors. If I want to reference all the books of 'Mario Vargas Llosa', the SQL query would check every row if the column value of `author` matches `'Mario Vargas Llosa'`. However, I can index the `author` column. This creates a new table with the distinct values of all of the authors and the rows that they reference. By using the index I would be searching through less rows (as author names aren't repeated) to reach the same conclusion (references of each row with `'Mario Vargas Llosa'` as an author).

THere are many types of indexes. They use different data structures and search algorithms. PostgreSQL indexes include: B-tree, Hash, GiST, and GIN.

# When to use an index

Indexing a column doesn't always lead to faster queries. Indexing requires updating both the table and the index, which has a performance cost.

Indexes are typically used when:
* Sequential reading is inadequate
  - Columns that help map relationships (e.g. Foreign Key columns)
  - Columns frequently used in the `ORDER BY` clause
* They're used in tables and columns where the data is read much more frequently than created or updated

# Creating indexes

We've already used indexes inadvertently. `PRIMARY KEY` and `UNIQUE` create an index on the column it's used in to enforce uniqueness. We can corroborate this by looking at the indexes referenced in the description of a table's schema.

The general form for creating an index is:
```sql
CREATE INDEX index_name ON table_name (field_name);
```
Where PostgreSQL automatically generates an index name if `index_name` is omitted.

## Unique and non-unique indexes
`PRIMARY KEY` and `UNIQUE` create unique indexes. Unique indexes enforce uniqueness — it doesn't allows multiple equivalent values for an index. Non-unique indexes allow repeated values.

## Multicolumn indexes
This has a revised form:
```sql
CREATE INDEX index_name ON table_name (field_name_1, field_name_2);
```
But not every index type supports multicolumn indexes, and even then have a limit on how many columns are indexed.

## Partial indexes
These are built on a subset of data in a table defined by the conditional expression. Partial indexes only reference rows in this subset. For example, we could index rows if their `id` is under 100 or if a certain column string starts with `A`.

## Deleting indexes
Indexes can be viewed through the `\di` psql console command.

Indexes can be deleted via the `DROP INDEX` SQL command.