```ruby
a = 4
b = 2

2.times do |a|
  a = 5
  puts a
end

puts a
puts b
```

This code block illustrates the concept of variable shadowing: when 2 variables have the same name.

It starts by initializing and assinging `a` and `b`.
Within #times the `do...end` block uses the parameter `a`, which is assigned to the current iteration of times
  - First iteration
    - a = 1
    - a is reassigned to 5
    - 5 is printed
  - Second iteration
    - a = 2
    - a is reassigned to 5
    - 5 is printed
  - #times returns the integer that invoked the method — in this case `2`
Yet outside the method, a is still `4` because of the shadowing that happened inside.
So `puts a` outputs `4` and returns `nil` and `puts b` returns 2


It then reassigns `a` twice to `5`, and passes `a` to puts twice. This, `5` is printed twice to the output.
It then prints `5` once more given a third `puts a` and then outputs `2` given `puts b`.
In all the puts, it returns `nil` as it always does.

**I missed 2 things**: looking out for the shadowing (parameter of #times) and that #times returns the integer that calls it.

```ruby
n = 10         # variable initialization and assignment

1.times do |n| # iterates once
  n = 11       # returns 11
end            # block returns 1

puts n         # outputs 10, returns nil
```

This example shows that when the parameter of a `do...end` block has the same value as a local variable, the variable will not be accessible within the block.

```ruby
animal = "dog"    # variable initialization and assignment

loop do |animal|  # passes parameter "animal"
  animal = "cat"  # block parameter = "cat", not the local variable
  break           # returns nil
end               # returns nil

puts animal       # outputs "dog", returns nil
```

This example shows that when the parameter of a `do...end` block has the same value as a local variable, the variable will not be accessible within the block.