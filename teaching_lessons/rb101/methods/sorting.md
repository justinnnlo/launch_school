What is sorting?
What data types would you typically like to sort? Which ones would you typically not need to?
What's the data type returned by `Enumerable#sort` and `Enumerable#sort_by`? => Array!
What's the difference between `Enumerable#sort` and `Enumerable#sort_by`?
  - Reply: sort_by *requires* a block to be passed to the method
How does #sort work under the hood (tip: <=>/spaceship operator which returns -1, 0, 1 or nil)
  - What does each of the 4 values mean? What happens with a 0?
  - How does the spaceship operator know what's greater or less then? => ASCII
  - Work on live examples without running the code
  - Examples:
    - `["1", "hi", "!", "45"].sort`
    - `[1, 2, "three"].sort`
    - `[1, 2, 3].sort`
    - `[1, 2, { 3 => "three"}].sort`


Exercises

```ruby

['arc', 'bat', 'cape', 'ants', 'cap'].sort

['arc', 'bat', 'cape', 'ants', 'cap', 5].sort { |a, b| a[0..-1] <=> b[0..-1] }

# Lesson: only the same data types
['arc', 'bat', 'cape', 'ants', 'cap', 5].sort



# Lesson: even with nested arrays
[['a', 'cat', 'b', 'c'], [2, 'b'], [3, 'a', 'car', 'd'], ['a', 'car', 'd']].sort

# Lesson: #sort short circuits
[['a', 'cat', 'b', 'c'], ['b', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort

# Lesson: Enumerable#sort only compares the elements that are passed to it!
arr = %w(array fudge marriachi lucuma senor)
arr.sort { |a, b| b[1] <=> a[1] }
arr.sort { |a, b| a[1] <=> b[1] }
arr.sort { |a, b| b[1..-1] <=> a[1..-1] }
arr.sort { |a, b| a[1..1] <=> b[1..1] }

# Question: how can we sort things by their 2nd character?
arr.sort_by { |word| word[1..-1] }
```



# What is sorting?

Sorting is setting the order of a collection according to a specified criteria.

## Sorting and collection types

Hashes can be sorted, but there usually isn't a need as they can be accessed via their keys.

Arrays are the most common type to be sorted. Strings can also be sorted, though it's typically by converting them to an array.

# Methods to sort

Arrays have 2 useful sorting methods: `Array#sort` and `Array#sort_by`.

`Array#sort` does not mutate the array. If needed, `.sort!` does the trick.

By default, `.sort` returns the array sorted from smallest to largest, be it numbers or non-neumeric characters.

Key nuance: while we can mix "1" with "a", we can't sort an array that has different element types — which includes sorting an array with string and integer elements.

# Sorting: under the hood

`Array#sort` uses the `<=>` operator. This operator compares 2 objects and returns one of 3 results: 1 if the element to the left should go before, -1 if the element to the right should go before, 0 if the elements have the same value and `nil` if the elements cannot be compared (ie, are different types).

## Character positioning: under the hood

How does `<=>` knows the relative positioning of an element? It does so via ASCII characters.

For example:
```ruby
["!", " ", "`", "*", "Z"].sort
=> [" ", "!", "*", "Z", "`"]
```

Something to keep in mind is that numbers come before uppercase letters which come before lowercase letters.

### Other comparison methods

`sort` isn't the only method that uses `<=>` under the hood. Others include:
- min
- max
- minmax
- min_by
- max_by
- minmax_by

# Blocks and `sort`
We can pass a block with 2 arguments to `sort`. Take in mind that `sort` will look for the block to return one of 3 values: -1, 1, 0 or nil.

```ruby
# Standard sort: low to high
[1,5,3,2,7,8].sort do |a, b|
  a <=> b
end # [1, 2, 3, 5, 7, 8]

# Blocks can have other code as long as it returns -1, 1 or nil...
[1,5,3,2,7,8].sort do |a, b|
  puts "#{a} vs #{b}"
  a <=> b
end # [1, 2, 3, 5, 7, 8]

# ...or it'll return an Argument Error
[1,5,3,2,7,8].sort do |a, b|
  a <=> b
  puts "#{a} vs #{b}"
end # ArgumentError: comparison of String with String failed

# reverse sort: high to low
[1,5,3,2,7,8].sort do |a, b|
  b <=> a
end # [8, 7, 5, 3, 2, 1]
```

# String comparison
Strings are compared character by character. Thus, having less characters is better than having more and characters are analyzed until a difference is set.
```ruby
['arc', 'bat', 'cape', 'ants', 'cap'].sort
# => ["ants", "arc", "bat", "cap", "cape"]
```

# Sorting arrays with subarrays

```ruby
[['a', 'cat', 'b', 'c'], ['b', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort
# => nil because there are 2 integers while the others are string elements
# The above is wrong because sort never compares the integers to strings — sort short-circuits before that

# Correct answer:
# => [['a', 'cat', 'b', 'c'], ['a', 'car', 'd', 3], ['a', 'car', 'd'], ['b', 2]]
```

# sort_by

`sort_by` allows us to choose what we'll sort a collection by. For an array, it could be the index number. For a hash, it could be the value.

Note that `Hash#sort_by` returns an array!

```ruby
# When the block returns 0, it uses the order in the array to sort them independently of its other characters
["sox", "cats", "rats"].sort { |word| word[1] } # => ["cats", "rats", "sox"]
["sox", "rats", "cats"].sort { |word| word[1] } # => ["rats", "cats", "sox"]

# `sort_by` doesn't evaluate any other character besides `word[1]`
["sox", "cats", "rate"].sort { |word| word[1] } # => ["cats", "rate", "sox"]

# Strings not seprated by commas will be concatenated
["sox", "cats" "rats"].sort { |word| word[1] } # => ["catsrats", "sox"]

# Hash#sort_by the hashs' value
people = { Kate: 27, john: 25, Mike:  18 }

people.sort_by { |_, age| age } # Sort by age/value and return an array
# => [[:Mike => 18], [:john => 25], [:Kate => 27]]

people.sort_by { |_, age| age }.to_h # Sort and return a hash
# => { :Mike => 18, :john => 25, :Kate => 27 }

# Hash#sort_by the hashs' key and return a hash
people.sort_by { |name, _| name }.to_h # Note :john is downcase!
# => {:Kate=>27, :Mike=>18, :john=>25}

people.sort_by { |name, _| name.capitalize }.to_h # capitalizes every key
# => {:John=>25, :Kate=>27, :Mike=>18}
```