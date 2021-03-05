```ruby
a = "Hello"

if a
  puts "Hello is truthy"
else
  puts "Hello is falsey"
end
```

`if a` with always evaluate to true because any object except `nil` and `false` are truthy, which means that in a conditional will evaluate to true.

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

NOTE: when a variable is assigned to a method, it really means that the variable is assigned to the RESULT of the method