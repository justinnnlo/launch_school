# Relevance
Different statement structures lead to different performances when executing the query.

# Query assessment with `EXPLAIN`
`EXPLAIN` gives a step-by-step analysis of how a query is executed by PostgreSQL internally. PostgreSQL creates a **query plan** to execute each query. `EXPLAIN` allows you to access and read a statement's query plan.

Within `(cost=int1..int2)`, `int2` represents the total cost of the query — this is the number to watch out for!

`EXPLAIN` doesn't run the actual query — it provides an estimate. To assess the query with actual date from running it we need to run `EXPLAIN ANALYZE`.