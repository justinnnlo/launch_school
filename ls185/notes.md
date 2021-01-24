# Connecting to a postgre database with Ruby

- Install the `pg` gem with `gem install pg`.
- Access the `pg` gem with `require "pg"` in either `pry` or the file you're working in.
- `db = PG.connect(dbname: "$name")` creates a connection object that allows us to interact with the database
- `show-method PG.connect` shows that the method is essentially syntactical sugar for another method that creates a `Connection` object
  ```ruby
  From: /Users/jadlp/.rbenv/versions/2.7.1/lib/ruby/gems/2.7.0/gems/pg-1.2.3/lib/pg.rb:56:
  Owner: #<Class:PG>
  Visibility: public
  Signature: connect(*args)
  Number of lines: 3

  def self::connect( *args )
    return PG::Connection.new( *args )
  end
  ```
- We can send a SQL statement to the server and get the result back with the PG connection object using the `PG::Connection#exec` method
- A `PG::Connection` object returns a `PG::Result` object from the database
- We can use the `cd $PG::Result-object` method to go into the scope of the `PG::Result` object, and `cd ..` returns us to the scope of `main`
- We can access the data from `PG::Result` with
  - `PG::Result#values` method returns as an array of string arrays all of the rows that were selected
  - `PG::Result#fields` method returns an array of strings with the column names
  - `PG::Result#ntuples` returns the number of rows in the object
  - `PG::Result#[$index]` returns a hash of the row of index value $index
  - `PG::Result#field_values($column)` returns an array of strings of all the values in that column/field
  - `PG::Result#column_values($index)` like `#field_values` but where `$index` is an integer of the column and `$column` is the column name
  - `PG::Result#each` works like `Enumerator#each`, where a hash/tuple representing a row is passed with key (column names) value (the column's value at that row) pairs
    - E.g. `result.each { |tuple| puts "#{tuple["title"]} came out in #{tuple["year"]}" }`
  - `PG::Result#each_row` works like `PG::Result#each` but the rows are represented as arrays rather than hashes

# Creating a shell program
- Create a `Gemfile` and add the `pg` gem if we want it to access a database
- Add a "hash-bang" at the top of the shell program so that the Ruby interpreter can execute the script: `#! /usr/bin/env ruby`
- Add the executable permission with the command `chmod +x $filename`
- Require the `pg` gem within the the program as in a Ruby file
- Unless the program is in the `PATH`, execute the program with `./ $filename`

# Working with shell arguments
- When we execute an executable file we can pass arguments to it, e.g. `./file arg1 arg2`
- We can use the Ruby array `ARGV` to access these values passed to the command line
  - The first argument is `ARGV[0]`, the second `ARGV[1]`, and so forth
- We can use `if` or `case` statements to search for a command to determine what code to execute
  - E.g. if `ARGV[0]` is `add` we'll execute the program's `add` method and pass it any relevant arguments
- We can use the `PG::Connection#exec` method to send `SQL` statements to the database
- We need to be careful with security issues: a user could send inputs that delete data or manipulate it in some other malicious and unintended way
  - E.g. SQL statement: `"INSERT INTO expenses(amount, memo, created_on) VALUES (#{amount}, '#{memo}', #{date});"`
  - Malicious script: `./expense add 0.01 "', 20150303); DROP TABLE expenses; --"`
  - Resulting SQL statement: `INSERT INTO expenses(amount, memo, created_on) VALUES (0.01, '', 20150303); DROP TABLE expenses; --', #{date});`
  - Explanation
    - `./expense` executes the `expense` file in the current directory
    - `add` is the command
    - `0.01` is the first argument that becomes `amount`
    - `"', 20150303); DROP TABLE expenses; --"` is the 2nd argument that becomes `memo`, but it packs many things within
      - `'` creates an empty space with the first single quote surrounding the entire input
      - `, 20150303);` sends the 3rd argument (a date) and executes the SQL statement
      - `DROP TABLE expenses;` executes the SQL statement to drop the expenses table
      - `--` is how an SQL comment starts — which ensures that the rest of the SQL statement in the file isn't executed (i.e. `', #{date});`)
  - Implication: **an attacker can break out of quotes and manipulate SQL statements** with **SQL injection attacks**
    - This is difficult to stop because of the edge cases in quoting and ascaping string values
- `PG::Connection#exec_params` is a safer method than `PG::Connection#exec`
  - `#exec_params` uses the `params` array to bind the parameters for the SQL query
  - Parameters are represented by `$1`, `$2`, `$n`, where the 0th element of the params array is bound to `$1`, the 1st to `$2`, etc
    - Note that `nil` is treated as `NULL`
  - In `exec_params` the oarameter values can be separated from the command string (unlike in `exec`)
    - Thus, quoting and escaping isn't necessary
- The above security hazard stops being one with `exec_params`
  - SQL statement: `sql = "INSERT INTO expenses(amount, memo, created_on) VALUES ($1, $2, $3);"`
  - Ruby code: `DB.exec_params(sql, [0.01, "', 20150303); DROP TABLE expenses; --", date])`
  - Resulting SQL statement: `INSERT INTO expenses(amount, memo, created_on) VALUES (0.01, "', 20150303); DROP TABLE expenses; --", '20210119');`
    - Why it's safer: the malicious script was inserted as a single string

# Code structure
1. When you enter the name of a program and its arguments it executes the program
2. The program uses the CLI class to tell you anything about the program that's related to its CLI — like processing the arguments passed by the user
3. CLI determines what methods to call on the ExpenseData class
  - It communicates with the database
    - It sends SQL queries and receives query results
  - It formats and displays the results
4. ExpenseData sends the outputs to the CLI

# Creating a table from scratch
- We can query the database to check if a table exists with `information_schema.tables`
  - 2 conditions to check: `table_schema = 'public'` and `table_name = '$table'`
- We can insert SQL with a heredoc
  - `<<~HERE...HERE` or `<<~SQL...SQL` or `<<~ABC...ABC`
  - Passing a heredoc (which is just a multiline string) to SQL through `exec` or `exec_params` will execute the SQL statements to create the database
- Alternative: using a psql console command from the terminal?
  - E.g. from the Ruby file execute `psql -d db < file.sql`

# Miscellaneous
- Ruby methods
  - `gets` is for general input and `IO#getch` is to get the first character inputted
    - Note: needs `require "io/console` and it written as `$stdin.getch`
  - `String#rjust` justifies the text — it's a better way of justifying text that is surrounded by other characters (like empty spaces)
- Heredocs are for multiline strings and are defined with `<<~Text`, where `Text` can take any value
- Case statements use `when`, can be multiline, but single line require `when...then` syntax (barring `else`, which doesn't use `then`)