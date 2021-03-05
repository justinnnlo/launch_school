# What is a closure?

A closure is a chunk of code that meets 3 criteria:
1. It can be passed around as a value
2. It can be executed **on demand** by anyone who has that value
3. It can refer to variables from the context/environment/binding in which it was created

Though a closure can be passed around as a value, Ruby's limitation is that you can only pass one block at a time to a method — not multiple, unlike other languages.

```ruby
# Passing blocks implicitly: can't take more than 1 block
def my_method
  yield
end

my_method { puts "hi" } { puts "there" }  # SyntaxError

# Passing blocks explicitly: can't take more than 1 ampersand parameter
def my_method(&block1, &block2)
  block1.call
  block2.call
end

my_method { puts "hi" } { puts "there" }  # SyntaxError
```
The only way to pass blocks as values is via procs — either by explicitly creating a proc object or using `&` in the method definition.

## Closure and closure-lile constructs

`Proc` objects are called explicitly via `Proc#call` methods (though can also be called implicitly with `yield`, but this doesn't work with multiple `Proc` objects).

Constructs that can execute a block of code with `#call` include procs, lambdas, and methods

  ```ruby
  proc { puts "I'm declared with proc." }.call     # "I'm declared with proc."
  Proc.new { puts "I'm declared with proc." }.call # "I'm also declared with proc."
  lambda { puts "I'm declared with lambda." }.call # "I'm declared with lambda."

  def some_method
    puts "I'm declared as a method."
  end

  method(:some_method).call                        # "I'm declared as a method."
  method(:some_method).class                       # Method — because they're also objects!
  ```

This implies we have 4 closure-like constructs
1. Blocks
2. Procs
3. Lambda
4. Method

# Binding

Binding what allows the closure to be aware of its context.

This allows it to refer to variables from the context when it was defined regardless of the closure's current scope.
```ruby
def thrice
  yield
  yield
  yield
end

x = 0
puts "The value of x is #{x}" # 0
thrice { x += 1 }             # Calling x from a self-contained scope
puts "The value of x is #{x}" # 3
```

A closure's environment refers to the variables defined in the scope the closure was created, not the scope it's called in.
```ruby
def thrice
  x = 100
  yield
  yield
  yield
  puts "Value of x at the end of thrice: #{x}"
end

x = 0
puts "The value of x is #{x}" # 0
thrice { x += 1 }             # Calling x from a self-contained scope
puts "The value of x is #{x}" # 3
```

The implication is that a closure can only refer to variables that were initialized when the closure was created — it can't refer to variables created after it.
```ruby
def my_method
  x = 10
  yield
end

my_method { puts x }  # NameError
```

Inversely, since a block is a leaky scope though it can initalize variables they won't be accessible outside of its scope.
```ruby

def my_method
  yield
end

my_method do
  y = 10
  puts "y was intialized within the block!" if defined? y
end

puts "But y isn't available at a higher scope than the scope it was initialized in" unless defined? y
```

