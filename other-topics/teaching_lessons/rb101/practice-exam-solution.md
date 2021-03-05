# Written

What is a variable scope? What types of scopes have we seen so far?

What is a colletion? What types of collections exist? How would you compare and contrast them?

Explain how the inject method works. Give at least one example.

Use inject to find the minimum value of the array `[3, 7, 2, 1, -4, 10]`.

```ruby
[3, 7, 2, 1, -4, 10].inject do |acc, n|
  
end
```

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
      puts num  # 18, 5, 12
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
  value.concat('!') # concat mutates
  value             # "HELLO!"
end

s = 'hello' # "HELLO!"
t = fix(s)  # "HELLO!"
```

```ruby
  value = value.upcase # reassigns parameter to HELLO
  value.concat('!')    # HELLO!
end

s = 'hello'            # "hello"
t = fix(s)             # HELLO!
```

```ruby
def fix(value)
  value << 'xyz'        # "helloxyz"
  value = value.upcase  # Reassigned to: "HELLOXYZ"
  value.concat('!')     # "HELLOXYZ!"
end

s = 'hello'
t = fix(s)              # "HELLOXYZ!"
s                       # => "helloxyz"
```

```ruby
def fix(value)
  value = value.upcase! # Mutates object, and then reassigns it
  value.concat('!')     # Mutates new object
end

s = 'hello'             # HELLO
t = fix(s)              # HELLO!
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

var = test # prints "written assessment" and RETURNS nil

if var # if `nil`
  puts "written assessment"
else
  puts "interview" # returns nil. outputs "interview"
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
  name = 'bob'      # variable shadowing: parameter is reassigned but not the local variable
end

name = 'jim'
change_name(name)
puts name           # "jim"
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
animal = "dog"    # variable initialization and assignment

loop do |animal|  # passes parameter "animal"
  animal = "cat"  # block parameter = "cat", not the local variable
  break           # returns nil
end               # returns nil

puts animal       # outputs "dog", returns nil
```

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

# Copying

```ruby
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase!
end

puts arr1 # ["a", "b", "c"]
puts arr2 # ["A", "B", "C"]
```

# Operator precedence

Why do these 2 blocks have different outputs?

```ruby
array = [1, 2, 3]
p array.map do |num|
  num + 1
end
=> #<Enumerator: [1, 2, 3]:map>

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
  num + 1                     # <Enumerator: [1, 2, 3]:map>
end                           # => <Enumerator: [1, 2, 3]:map>

p(array.map { |num| num + 1}) # [2, 3, 4]
                              # [2, 3, 4]
```

To correct this default behavior, we can extend p's parentheses to the end of the `do...end` block:
```ruby
array = [1, 2, 3]

p(array.map do |num|
  num + 1                     # [2, 3, 4]
end)                          # => [2, 3, 4]
```