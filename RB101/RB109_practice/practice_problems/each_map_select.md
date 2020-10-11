```ruby
array = [1, 2, 3, 4, 5]

array.select do |num|
   puts num if num.odd?
end
```
Outputs: 1, 3, 5
Returns: []

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

arr.select { |n| n.odd? }
```

Returns: [1, 3, 5, 7, 9]

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

new_array = arr.select do |n| 
  n + 1
end
p new_array
```

`n + 1` is truthy — it's evaluated as the block as `true`. Thus, it selects every element in arr. This means that new_array is a new object with the same values as arr.

p new_array thus both outputs and returns `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`.

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

new_array = arr.select do |n| 
  n + 1
  puts n
end
p new_array
```

As puts returns nil, the block always evaluates to false and thus no element is selected. new_array is binded to [] and `p new_array` outputs and prints [].

```ruby
words = %w(jump trip laugh run talk)

new_array = words.map do |word|
  word.start_with?("t")
end

p new_array
```

map transforms the calling object and creates a new array from the value returned by the block in each iteration. As #start_with? returns a boolean, the new array has as elements a Boolean object. Thus, new_array is `[false, true, false, false, true]`

**Note**: booleans are ALWAYS lowercase. `True` or `False` meansa constant called `True` or `False`

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

arr.each { |n| puts n }
```

Returns: `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`
Prints: Each element of the array (ie 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

incremented = arr.map do |n| 
            n + 1
            end
p incremented
```

Prints and returns `[2, 3, 4, 5, 6, 7, 8, 9, 10, 11]`

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

new_array = arr.map do |n| 
  n > 1
end
p new_array
```

Prints and returns: `[false, true, true, true, true, true, true, true, true, true]`

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

new_array = arr.map do |n| 
  n > 1       # Prints: 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
  puts n      # returns nil
end           # assignment returns [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
p new_array
```

Prints and outputs: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]

```ruby
a = "hello"

[1, 2, 3].map { |num| a }
```
Returns: ["hello", "hello", "hello"]


```ruby
[1, 2, 3].each do |num|
  puts num
end
```

Prints: 1, 2, 3
Every block returns: nil
Each returns: [1, 2, 3]