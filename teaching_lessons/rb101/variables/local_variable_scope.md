# What do the following code blocks return? What does it output? Why? What concept does it demonstrate?

```ruby
a = ‘Hello’
b = a
a = 'Goodbye'
```

This code illustrates the concept of variables of pointers — that is, that variables act as tags that reference the object they're bounded to.

- In the first line, `a` is assigned to the string "Hello"
- In the second line. `b` is assigned to `a` — and as `a` points to `"Hello"` it means `b` is bounded to that object
- `a` is then reassigned to the string `"Goodbye"` — but note that `Hello`, which `b` still points to, hasn`t been mutated

Thus, at the end `a` points to "Goodbye" and `b` points to "Hello".

```ruby
a = 4

loop do
  a = 5
  b = 3
  break
end

puts a
puts b
```

This code illustrates that local variables can be accessed within a leaky scope if they've been defined outside of it, but inversely a local variable defined within a leaky scope can't be accessed in an outer scope.

- As `a` is initialized and assigned to the integer 4 in the first line it can then be reassigned within the loop and still be value once more outside of it
- Contrarily, as `b` is initialized inside a scope it can't be accessed outside of it
- Thus, `puts a` outputs `5` and returns `nil`, and `puts b` returns an error message because the program is calling an undefined variable

```ruby
a = 4
b = 2

loop do
  c = 3
  a = c # 3
  break
end

puts a  # 3
puts b  # 2
puts c
```

This code illustrates the idea of variables as pointers and stress tests it with variable assignments in inner and outer loops. 

The key idea is shown within the loop: `c` is initialized and assigned to `3`, and `a` is then reassigned to `c`. Yet as `c` points to `3`, it's essentially binding `a` to `3`.

Thus, `puts a` outputs `3` and returns `nil` and `puts b` outputs `2` and returns `nil`

```ruby
def example(str)
  i = 3
  loop do
    puts str
    i -= 1
    break if i == 0
  end
end

example('hello')
```

This code demonstrates the concept of looping.

The last line, which runs `example("hello")`, outputs `"hello"` 3 times and returns `nil`.

This happens because it uses the counter `i` within the method to iterate through a loop 3 times, as in each iteration it decreases by 1 until `i == 0`.

It returns `nil` because `break` returns `nil` unless it is passed a value.

Contrarily, if we wanted the method to return `5` we would need to modify the code to `break 5 if i == 0`.

```ruby
def greetings(str)
  puts str
  puts "Goodbye"
end

word = "Hello"

greetings(word)
```

This code illustrates the concept of side effects within methods.

`greetings` is passed `"Hello"` through the variable `word`, which leads to it outputting 2 lines: `"Hello"` and `"Goodbye"`. It then returns `nil` as that value is returned by `puts`.

**What is a side effect? A side effect is when a method does something else besides returning a value — which can be mutating an object or displaying a value to the output.**

```ruby
arr = [1, 2, 3, 4]

counter = 0
sum = 0

loop do
  sum += arr[counter]
  counter += 1
  break if counter == arr.size
end 

puts "Your total is #{sum}"
```

This illustrates the concept of iterating through a collection to get the sum of all of its elements (as, e.g., inject).

`sum` is reassigned in each iteration to `sum = sum + arr[counter]`, and it coveres all values by increasing the counter by 1 in each iteration.

The iteration avoids an error by breaking when the counter is equal to the number of elements in `arr`

The last line prints to the output "Your total is 10" and returns `nil` because the method is `puts`.

```ruby
a = 'Bob'

5.times do |x|
  a = 'Bill'
end

p a
```

This illustrates i) variable reassignment within an inner scope and ii) passing a `do...end` block to a method.

Within the #times method, `a` is reassigned to `"Bill"` 5 times. This means that 5 different objects with the value "Bill" are created, and `a` is bounded to the last of them.

The last line both prints and returns `"Bill"`. Unlike `puts`, it returns the value of the object passed to it rather than `nil`.

```ruby
animal = "dog"

loop do |_|
  animal = "cat"
  var = "ball"
  break
end

puts animal # outputs "cat", returns `nil`
puts var    # Returns error message
```

This code illustrates variable scope within inner and outer scopes.

As animal is initialized in the outer scope, it can be reassigned within the loop and called by `puts` outside of it (which outputs `cat`). Contrarily, `var` is initialized within the loop so can't be accessed outside of it.

**100% socre in anticipating return and side effect values!**