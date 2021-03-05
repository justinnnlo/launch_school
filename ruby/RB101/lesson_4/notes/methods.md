# `each`

This method iterates through a collection and **returns the object that was passed to it**. By passing a block to the method invocation we can perform actions as we iterate, which can both mutate the object or not.

The block runs in every iteration. The number of iterations equals the number of elements in the collection.

Within a block, we can use arguments to manipulate the data in collections. For arrays and strings, we only need a single argument to manipulate the current object. In contrast, hashes need 2 different ones — for both key and value.xz

# `select`

Returns a new collection with the elements selected, based on the given criteria in the block, from the collection passed to it.

`select` only cares about the "truthiness" of an expression. For example, if we pass `num + 1`, where num represents the element of a collection of integers in an array, it will return a new array with all elements where `num + 1` evaluates to `true`.

Nuance: what's sent to the new block is the last evaluated expression

```ruby
[1, 2, 3].select do |num|
  num + 1
end # => [1, 2, 3]

[1, 2, 3].select do |num|
  num + 1
  puts num
end # => []
```

# `map`

`map` creates a new collection based on its transformation of the collection elements.

# `any?`, `all?`, `none?`

These return a boolean value. Interestingly, they can be ued with hashes:

```ruby
{ a: "ant", b: "bear", c: "cat" }.any? do |key, value|
  value.size > 4
end
# => false
```