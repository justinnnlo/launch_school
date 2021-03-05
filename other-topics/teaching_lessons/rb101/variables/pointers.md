```ruby
a = "hi there"
b = a
a = "not here"
b
```

This example illustrates that variables act as pointers to an object — they're like tags that help us locate and find an object.

When b is assigned to a, it's really assigned to the variable *pointed* by a — that is, the variable assigned to it at that moment. Thus, b = "hi there".

When a is reassigned to "not here", as b is pointing to "hi there" and that object isn't mutated, its value doesn't change.

```ruby
p a = "hi there"
p b = a
p a << ", Bob"
p b
```

This concept shows that when an object is mutated then all variables pointing to it will now return its new value.

By line 2, both `a` and `b` point to `"hi there"`. Yet in line 3, it's mutated to `"hi there, Bob"` through the `<<` operator.

Thus, `a` and `b` will now point to the object with value `"hi there, Bob"`.

```ruby
a = [1, 2, 3, 3]
b = a
c = a.uniq
```

This example illustrates how methods can return new object rather than mutate existing ones — which can then be used to bind to variables.

In this example, `a` and `b` are assigned to the object with value `[1, 2, 3, 4]`. Yet `c` is assigned to `[1, 2, 3]`.

This happened because c was assigned to the return value of a.uniq. This created a new object without the non-unique elements of `[1, 2, 3, 3]` (that is, the second 3).

However, `#uniq` does not mutate the object. Thus, it's assigned to a different object to the other 2.

```ruby
def test(b)
  b.map {|letter| "I like the letter: #{letter}"}
end

a = ['a', 'b', 'c']
test(a) # => ["I like the letter: a", "I like the letter: b", "I like the letter: c"]
```

This example shows how in Ruby the object of a variable is passed to a method — but not the variable itself.

This method creates a new array object that contains new string elements.

The object `['a', 'b', 'c']` is passed to `test` via the `a` variable. The method then invokes `map` to the object, which returns the new object `["I like the letter: a", "I like the letter: b", "I like the letter: c"]`.

However, `a` is still `['a', 'b', 'c']` because it wasn't mutated.

If we were to call `map!` it would've mutated the object. Thus, calling `a` after `test(a)` would've returned `["I like the letter: a", "I like the letter: b", "I like the letter: c"]`.


```ruby
a = 5.2  # 5.2
b = 7.3  # 7.3

a = b    # 7.3

b += 1.1 # 8.4
```

a = 7.3
b = 8.4

This shows the idea of variables as pointers and variable reassignment with syntactical sugar.

```ruby
def test(str)
  str  += '!'   # reassigns method variables to "Written Assessment!" object
  str.downcase! # written assessment! => mutates the new object, not the one pointed by test_str
end

test_str = 'Written Assessment'
test(test_str)  # => written assessment!

puts test_str   # outputs "Written Assessment", returns nil
```

This example shows how string reassignment creates a new object which is then mutated.

This does NOT mutate the original object because of the reassignment of the method parameter.

```ruby
def plus(x, y)
  x = x + y    # Reassigns method parameter x
end

a = 3
b = plus(a, 2) # => 5

puts a         # 3
puts b         # 5
```

This shows how parameters that are reassigned do not change the object that was originally assigned to it.

```ruby
def increment(x)
  x << 'b'
end

y = 'a'
increment(y) # => "ab"

puts y       # prints "ab", returns nil
```

The string passed to increment is mutated in the method to "ab".

```ruby
def change_name(name)
  name = 'bob'      # variable shadowing: parameter is reassigned but not the local variable
end

name = 'jim'
change_name(name)
puts name           # "jim"
```

This shows how method parameters take precedence over local variables within a method.

```ruby
def cap(str)
  str.capitalize!   # Parameter points to the object, which is mutated
end

name = "jim"
cap(name)
puts name           # "Jim"
```

```ruby
a = [1, 3]
b = [2]
arr = [a, b]  # [[1, 3], [2]]
arr

a[1] = 5
arr           # [[1, 5], 5]
```

Collections, like strings and hashes, point to objects. If those objects are mutated then the collections will display the different value.

```ruby
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase!
end

puts arr1 # ["a", "b", "c"]
puts arr2 # ["A", "B", "C"]
```

#dup is shallow copying. This means that a new object is created, but the elements within it are the same.

arr2 has a different value because map! mutated the cloned object. However, char.upcase did not mutate its elements. Thus, arr1 and arr2 are different objects with different values.

If the loop were changed to `char.upcase!` then arr1 and arr2 would still be different objects, but sharing the same elements in the same order.