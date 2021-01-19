PostgreSQL and most database systems support many data types. We'll focus on:

|Data type|Type|Value|Example|
|-|-|-|
|`varchar(length)`|character|up to `length` characters of text|`canoe`|
|`text`|character|unlimited length of text|`this is a long string`|
|`integer`|numeric|whole numbers|`42`, `-154`|
|`real`|numeric|floating-point numbers|`24.345`|
|`decimal(precision, scale)`|numeric|numbers of arbitrary precision|`123.43`, `2.456`|
|`timestamp`|date/time|date and time|`1999-01-08 04:05:06`|
|`date`|date/time|only a date|`1999-01-08`|
|`boolean`|boolean|`true` or `false`|`true` or `false`|

What stood out to me_
- `timestamp` (date and time) vs `date` (date only)
- `real` (floating point numbers) vs `decimal` (numbers or arbitrary length rather than strinctly decimal numbers)
- `varchar(N)` which allows up to N number of characters vs `text` which allows unlimited number of characters
  - Note: there isn't a performance difference between `varchar` and `text`, and `text` sometimes even performs better than `character(N)`
- `numeric` allows for numbers of arbitrary precision and size

Note that data types vary across RDBMS. For example, `text` is a special data type related to `PostgreSQL`.

# Understanding NULL

Relational databases have the `NULL` special value. This is similar to `nil` in Ruby, `null` in Javascript and `None` in Python.

But unlike these languages, in RDBMS `NULL` comparisons return `NULL` — not `true`.
```sql
sql-course=# SELECT NULL = NULL;
 ?column?
----------

(1 row)
```

However, this works as in other languages when we use `IS NULL` or `IS NOT NULL` clauses:
```sql
sql-course=# SELECT NULL IS NULL;
 ?column?
----------
 t
(1 row)

sql-course=# SELECT NULL IS NOT NULL;
 ?column?
----------
 f
(1 row)
```

Note that when you order data in descending order `NULL` is the topmost value. The logic is that `NULL` can't be compared with other values, so will the the first one.