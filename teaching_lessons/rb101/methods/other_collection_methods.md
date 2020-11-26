```ruby
[1, 2, 3].any? do |num|
  num > 2
end
```

Method returns true and prints nothing

```ruby
{ a: "ant", b: "bear", c: "cat" }.any? do |key, value|
  value.size > 4
end
```

Method returns false

```ruby
[1, 2, 3].all? do |num|
  num > 2
end
```

Method returns false as 1 > 2 == false and 2 > 2 == false

```ruby
{ a: "ant", b: "bear", c: "cat" }.all? do |key, value|
  value.length >= 3
end
```

Method returns true

```ruby
[1, 2, 3].each_with_index do |num, index|
  puts "The index of #{num} is #{index}."
end
```

Prints
  - "The index of 1 is 0"
  - "The index of 2 is 1"
  - "The index of 3 is 2"
Returns: [1, 2, 3]

```ruby
{ a: "ant", b: "bear", c: "cat" }.each_with_object([]) do |(key, value), array|
  array << value
end

{ a: "ant", b: "bear", c: "cat" }.each_with_object([]) do |pair, array|
  array << pair.last
end
```

Returns: ["t", "r", "t"] — WRONG

**CRITICAL**: hashes are turned into arrays when passed as a pair to each_with_object — [key, value]

Thus, array << pair.last is equivalent to array << value.

By extension, the 2 variations above are equivalent!

```ruby
{ a: "ant", b: "bear", c: "cat" }.each_with_object({}) do |(key, value), hash|
  hash[value] = key
end
```

{ "ant" => :a, "bear" => :b, "car" => :c }

This is because the new object is returned by the method.

```ruby
odd, even = [1, 2, 3].partition do |num|
  num.odd?
end

p odd   # [1, 3]
p even  # [2]
```