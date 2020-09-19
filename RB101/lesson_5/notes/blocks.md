```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end
```

| Line | Action | Object | Side effect | Return value | Return value used?
|------|--------|--------|-------------|--------------|--------------|
| 1 | Method call `map` | Outer array | None | New array `[1, 3]` | No |
| 1-4 | Block execution | Each inner array | None | Element at index 0 of each inner array | Yes, passed into `map` |
| 2 | Method call `first` | Each inner array | No | Element at index 0 of each inner array | Yes, passed to `puts` |
| 2 | Method call `puts` | Element at index 0 of each inner array | Prints string outputs `1`, `3` | `nil` | No |
| 3 | Method call `first` | Each inner array | None | Element at index 0 of each inner array |Yes, return value of blocks and sent to `map` |

```ruby
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num  # 18, 5, 12
    end
  end
end             # => [[18, 7], [3, 12]]
```
| Line | Action | Object | Side effect | Return value | Return value used?
|------|--------|--------|-------------|--------------|--------------|
| 1 | Variable assignment | N/A | None | Value bounded to `my_arr` | No |
| 1 | Method call `each` | Outer array | None | Same object that invokes the method — the outer array | Yes, in the variable assignment |
| 1-7 | Outer block execution | Inner arrays | None | Each subarray  | No |
| 2 | Method call `each` | Each inner array | None | Each inner array | No |
| 2-6 | Inner block execution | Each subarray element | None | Each subarray  | No |
| 3 | `num > 5` comparison | Element of a subarray in that iteration | No | Boolean | No |
| 3-5 | `if` statement | Boolean | No | `nil` | Yes, pass it to the inner block |
| 4 | `puts` method call | Each subarray element > 5 | Outputs the integer | `nil` | Yes, passes it to `if` which passes to inner block |

```ruby
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2 # 2, 4, 6, 8
  end       # [2, 4], [6, 8]
end         # [[2, 4], [6, 8]]
```
| Line | Action | Object | Side effect | Return value | Return value used?
|------|--------|--------|-------------|--------------|--------------|
| 1 | `map` invocation | Outer array | None | New array created by the method result | No |
| 1-5 | Block execution | Inner arrays | None | New inner arrays created by the inner block | Yes, as arguments passed to map |
| 2 | `map` invocation | The inner array of the iteration | None | New array created by the method result | Yes, passed to the outer `map` method |
| 2-4 | Block execution | Elements of inner array in current iteration | None | New elements passed to the new inner arrays | Yes, as elements passed to their respective inner arrays |
| 3 | `*` method invocation with `2` as an argument | Elements in current iteration | None | Current element * 2 | Yes, passed to the block |

```ruby
[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s # Converts symbol sto string!
  end
end
# => [{ :c => "cat" }]
```
| Line | Action | Object | Side effect | Return value | Return value used?
|------|--------|--------|-------------|--------------|--------------|
| 1 | `select` invocation | Array | None | New array created by the method result with the elements that meet the selection criteria | No |
| 1-5 | Block execution | Array elements in the current iteration | None | Boolean | Yes, as argument passed to select |
| 2 | `all?` invocation | The hash of the iteration | None | Boolean | Yes, passed to the outer block |
| 2-4 | Block execution | Key-value pair in current iteration | None | Boolean | Yes, as argument for `all?` method |
| 3 | `==` method invocation with `key.to_s` as argument | `value[0]` | None | Boolean | Yes, passed to the inner block |

## Key idea: string sorting
```ruby
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]
arr.sort
# => [['1', '8', '9'], ['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15']] => WRONG!
# => [['1', '8', '11'], ['1', '8', '9'], ['2', '12', '15'], ['2', '6', '13']]
```

Why does `['1', '8', '11']` come before `['1', '8', '9']`? The trick here is that the numbers as evaluated as strings. Thus, they're evaluated character by character. So when comparing their third element, it compares `"1"<=>"9"` rather than `11<=>9`.

To sort it "correctly", we need to transform the inputs into integers and then sort them.
```ruby
arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end # => [['1', '8', '9'], ['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15']]
```

Why are the elements strings and not integers? The trick is that we are passing to `sort_by` an array of integer elements, each of which is associated with a corresponding string element. The sorting comparison is done on the integers, but the result is on the strings.

This is another example of the same functionality:
```ruby
arr = %w(array fudge marriachi lucuma senor)
arr.sort_by { |word| word[1] }
# => ["marriachi", "senor", "array", "fudge", "lucuma"]
# NOTE: this is an edge case. "fudge" should be AFTER "lucuma"
```
What happened was that we passed as arguments the 2nd character of each string to be used as comparison, though the array that was returned was with the original strings.

However, if we want to make an inverse sort we'd need to use the 2 arguments used when `#sort` is passed a block.
```ruby
# Inverse sort using index 1 as the comparison
arr = %w(array fudge marriachi lucuma senor)
arr.sort { |a, b| b[1] <=> a[1] }
# => ["fudge", "lucuma", "array", "senor", "marriachi"]
```

```ruby
[[8, 13, 27], ['apple', 'banana', 'cantaloupe']].map do |arr|
  arr.select do |item|
    if item.to_s.to_i == item    # if it's an integer
      item > 13
    else
      item.size < 6
    end
  end
end
```

| Line | Action | Object | Side effect | Return value | Return value used?
|------|--------|--------|-------------|--------------|--------------|
| 1 | `map` invocation | Outer array | None | New array created by the block execution | No |
| 1-9 | Outer block execution | Array element in the current iteration | None | A new array object for each element | Yes, as arguments passed to `map` |
| 2 | `select` invocation | Subarray of the iteration | None | New subarray | Yes, passed to the block execution |
| 2-8 | Inner block execution | Subarray element in the current iteration | None | Selected objects | Yes, as arguments for `select` method |
| 3-7 | `if` statement | Boolean | None | Boolean | Yes, passed to the `select` method |
| 3 | `==` operator with `item` argument | `item.to_s.to_i` | None | Boolean | Yes, passed to `if` statement |
| 4 | `>` operator with `13` as an argument | `item` | None | Boolean | Yes, passed to `if` statement which then returns to `select` |
| 5 | `else` statement | N/A | None | N/A | N/A |
| 6 | `<` operator with `6` as an argument | `item.size` | None | Boolean | Yes, passed to `if` statement which then returns to `select` |

```ruby
[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]].map do |element1|
  element1.each do |element2|
    element2.partition do |element3|
      element3.size > 0
    end
  end
end
# => [[[1], [2], [3], [4]], [['a'], ['b'], ['c']]]

# if `each` were another `map` => [[[[1], []], [[2], []], [[3], []], [[4], []]], [[["a"], []], [["b"], []], [["c"], []]]]
```
| Line | Action | Object | Side effect | Return value | Return value used?
|------|--------|--------|-------------|--------------|--------------|
| 1 | `map` invocation | Outer array | None | New array created by the block execution | No |
| 1-7 | Outer block execution | Array element in the current iteration | None | A new array object for each element | Yes, as arguments passed to `map` |
| 2 | `each` invocation | Inner array 1 in current iteration | None | Inner array 1 in current iteration | No |
| 2-6 | Inner block 1 execution | Array element in the current iteration | None | Return value of `partition` method invocation | Yes, as argument passed to `each` |
| 3 | `partition` invocation | Inner array 2 in current iteration | None | New array with 2 nested arrays | Yes, passed to the inner block 1 execution |
| 3-5 | Inner block 2 execution | Inner array 2 element in current iteration | None | Boolean | Yes, passed to `partition` method |
| 4 | `>` operator with argument `0` | Inner array 2 element in current iteration | None | Boolean | Yes, passed to inner block 2 execution |

```ruby
[[[1, 2], [3, 4]], [5, 6]].map do |arr|
  arr.map do |el|
    if el.to_s.size == 1    # it's an integer
      el + 1
    else                    # it's an array
      el.map do |n|
        n + 1
      end
    end
  end
end
# => [[[2, 3], [4, 5]], [6, 7]]
```

```ruby
customer_orders = {}

order_data.each do |row|
  if customer_orders.has_key?(row[:customer_id])
    customer_orders[row[:customer_id]][:orders] << [
      row[:order_fulfilled],
      row[:order_value]
    ]
  else
    customer_orders[row[:customer_id]] = {
      customer_id: row[:customer_id],
      customer_name: row[:customer_name],
      orders: [
        [
          row[:order_fulfilled],
          row[:order_value]
        ]
      ]
    }
  end
end

customer_orders = customer_orders.values
```
| Line | Action | Object | Side effect | Return value | Return value used?
|------|--------|--------|-------------|--------------|--------------|
| 1 | Assign `customer_orders` to an empty hash | Empty hash | None | Empty hash | No |
| 3 | `each` invocation | `order_data` object | None | `order_data` object | No |
| 3-21 | Block execution | Each transaction row | None | Value returned by the last evaluated expression | Yes, as arguments passed to `each` |
| 4 | `Hash#has_key?` invocation with `row[:customer_id]` argument | customer_orders hash | None | Boolean | Yes, sent to `if` statement |
| 4-21 | `if` statement | Boolean | None | Last evaluated expression | Yes, passed to block execution |
| 5-8 | `<<` operator with 2 nested elements: `row[:order_fulfilled]` and `row[:order_value]` | `customer_orders[row[:customer_id]][:orders]` | None | `[row[:order_fulfilled], row[:order_value]]` | Yes, passed to `if` and then to block execution |

| 2-6 | Inner block 1 execution | Array element in the current iteration | None | Return value of `partition` method invocation | Yes, as argument passed to `each` |
| 3 | `partition` invocation | Inner array 2 in current iteration | None | New array with 2 nested arrays | Yes, passed to the inner block 1 execution |
| 3-5 | Inner block 2 execution | Inner array 2 element in current iteration | None | Boolean | Yes, passed to `partition` method |
| 4 | `>` operator with argument `0` | Inner array 2 element in current iteration | None | Boolean | Yes, passed to inner block 2 execution |