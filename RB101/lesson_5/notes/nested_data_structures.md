Nested data structures like arrays and hashes have objects within objects. This is fantastic to gather information, but can also get a bit tricky.

# Indexing

Indexing works as always, only with more levels.

`test = [[1,2], 3]` means that there's an array object pointed by variable `test` that has 2 elements: an array `[1, 2]` and an integer `3`.

Indexing works according to the element:

`test = [[1,2], 3]`
- `3` is retrieved with `test[1]`
- `[1,2]` is retrieved with `test[0]`
- `1` is retrieved with `test[0][0]`

`hash = { a: [[1,2], 3], b: { c: "Hello"}, c: "Goodbye" }`
- `3` is retrieved with `hash[:a][1]`
- `[1,2]` is retrieved with `hash[:a][0]`
- `1` is retrieved with `hash[:a][0][0]`
- `{ c: "Hello"}` is retrieved with `hash[:b]`
- `"Hello"` is retrieved with `hash[:b][:c]`
- `"Goodbye` is retrieved with `hash[:c]`
- `"Good"` is retrieved with `hash[:c][0,4]`

# Shallow copy
Shallow copying means creating a new object with the same elements as the original object. This is usually done with the `dup` and `clone` methods.

```ruby
a = [1, 3]
b = "Hello"
array1 = [a, b]
array2 = array1.clone

array1 == array2                     # true
array1.object_id == array2.object_id # false
```

Note that though `array1` and `array2` are different elements, they share the same elements. If we were to mutate the elements in one, it'd affect both.
```ruby
array1[1] = "Goodbye"
array1        # => [[1, 3], "Goodbye"]
array2        # => [[1, 3], "Hello"]

array1[1] = b # => [[1, 3], "Hello"]
array1[1].upcase! # "HELLO"
array1 # => [[1, 3], "HELLO"]
array2 # => [[1, 3], "HELLO"]
```

The main difference between `dup` and `clone` is that `clone` preserves the frozen state of an object — `dup` doesn't.

# Freezing
`freeze` makes an object inmutable. However, it just applies to the object `freeze` is applied to — not any elements within it.

```ruby
a = [1, 3]
b = "Hello"
array1 = [a, b]
array1.freeze

array1 << 5 # => RuntimeError: can't modify frozen String
a << 5      # => [1, 3, 5]

array1      # => [[1, 3, 5], "Hello"]
```

We can check if an object is frozen with `frozen?`. **Frozen objects cannot be unfrozen!** Yet per above, we can use `dup` to work around that.

```ruby
a = [1, 3]
b = "Hello"
array1 = [a, b]
array1.freeze

array2 = array1.clone
array3 = array1.dup

array2 << 5 # => RuntimeError: can't modify frozen String
array3 << 5 # => [[1, 3], "Hello", 5]
```

## Shallow vs deep copies

Deep copies aren't easily done in Ruby — but we should still know how it's different from shallow copies.

In shallow copies, we copy the object but not its nested elements. For example:
```ruby
a = [1, 3]
b = "Hello"
array1 = [a, b]
array2 = array1.clone

array1.object_id == array2.object_id       # false
array1[0].object_id == array2[0].object_id # true
array1[1].object_id == array2[1].object_id # true
```
Notice how the array objects are different, but there elements are the same.

A deep copy also creates a distinct copy of the elements nested withing an object:
```ruby
a = [1, 3]
b = "Hello"
array1 = [a, b]
array2 = array1.clone
array2[0] = array1[0].clone
array2[1] = array1[1].clone

array1 == array2                           # true
array1.object_id == array2.object_id       # false
array1[0].object_id == array2[0].object_id # false
array1[1].object_id == array2[1].object_id # false
```
This second example is a deep copy because we copied every single element in the array — now all the elements (barring the integers) are different!