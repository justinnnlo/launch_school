Subqueries are typically used to return a set of values to use as part of an outer query's condition. Yet how many values are returned by the subquery is important because of how some operators or expressions work.

For example, `=` can only be used with a single value. This is why subqueries tend to use subquery expressions. These are special operators to be used in subqueries, usually within a conditional subquery.



# `EXISTS`

Boolean: it checks if at least 1 row is returned.

```sql
my_books=# SELECT 1 WHERE EXISTS
my_books-#   (SELECT id FROM books
my_books(#     WHERE isbn = '9780316005388');
 ?column?
----------
        1
(1 row)
```
In the above query, `SELECT` returns `1` if the condition `WHERE EXISTS ...` returns `true` (it does).

# `IN`

Boolean: if a row equals to an evaluated expression it returns `true` or, otherwise, `false`.

```sql
my_books=# SELECT name FROM authors WHERE id IN
my_books-#   (SELECT author_id FROM books
my_books(#     WHERE title LIKE 'The%');
      name
----------------
 Iain M. Banks
 Philip K. Dick
(2 rows)
```

The subquery `(SELECT author_id FROM books WHERE title LIKE 'The%')` returns the results `(2, 3)`:
```sql
   author_id
---------------
      2
      3
```

Thus, the outer query essentially becomes:
```sql
my_books=# SELECT name FROM authors WHERE id IN
my_books-#   (2, 3);
      name
----------------
 Iain M. Banks
 Philip K. Dick
(2 rows)
```

## `NOT IN`

`NOT IN` is the inverse of `IN`.

# `ANY`/`SOME`
These 2 subquery expressions are synonyms and can be used interchangeably. They use any operator to compare results — but with the entire values returned by the subquery.

For example, `WHERE length(name) > ANY (SUBQUERY)` returns true if the length of the current value of `name` is larger than at least one value returned by the subquery.

Note that `IN` is equivalent to using `ANY` or `SOME` with the `=` operator.

# `ALL`
All is like `ANY` / `SOME` but it returns `true` when the comparison is true for all of the values returned by the subquery.
