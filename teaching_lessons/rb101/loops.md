# What are loops?

Loops are Ruby constructs that execute the code within them until the loop is broken. At the end of a loop, if it isn't broken it'll continue execution at the top of the loop.

## What loop constructs do we have available?

- `loop`: need an explicit `break` to stop
- `while`
- `until`

## Loop and return values

`break` has a default return value of `nil` but can return another value if passed as an argument.

```ruby
loop do
  break
end     # => nil

loop do
  break 5
end     # => 5
```

`while` and `until` return `nil` by default
```ruby
while x > 5
  x -= 1
end # => nil

until x >= 10
  x += 1
end # => nil
```

But we can also use `break` statements in them
```ruby
x = 10

while x > 5
  x -= 1
  break x
end # => 9
```

## Loops and variable scoping

**Loops create a leaky scope** — they're part of the general program execution. Thus, they belong to the same scope as whereever they're located.

```ruby

loop do
  x = 5
  break
end

x # 5

while true
  y = 10
  break
end

y # NameError
```

**Are `for` statements loops? If not, what are they — statements comparable to `if` and `case`? Iterators comparable to `each`?**
