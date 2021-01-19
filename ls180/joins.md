`INNER JOIN` or `JOIN`: connect tables together based on a shared value. The table specified in `FROM` comes first.
- It finds matching data and returns it
- E.g. doesn't includes
  - Rows in a table that aren't found in the other table were those values are matched
    - E.g. if you join a table of users with a table of comments on the ids of users and the user ids of the comments, the comments without a user id AND the users that don't have their id associated with a comment will BOTH BE EXCLUDED

`LEFT OUTER JOIN`: return all rows from the database specified in `FROM`, even if some entries may not have associated data in the table it's joining

`RIGHT OUTER JOIN`: return all rows from the database that is specified in the right table (i.e., the one not specified by `FROM`), even if some entries may not have associated data in the table it's joining.

`CROSS JOIN`: returns the cartesian product. Matches each row in a table with each row in the other table. This creates all of the combinations of 2 different tables.

`FULL JOIN` connects both tables but doesn't drop any row