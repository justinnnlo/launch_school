# What are collections?

Colletions are structured containers for storing data. They're **lists of data**. In Ruby the most common ones are `String`, `Array` and `Hash`.

Collections are structured from individual elements
  - In `"hello"` there are 5 individual elements
  - In `[1, 2, 3]` there are 3 individual elements
  - In {a: "hi"} there's 1 individual element (the key-value pair)

Conversely, integers aren't containers because they cannot store more than one element per object. `23` or any other integer or float is a single element — you can't group them without using a hash or array.

# String and Array element reference

Strings and arrays use an integer-based element reference system, with 0 as the base index (ie, the first element). Each element has a corresponding index, which we can use for an assortment of tasks.

Thus, both strings and arrays are ordered collections. The index corresponds to a specific element in a specific place, which can be referenced via its index.

## Nuances with `Array#slice` and `String#slice`

While these methods provide the same basic functionality, the key distinction is that the first returns and array and the latter a string.

The exception is when we slice a single element in an array, which returns the element itself (with its standard class).

```ruby
arr = [1, 2, "hi"]
arr[0, 2] # => [1, 2]
arr[1,100] # => [2, "hi"]
arr[2,100] # => ["hi"]
arr[0, 2][0] # => 1 => class Integer
```

# Hash element reference

The key distinction with hashes are that they have an unordered structure. Rather, they use a system of **unique** keys to sort and store its values, which do not have to be unique.

- Nuance: as the keys have to be unique, if there are duplicate keys the one closest to the ending bracket will be used to override the other ones.

```ruby
hsh = { :fruit => "apple", :fruit => "pear", :fruit => "pineapple"} # => { :fruit => pineapple }
```

Also unlike arrays and strings, this key reference system can use any data type. However, it's typically a symbol because it's inmutable — which helps avoid issues with losing the key.

The values themselves, once referenced, use their native element reference system (if applicable).

```ruby
hsh = { 'fruit' => 'apple', 'vegetable' => 'carrot' }

hsh["fruit"] # => "apple"
hsh["fruit"][0] # => "f"
```

# Things to look out for

## Out of bounds slicing


Difference between `[]` and `#fetch`

### Strings and arrays

If you reference an index outside of the boundary of string or array, it returns `nil`. This can be an issue when working with conditionals.

This is especially problematic for arrays, which can store `nil` values.

```ruby
arr = [0, 1, nil]
arr[2] # nil
arr[3] # nil
```

This is also applicable when working with negative indices.

```ruby
arr = [0, 1, nil]
arr[-1] # nil
arr[-2] # 1
```

To avoid this problem, we can use `Array#fetch`. This method returns `IndexError` if it references an index outside of an array's boundary.

```ruby
arr = [0, 1, nil]
arr.fetch(2) # => nil
arr.fetch(3) # => IndexError: index 3 outside of array bounds: -3...3
             #        from (irb):3:in `fetch'
             #        from (irb):3
             #        from /usr/bin/irb:11:in `<main>'
```

However, its downside is that while it's great for indexing it doesn't work for slicing

```ruby
arr = [0, 1, nil]
arr.fetch(0,2) # => 0
```

### Hashes

Like arrays, an invalid hash key returns `nil`. Using fetch helps us distinguish between a value `nil` and a `KeyError`.

```ruby
hsh = { :a => 1, 'b' => 'two', :c => nil }

hsh['b']       # => "two"
hsh[:c]        # => nil
hsh['c']       # => nil
hsh[:d]        # => nil

hsh.fetch(:c)  # => nil
hsh.fetch('c') # => KeyError: key not found: "c"
               #        from (irb):2:in `fetch'
               #        from (irb):2
               #        from /usr/bin/irb:11:in `<main>'
hsh.fetch(:d)  # => KeyError: key not found: :d
               #        from (irb):3:in `fetch'
               #        from (irb):3
               #        from /usr/bin/irb:11:in `<main>'
```

**Conclusion**: use `Array#fetch` to select individual elements from arrays!

# Conversion between data types

Strings and arrays can convert between each easily because of the shared element reference system.

Some of the relevant methods include:
- String
  - `String#chars`: split a string into an array by each character
  - `String#split`: split a string into an array by a preferred element (default: whitespace)
- Array
  - `Array#join`: concatenate an array into a string with an element (default: none)
  - `Array#+` with `Array#[]`

Conversions can also happen between arrays and hashes with the `Array#to_h` and `Hash#to_a` methods.

```ruby
arr = [[:name, "Jose"], [:age, 24]]
hsh = arr.to_h # { :name => "Jose", :age => 24 }
hsh.to_a # [[:name, "Jose"], [:age, 24]]
```