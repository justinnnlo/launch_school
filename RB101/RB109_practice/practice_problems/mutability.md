```ruby
def fix(value)
  value.upcase!
  value.concat('!') # concat mutates
  value             # "HELLO!"
end

s = 'hello' # "HELLO!"
t = fix(s)  # "HELLO!"
```

This shows how methods that mutate an object change its value outside of the method.

```ruby
def fix(value)
  value = value.upcase # reassigns parameter to HELLO
  value.concat('!')    # HELLO!
end

s = 'hello'            # "hello"
t = fix(s)             # HELLO!
```

This shows how if a method parameter is reassigned it cannot mutate the object it was originally passed.

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

s is mutated in the first line of the method, but is not affected by the following 2 lines because the method parameter was reassigned — which binded it with a new object.

# Important lesson below: assignment doesn't create objects by default

```ruby
def fix(value)
  value = value.upcase! # Mutates object, and then reassigns it
  value.concat('!')     # Mutates new object
end

s = 'hello'             # HELLO
t = fix(s)              # HELLO!
```

**Key lesson**: when an object is mutated and its return value assigned to an object, it's returning the same object id as before!

`value = value.upcase!` modifies a previous one and reassigns the same parameter to the same object, but a new object isn't created by default with an assignment!

```ruby
def fix(value)
 value[1] = 'x' # "axc"
 value          # "axc"
end

s = 'abc'
t = fix(s)     # "axc"
s              # "axc"
```

Reassigning an element of a collection mutates the object, it doesn't create a new one and bind it to the variable.

```ruby
def a_method(string)
  string << ' world'
end

a = 'hello'
a_method(a) # "hello world"

p a # both outputs AND returns "hello world"
```

```ruby
num = 3

num = 2 * num
```

Standard variable reassignment

```ruby
a = %w(a b c)
a[1] = '-'
p a           # Outputs and returns ["a", "-", "c"]
```

```ruby
def add_name(arr, name)
  arr = arr + [name]    # Reassigns the parameter to a new object created from arr + [name]
end

names = ['bob', 'kim']
add_name(names, 'jim')  # ["bob", "kim", "jim"]
puts names              # ["bob", "kim"]
```

**Note**: puts returns each element of an array in its own line while p returns the entire array in a single line

```ruby
def add_name(arr, name)
  arr = arr << name     # arr << name mutates the object and binds the resulting (same object) to the parameter
end

names = ['bob', 'kim']
add_name(names, 'jim')  # ["bob", "kim", "jim"]
puts names              # ["bob", "kim", "jim"]
```

