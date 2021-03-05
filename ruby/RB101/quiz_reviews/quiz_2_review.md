# 100% success rate!!!

# 1. MyModule

ANSWER: B, camel case

# 2. Valid Ruby comment style?

ANSWER: C, `#`

# 3. Valid ruby syntax?

ANSWER: A, B, D
C: wrong for module to have parentheses (`Kernal()`) though its ok for methods to have or not if they don't have arguments

# 4.

Answer: D — `if a = 2` always returns `true`

# 5. What is pseudocode?

Pseudocode is an approach to solving a coding problem at a high-level and using English rather than a programming language's syntax.
The purpose of pseudocode is to separate the logic from the syntax of the language to make the task more simple.

ANSWER: B

# 6. How can the code output `Goodbye`?

```ruby
num = 8

if #omitted code
  puts 'Goodbye'
end
```

We're looking for anything that evaluates to `true`.

ANSWERS: A, B, C, D
- A: num > 5 && num < 10 => true && true => true
- B: num < 4 || num == 8 && num > 6 => false || true => true
  - Note: && binds more closely than ||
- C: num < 7 || num > 7 => false || true => true
- D: num >= 8 && num < 6 || num > 4 => true && false || true => false || true => true

# 7. Output `Hello`

```ruby
num = 12

if #omitted code
  puts 'Hello'
end
```

ANSWERS: C, D
- A: `num / 3 > 3 && num < 10` => 4 / 3  > 3 && num < 10 => true && false => false
- B: `num < 4 || num > 8 && num < 10 || num > 16` => false || false || false => false
- C: `num % 4 == 0 || num < 7 && num < 10` => true || false => true
- D: `num >= 8 && num < 6 || num > 4 && num < 16` => true && false || true && true => false || true => true

# 8. What code matches the pseudocode?

1. Save the first word as the starting value
2. Starting with **the next value** iterate through all the remaining words
3. For each iteration, compare the current to the saved word
  - If the current word is longer or as long as the saved word, assign the current word as the saved one
4. Return the saved value

ANSWER: C
- A: Does not start from value index 1 — does so at 0
- B: Misses the greater or **equal**
- C: Best candidate
- D: Does not start from value index 1 — does so at 0

# 9.

ANSWERS: B, C, D

Something truthy has
- Returns true when preceded by !!
- Not a boolean object
- Not nil or false
- Evaluates to true when using a conditional

# 10. What's the error?

```ruby
user_input = gets       # Misses the #chomp

loop do
  name = user_input
  break
end

if user_input
  puts "Hello " + name # Not valid because it was initialized within a loop
end
```

ANSWER: B

# 11. What's a variable scope?

It's where a variable can be accessed.

ANSWER: C

# 12. What's true of variable scopes?

ANSWERS: A, D
- A: Methods define their own, self-contained scopes
- B: WRONG because if/else statements do NOT define their own scope — they're part of the program's regular execution
- C: WRONG because `{}` and `do/end` only define a new scope when passed to a method — not in other cases
- D: Local variables initialized in an outer scope can be accessed in an inner scope, but not vice-versa

# 13. Why does the code output "hi"?

```ruby
def extend_greeting(greeting)
  greeting + " there"     # String#+ does not mutate greeting
end

greeting = "hi"
extend_greeting(greeting) # Returns "hi there"

puts greeting             # "hi"
```

ANSWER: C

# 14. How to edit the code to output "hi there"?

ANSWERS: B, C, D
- `greeting << " there"`
- End with `puts extend_greeting(greeting)`
- Reassign greeting: `greeting = extend_greeting(greeting)`

# 15. Pass by value or pass by reference?

ANSWERS: A, B, D

When an object is passed to a method:
- Ruby passes the object id and assigns it to a local variables of the same name
  - The parameter acts as a pointer to the original object
  - As its assigned to a local method variable of the same name, reassigning it doesn't affect the variable outside the method
  - Yet the original object can still be mutated within the method!

# 16. What does it mean for a variable to be a pointer?

ANSWERS: B

- It acts as a tag to the object — it isn't the object
- Multiple variables can point to the same object
- If an object pointed by variables is mutated, the value of the object changes but the memory location stays the same
  - Note: the variables would be pointint to the same object with the different value

# 17. Why is the name method invoked instead of the local variable name on line 8 in the following example?

```ruby
def name
  "George"
end

name = "Lisa"

def display_name  # Loval variable isn't passed to the method
  puts name
end

display_name
```

ANSWER: C

# 18. How can we print "Lisa" instead?

ANSWER: D

- `def display_name(name)`
- `puts "Lisa"` within `display_name`

- A: `name()` references the method `name` rather than the local variable
- B: Same as the original — local variable isn't passed
- C: `name()` references the method `name` rather than the local variable
- D: Works

# 19. In the following example, why does Ruby reference the local variable name on line 8 instead of invoking the name method?

```ruby
name = "Lisa"

def name
  "George"
end

loop do
  puts name # Because when there's shadowing Ruby has preference over local variables
  break
end
```

ANSWER: A