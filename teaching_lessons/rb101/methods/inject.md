Inject is one of the important methods in Ruby and OOP because we can use it to add elements.

# Under the hood

Inject works with 2 parameters: the accelerator and the current element.

The accelerator can change over time, depending on the block.

```ruby
(5..10).inject { |acc, num| acc + num }
# => 45
```

What happens in the above example?

- Starting accelerator: as no number is passed to inject, by default it's the first number of the collection (5)
- Block: it adds the accelerator and the current number (e.g. `5 + 6` in the first iteration) and returns the product
- The accelerator changes its value to the value returned by the block in each iteration
  - Iteration 0: 5
  - Iteration 1: 5 + 6 = 11
  - Iteration 2: 11 + 7 = 18
  - Iteration 3: 18 + 8 = 26
  - Iteration 4: 26 + 9 = 35
  - Iteration 5: 35 + 10 = 45
- `inject` returns the value returned by the fifth iteration — 45

We can do the above but with the starting accelerator as 0
```ruby
(5..10).inject(0) { |acc, num| acc + num }
# => 45
```

Why is the above value also 45? Because we had an additional iteration. We can verify this through a side effect.
```ruby
(5..10).inject(0) do |acc, num|
  puts "Acc is #{acc}, Num is #{num}"
  acc + num
end

(5..10).inject do |acc, num|
  puts "Acc is #{acc}, Num is #{num}"
  acc + num
end
```
As per above, the version that passes 0 to inject has an additional iteration where the accelerator is 0 and the number is 5.

However, that doesn't have to be the case:
```ruby
(5..10).inject(5) { |acc, num| acc + num }
# => 50
```

# `inject` beyond sums
The accelerator is a counter, and we can use it as flexibly.

For example, for finding the minimum value:
```ruby
(5..10).inject do |acc, num|
  if acc > num
    num
  else
    acc
  end
end
# => 5

[11, 45, 7456, 23, 3, 45, 95].inject do |acc, num|
  if acc > num
    num
  else
    acc
  end
end

# Comparison using ASCII characters
["awld", "Ede", "dko"].inject do |acc, num|
  if acc > num
    num
  else
    acc
  end
end
```
Being able to set the accelerator is necessary for doing things like adding all the even numbers in a collection.
```ruby
[11, 45, 7456, 23, 3, 45, 95].inject do |acc, num|
  if num.even?
    acc + num
  else
    acc
  end
end # => 7467

[11, 45, 7456, 23, 3, 45, 95].inject(0) do |acc, num|
  if num.even?
    acc + num
  else
    acc
  end
end # => 7456
``à