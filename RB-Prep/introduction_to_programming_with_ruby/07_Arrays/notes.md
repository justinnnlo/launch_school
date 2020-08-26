# What is an array?

An array is a class that **stores data in ordered lists**. 

Some of its key characteristics include:
- Its order is set by its indices, similar to a string
  - In contrast, an array can have subarrays — which means that its indices allow us to access elements within those subarrays themselves, unlike a string
- It can store any data type — hashes, strings, numbers, other arrays — in whichever order or combination
- An array is an iterable item and can be directly used in a `for` loop

# Array operations

Arrays are also compatible with basic maths operations.

- Addition: allows two or more arrays to create a larger, combined array
  - [1, 2, 3, 4] + [5] + [6, 7] = [1, 2, 3, 4, 5, 6, 7]
- Subtraction: it removes all the elements of the subtracting array
  - [1, 1, 1, 3] - [1] = [3]
- Multiplication: like a string, it appends at the end of the array n times the same array
  - [1, 2, 3] * 3 = [1, 2, 3, 1, 2, 3, 1, 2, 3] 

An important nuance is the **difference between the addition and shovel methods**, which I interpreted as being the same in the past.

The shovel (<<) method appends to an array new elements, like an addition operations. The difference is that the shovel implicitly converts the appending element into an array, while the addition does not. `[1, 2, 3] << 4` is equivalent to `[1, 2, 3] + [4]`.

# When should we use an array?

An array will be used when you need to store several objects within a single object. The question, then, is whether to use arrays or hashes.

Here the crucial distinctions are:
1. Ordered or unordered?
2. Do we want to associate the data with an identifier?

# Mutating an array

Mutating an object implies that it's permanently changed — it's a **destructive action**. Arrays can be mutated via some methods. These include some like uniq!, merge!, and pop.

A shorthand, but not universal, identifier of whether a method mutates the array is whether it uses the bang ("!") at the end of the method's name.

# String interpolation

As with other data types, arrays can be used to interpolate strings by placing them inside `#{}`. It prints the full array in the string.