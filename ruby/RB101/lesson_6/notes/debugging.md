My definition: debugging is the task of identifying and solving coding errors in a program.

Presentation:
- Bugs are human errors in code.
- Debugging is the process of identifying and fixing those error.

# Debugging as a process
1. Identify the problem
2. Undertsand the problem: inputs? output? isolate where it occurs?
3. Implement the solution

# Types of errors
Many ways to categorize this, but very broadly:
- Syntax errors
  - The code does not respect the grammar of the programming language being used
  - Generally stops the code
- Logical error
  - Errors in the logic of the code##
  - It may run but produce unexpected results

# Debugging with pry

Besides being a REPL, pry allows us to stop the execution of a program, access those variables, call methods on the variables, and more.

We can use its debugging tools by putting `require "pry"` at the top of the program and writing `binding.pry` right before where we want the program to stop executing.

## What is pry?
- A Rubygem
- A REPL: read-evaluate-print-loop
  - Syntax highlighting
  - `cd [object]`
    - Writing the name of a method invokes it within pry on the object
    ```ruby
    [3] pry(main)> cd [1,2,3]
    [4] pry(#<Array>):1> last
    #=> 3
    ``` 
    - Further putting `ls` lists all of the methods of that data type
- A debugging tool
  - `binding.pry`
  - Key commands
    - `next`
    - `step`
    - `continue`