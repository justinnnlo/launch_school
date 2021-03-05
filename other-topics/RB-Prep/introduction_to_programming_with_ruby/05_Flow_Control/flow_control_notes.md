# Conditionals

The condition tells the program where to continue next. The basics are logical structures: booleans, comparison operators, if/else and while statements.

With these tools we're "controlling the flow of the program" by determining what execution path it should take.

`unless` is a useful reserved word that allows exceptions to conditionals.

# Comparisons

Boolean values are `true` or `false`. There are several ways we can get to those values
- Comparisons: `3 > 4`
- Conditional statements: `if x == 3` becomes `if true` or `if false`, depending on whether x == 3 or not
- Boolean value of the data type: a character, string, hash, array, etc has by "default" a boolean value of `true`. We can tap that with the bang or double bang. E.g. "!!"hi"" is equivalent to true. Conversely, `nil` is `false` when you use a double bang.

# Combining expressions

`and` and `or` logic.

# Ternary operators

A ternary operator is syntactic sugar for short `if` statements.

[Statement to evaluate] ? [Return if true] : [Return if false]

`3 > 4 ? "3 is larger than 4!" : "Jokes, not really"` # Returns "Jokes, not really"

# Case statement

This is similar to an `if` statement but uses the reserved words `case`, `when`, `else`, and `end`.

a = 10

case a
when 10
  p "a has a value of 10"
when 5
  p "a has a value of 5"
else
  p "a doesn't have a value of 5 or 10"
end

Which is roughly equivalent to

a = 10

if a == 10
  p "a has a value of 10"
elsif a == 5
  p "a has a value of 5"
else
  p "a doesn't have a value of 5 or 10"
end

How are they different? 
- With case, we only need to define once the variable we want to test (case a vs if... elsif...) but we can specify the variable (if we'd like)
- We can also save the result of a case statement

# True and False

Every expression evaluates to true when using control flow **except for false and nil**

Thus, we can do things like

if x = 5 # Assign the value 5 to the local variable `x` and evaluate the statement to true
  puts "how can this be true?"
else
  puts "it is not true"
end