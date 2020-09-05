### 1. MyModule is an example of...

B: CamelCase

### 2. What are valid Ruby comment styles?

Inline: `#`

Block: `=begin/=end`

Answer C

### 3. Which are valid examples of Ruby syntax?

```ruby
response = Kernel.gets().chomp() # Yes, calling on the module and parentheses are valid

response = Kernel.gets.chomp # Yes, not having parentheses is valid when no parameters

response = Kernel().gets.chomp # No, it's an error because parameters are reserved for methods — and Kernel isn't one

response = gets.chomp # Yes, it's valid to omit both module and empty parentheses
```
Answer: A, B, D

### 4. What's responsible for this always outputting "Two"?

```ruby
a = 2
b = rand(2)
a *= b

if a = 2 # This — it's reassigning a to 2 so will always be true
  puts 'Two'
else
  puts 'Not Two'
end
```

Answer D: `if a = 2`

### 5. What is pseudocode?

Pseudocode is human-like writing that mimics (more accurate: "is a high-level description of") a program's functionality but without working on the syntax of the programming language.

Answer B is closest: *Pseudocode is a human-readable, high-level description of a program or algorithm which helps us formulate a solution at the logical problem domain level.*

### WRONG 6. What will make the code output `Goodbye`?

```ruby
num = 8

if #omitted code
  puts 'Goodbye'
end
```

```ruby
num > 5 && num < 10 # false => WRONG: true

num < 4 || num == 8 && num > 6 # true => num < 4 || true => true

num < 7 || num > 7 # true

num >= 8 && num < 6 || num > 4 # true
```

Answer: B-D

### 7. Output `Hello`

```ruby
num = 12

if #omitted code
  puts 'Hello'
end
```

```ruby
num / 3 > 3 && num < 10 # num < 10 => false due to short-circuiting (given &&)

num < 4 || num > 8 && num < 10 || num > 16 # num < 4 || false || num > 16 => false

num % 4 == 0 || num < 7 && num < 10 # true => num % 4 == 0 leads to short-circuiting

num >= 8 && num < 6 || num > 4 && num < 16 # false || true => true
```

Answer: C and D

### 8. What's closest to the pseudocode?

```
Given a sentence made up of several words, write a method to do the following.

Iterate through the words one by one.
  - save the first word as the starting value.
  - starting with the next word iterate through all the remaining words in the sentence
  - for each iteration, compare the saved value with the current word.
  - if the word is longer or the same length as the saved value:
    - reassign the saved value as the current word
  - move on to the next word

After iterating through the sentence, return the saved value.
```

```ruby
def longest_word(sentence)
  words = sentence.split
  saved_word = words[0]

  words.each do |word| # Error: should start in next word
    if word.length > saved_word.length
      saved_word = word
    end
  end

  saved_word
end

def longest_word(sentence)
  words = sentence.split
  saved_word = words.shift

  words.each do |word|
    if saved_word.length < word.length # Error: need `<=`
      saved_word = word
    end
  end

  saved_word
end

def longest_word(sentence)
  words = sentence.split
  saved_word = words.shift

  words.each do |word|
    if word.length >= saved_word.length
      saved_word = word
    end
  end

  saved_word
end

def longest_word(sentence)
  words = sentence.split
  saved_word = words[0]

  words.each do |word| # Error: should start in next word
    if word.length >= saved_word.length
      saved_word = word
    end
  end

  saved_word
end
```

Answer: C

### 9. What do we mean when we say something is *truthy*?

If you precede it with `!!` it will return `true`. Thus, it evaluates to true when used in a conditional. By definition, it is not `nil` or `false`. However, it's an object but not a boolean!

Answer: B, C, D

### 10. What's the error?

```ruby
user_input = gets

loop do
  name = user_input
  break
end

if user_input
  puts "Hello " + name
end
```

Mistake: name is within an inner scope and we're calling it outside of it.

Answer: B

### 11. What's a variable scope?

Answer C: It refers to where in a program we can access a variable.

### 12. Facts on local variable scope in Ruby

- If a variable is defined in an outer scope it can be accessed in an inner scope, but not vice verse
- Method invocation with blocks create leaky scopes that are accessuble for outside variables — everything within `do...end` and `{}` is NOT a new scope
- Method definitions create self-contained scopes that are not accessible by outside variables
- if/else statements are part of the regular program execution

Answers: A, D

### 13. Why does the last line output `"hi"`?

```ruby
def extend_greeting(greeting)
  greeting + " there" # String#+ does not mutate the caller
end

greeting = "hi"
extend_greeting(greeting)

puts greeting
```

Answer: C

### WRONG 14. In the previous exercise, how could we modify it to output `"hi there"`?

```ruby
def extend_greeting(greeting)
  greeting + " there" # String#+ does not mutate the caller
end

greeting = "hi"
greeting = extend_greeting(greeting) # reassign

puts greeting
```

```ruby
def extend_greeting(greeting)
  greeting + " there" # String#+ does not mutate the caller
end

greeting = "hi"
puts extend_greeting(greeting) # print the return value
```

The one I missed:
```ruby
def extend_greeting(greeting)
  greeting << " there" # String#+ does not mutate the caller
end

greeting = "hi"
extend_greeting(greeting) # reassign

puts greeting
```

Answer: B and C

What did I get wrong? **I forgot that the `<<` operation mutates the object**. Though we don't get sent a variable, we get sent **the object of a variable**. Thus, mutating the object mutates the value of the variable. This is a **subtle but important distinction that's independent of variable scoping**.

### 15. What does Ruby do when passing an object as an argument to a method call?

- It points to the object and uses that within the method call
- If a variable is passed
  - The method has a self-contained scope, so the variable can't be reassigned unless it has a global/lexical scope
  - What can happen: the object pointed to by the variable can be mutated, which by extension means that the variable's value will change
- However, some methods (typically ending with a `!`) use and mutate the original object

*MISCONCEPTION/WRONG STATEMENT: "By implication, reassigning or mutating an argument within a method does not affect the original object because **it doesn't point to the original object**."*

Answers: C, D. Maybe B, but I don't like that it seems to suggest that the variable passed into the method is the same as the variable outside of it. They share the same name, but are bound to different values.

### 16. What do we mean when we say variables are pointers?

- A variable is a tag that refers to a space in physical memory and allows us to access the value we've bound to it
- When a variable is bound to another variable, it's really bounded to the value of the variable
  - The variable has no intrinsic value, it just **points to its value**
  - Multiple variables can point to the same object
    - Thus, if `a = "hello"` and `b = a`, then `a.object_id == b.object_id` is true
    - By extension, `a.chop!` means `a` mutates its object to `ello`
    - As `b` points to the same object, `b` now returns `ello`

Answers: B

### 17. Why is the `name` method invoked instead of the local vairable `name`?

```ruby
def name
  "George"
end

name = "Lisa"

def display_name
  puts name
end

display_name
````

1. The `name` method is defined before the variable is first assigned — so it has precedence
2. The local variable isn\'t passed to `display_name`, so it can't be accessed by the method

Answer: C. A is incorrect because local variables always take precedence over methods — order of definition/assignment isn't important

### 18.How can `"Lisa"` be printed instead?

```ruby
def name
  "George"
end

name = "Lisa"

def display_name(name)
  puts name() # Calls the name method given the parentheses — so still George
end

display_name(name)
```

```ruby
def name
  "George"
end

def display_name
  name = "Lisa" 
  puts name() # Calls the name method given the parentheses — so still George
end

display_name
```

```ruby
def name
  "George"
end

name = "Lisa"

def display_name(name) # Method can only take in local variables, so Lisa is passed
  puts name
end

display_name(name)
```

Answer: D

### WRONG 19. Why does Ruby reference the local variable instead of invoking the method?

```ruby
name = "Lisa"

def name
  "George"
end

loop do
  puts name
  break
end
```

Local variables have precedence over methods unless you imply that it's a method with parentheses. To call the method, you'd have to edit the loop to imply it's a method with `puts name()`.

Answer: C => wrong due to misconception that variable/method shadowing was possible