# Written

What is a variable scope? What types of scopes have we seen so far?

What is a colletion? What types of collections exist? How would you compare and contrast them?

Explain how the inject method works. Give at least one example.

Use inject to find the minimum value of the array `[3, 7, 2, 1, -4, 10]`.

# Blocks
```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end
```

```ruby
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end
```

```ruby
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]
arr.sort
```

# Mutability
```ruby
def fix(value)
  value.upcase!
  value.concat('!')
  value
end

s = 'hello'
t = fix(s)
```

```ruby
  value = value.upcase
  value.concat('!')
end

s = 'hello'
t = fix(s)
```

```ruby
def fix(value)
  value << 'xyz'
  value = value.upcase
  value.concat('!')
end

s = 'hello'
t = fix(s)
s
```

```ruby
def fix(value)
  value = value.upcase!
  value.concat('!')
end

s = 'hello'
t = fix(s)
```

# Truthiness

```ruby
a = "Hello"

if a
  puts "Hello is truthy"
else
  puts "Hello is falsey"
end
```

```ruby
def test
  puts "written assessment"
end

var = test

if var
  puts "written assessment"
else
  puts "interview"
end
```

# Variable scoping, pointers, shadowing

```ruby
a = "hi there"
b = a
a = "not here"
b
```

```ruby
p a = "hi there"
p b = a
p a << ", Bob"
p b
```

```ruby
def change_name(name)
  name = 'bob'     not the local variable
end

name = 'jim'
change_name(name)
puts name
```

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

```ruby
animal = "dog"

loop do |animal|
  animal = "cat"
  break
end

puts animal
```

```ruby
a = 4
b = 2

loop do
  c = 3
  a = c
  break
end

puts a
puts b
puts c
```

# Copying

```ruby
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase!
end

puts arr1
puts arr2
```

# Operator precedence

Why do these 2 blocks have different outputs?

```ruby
array = [1, 2, 3]
p array.map do |num|
  num + 1
end
=>

p array.map { |num| num + 1 }
=> [2, 3, 4]
```

The first expression is like saying `p array.map` and the second `p [2, 3, 4]`.

A method binds more tightly to its argument than a method call with its `do...end` block.

But inversely, a method binds less tightly to its argument than a method call with its `{}` block.

This can be visualized as:

```ruby
array = [1, 2, 3]

p(array.map) do |num|
  num + 1
end

p(array.map { |num| num + 1})
```

To correct this default behavior, we can extend p's parentheses to the end of the `do...end` block:
```ruby
array = [1, 2, 3]

p(array.map do |num|
  num + 1
end)
```