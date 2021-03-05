# One-to-Many relationships

If we need to update information in a database we'd need to update every row that contained information of that contact. If we were to update some but not all rows related to that entity our database would be inconsistent. This is known as **update anomaly**.

**Insertion anomaly** is when we can't store information of an entity unless we insert other attribures (e.g. not storing information of a contact unless it makes a call first, i.e. storing data unrelated to the contact like call length).

**Deletion anomaly** is when we lose all information of an entity if we delete some attributes (e.g. deleting all call data and thereby losing contact information).

These 3 anomalies, update, insertion and deletion anomalies, are all caused by the consequences of having duplicated data in denormalized databases.

Normalization is the **process** of designing schema that minimizes or eliminates the likelihood of these 3 anomalies. Normalization extracts data from a database and splits it into multiple tables with foreign and primary keys to establish their relationships.

## Extracting a 1:M relationship from existing data

# Many-to-Many relationships

Many-to-many relationships are when multiple instances can appear on both side. (Note: **can we describe the instances as entities?**)

A **join table** stores information about a many-to-many relationship. For example, if we have a table `books` and a table `categories` we can have books with multiples categories and categories with multiple books. Thus, we'll store this information in the join table `books_categories`, which matches in each row the book id with the category id. This implies that a single book may have many rows (one for each of its categories) and a single category can have many rows (one for each book of that category).

## Join tables and primary key columns

There are some frameworks like Ruby on Rails that suggests that join tables have primary key columns to uniquely identify each row in the join table. However, we can identify join table rows through its values (which themselves refer to rows with primary ids).

## Converting a 1:M relationship to a M:M relationship