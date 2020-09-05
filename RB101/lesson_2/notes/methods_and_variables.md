Out purpose is to better understand the nuances and precedence around methods vs variables. To do so, we'll purposefully use the same name for both to stress test them.

1. Variables have precedence over methods

```ruby
def test
  "George"
end

test = "Lisa"

puts test # Lisa
```

2. ... irrespective of the order in which the method and variable are defined

```ruby
test = "Lisa" # Switch order

def test
  "George"
end

puts test # Lisa
```

3. But using parentheses makes it explicit we want a method

```ruby
def test
  "George"
end

test = "Lisa"

puts test() # George
```
