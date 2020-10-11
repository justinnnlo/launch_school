How can we initialize a collection?

Array:
- `array = []`
- `array = Array.new`

How are they different?
`array = []` requirs you to explicitly provide the values for the array.

`array = Array.new` allows you to pass an integer parameter to determine its length and a block to determine its value
  - `array = Array.new()` returns `[]` because the parameter's default value is nil
  - `array = Array.new([5, 4, 3])` returns `[5, 4, 3]` because an array is passed as a parameter (this is equivalent to `array = [5, 4, 3]`)
    - Note: this creates a copy of the array passed as a parameter — it is NOT the same object!
  - `array = Array.new(3)` returns `[nil, nil, nil]` because no block is passed
  - `array = Array.new(3) { true }` returns `[true, true, true]` because true is passed
  - `array = Array.new(3) { Hash.new }` returns `[{}, {}, {}]` because a hash initialization is passed
  - `array = Array.new(3) { Array.new(3) }` returns `[[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]` because `Array.new(3)` is passed

To avoid: sending 2 parameters
  - `array = Array.new(3, 0)`
  - `array = Array.new(3, [])` but if `array[0][0] = 5` => `[[5], [5], [5]]`
    - What's going on? In this second case all the elements are storing **the same hash**

Hash
- `hash = { a: "a" }`
- `Hash[a: "a"]`
- `Hash[:a, "a", :b, "b"]`
- `Hash[[a: "a"], [b: "b"]]`
  - Note: invalid with only 1 pair
- `hash = Hash.new`

```ruby
hash = Hash.new
hash[:Dorothy] += 5

hash = Hash.new(0)
hash[:Dorothy] += 5

hash = Hash.new([3])
hash[:Dorothy] += 5
hash[:Dorothy]

hash = Hash.new("Hello!")
hash[:Dorothy]
hash[:Dorothy].upcase!
hash[:Debbie]
hash[:Debbie] = 10
hash.keys
hash.values

# Lesson: use a block to create a new default object each time!

hash = Hash.new { "hi" }
hash[:Dorothy].upcase!
hash[:Debbie]
```