# #each

There are 3 similar `each` methods: `Enumerator#each`, `String#each_char`, and `Range#each`.

If no block is passed to these methods they return an enumerable. If a block is passed, it executes the block as it iterates though each element — executing once for each element.

The key characteristics of the method are:
1. If a block is passed, it will return the original object
2. The method will not use the value returned by each block execution
3. It can have (but does not require) 1 parameter that represent the current element being iterated

Despite returning the same object if a block is passed, this method can perform very useful operations. These include: mutating an object, printing to the output values, and more.

A nuance regarding the 3rd point is that with the Enumerator and String we can also use a 2nd parameter that represents the index of the current element. In the case of Enumerator, we do that via the `Enumerator#each_with_index` method. With String, we do it by chaining to `String#each` the `String#with_index` method.


`Array#each` executes the block as it iterates though each element — executing the block once for each element.

After the code within the block is executed, it returns a value to the method that the method does not use.

After `Array#each` finishes executing, it returns the calling object.



# #select


`Hash#select` executes the block once for each element. The block evaluates the truthiness of the value returned by the block. If the value is truthy, it includes the current element being iterated into the new hash.

After the block has executed once for every element, `Hash#select` returns a new hash with all of the elements whose block were truthy.

For example, `[1, 2, 3].select { false }` returns `[]`. As the block always evalues to `false`, the method does not include — does not select — any methods because none of them were truthy.

Inversely, `[1, 2, 3].select { false }` returns a new object with the same value — `[1, 2, 3]`. This happens because the block always returned a truthy value of each element iteration.



This Enumerable method has many similarities, but a few key differences, to `each`.

Like `each`:
1. If no block is passed, it returns an enumerator
2. If a block is passed, it executes the block once for each element
3. The calling object can be an Array, Hash or Range — or any other that includes the Enumerable module
4. It can use a single parameter to represent the current element in the iteration

Unlike `each`:
1. The **truthiness of the return value of the block** is used to determine whether the current element of the iteration is included in the new object
2. The `select` method creates a new array object (unless its a hash, in which case it creates a new hash) containing the elements whose block execution were truthy in the order in which they were executed
3. String data types cannot call the `select` method (though strings can be used within `map` if the calling object containing the string(s) has a data type that allows it to call `map`)

Additionally, as suggested above unlike `map` `select` can create more than a new array — `Hash#select` creates a new hash object.

Yet like `Array#map!`, `Array#select!` and `Hash#select!` mutate their calling objects rather than create a new one.

For example, `[1, 2, 3].select { false }` returns `[]`. As the block always evalues to `false`, the method does not include — does not select — any methods because none of them were truthy.

Inversely, `[1, 2, 3].select { false }` returns a new object with the same value — `[1, 2, 3]`. This happens because the block always returned a truthy value of each element iteration.

# #map

This Enumerable method has many similarities, but a few key differences, to `each`.

Like `each`:
1. If no block is passed, it returns an enumerator
2. If a block is passed, it executes the block once for each element
3. The calling object can be an Array, Hash or Range — or any other that includes the Enumerable module
4. It can use a single parameter to represent the current element in the iteration

Unlike `each`:
1. The **return value of the block** is used to determine the value of a new element for every element of the calling object (unlike `each`, where the block's return value is not used by the method)
2. It creates a new array (or mutates the calling array, in the case of `Array#map!`) that contains the new elements in the order in which they were created
3. String data types cannot call the `map` method (though strings can be used within `map` if the calling object containing the string(s) has a data type that allows it to call `map`)

For example, `[1, 2, 3].map { false }` returns `[false, false, false]`. This is because it creates a new 3 element array, iterates through each element, and since the block always returns `false` it places that object in the 3 locations of the new array.

# #sort


In this example, `sort` returns a new array with its values sorted in ascending value.

The order of the string elements is determined via the method `String#<=>`. The spaceship operator compares the calling object with a second object passed as an argument, and returns one of 4 values:
  - `-1` if the calling object is smaller than the object it's being compared to
  - `0` if both objects have the same value
  - `1` if the spaceship's argument is smaller than the calling object
  - `nil` if both objects cannot be compared

`String#<=>` itself uses the ASCII values of each character to make the comparisons.

`sort` then uses these values to determine what to do:
  - `-1` or `0`: leave the objects in their place
  - `1` switch the order of the objects
  - `nil` return an error

An important nuance is: how does `sort` iterate through the elements to ensure they're arranged in the correct order when the elements change position? In this specific example: how does it ensure `"aa"` is the first object?

To use a simplified example to understand the underlying principle, we can execute `[1, 2, 4, 3].sort`.

It leaves the first 2 calling objects (`1` and `2`) in their place as both method calls return `-1`.

It then switches `3` and `4` as `4 <=> 3` returns `1`.

The new array is now `[1, 2, 3, 4]`. To verify `2` and `3` are in the right order (as it only compared `2` and `4`), `sort` then executes `2 <=> 3`. As it returns `-1`, it finally returns `[1, 2, 3, 4]`. This simple example shows an important mechanism that ensures `sort` is well-executed.




This Enumerable method allows us to sort the elements of an object.

Under the hood, `sort` uses the spaceship (`<=>`) operator to determine the relative position of 2 elements. With each iteration, it calls `<=>` to the current element and passes as an argument the element immediately to its right. It then returns -1 if the element to the left is smaller than the element to the right, 0 if they're equivalent, 1 if the one to the right is larger, and `nil` if the 2 elements cannot be compared. Thus, in `[1, 2].sort` the method would only execute 1 block that would evaluates `1 <=> 2`, which is equivalent to saying `1.<=>(2)`.

Like `map`, `sort` only return a new array. Within that new array are the elements of the calling object in their sorted positions given the set criteria.

Yet a key nuance of `sort` is that the elements it compares need to be of the same data type. This is because `<=>` is a method that only compares equivalent data types: `String#<=>` compares 2 string elements, `Integer#<=>` compares 2 integer elements, `Float#<=>` compares 2 float elements, etc.

This explains why `[1, "a"].sort` would return return an error — it's like saying `1 <=> "a"` when `Integer#<=>` can only be passed an integer as an argument.

An important nuance is: how does sort iterate through the elements to ensure they're arranged in the same order when the elements change position?

We can see how it does it by running

```ruby
[1, 2, 4, 3].sort do |a, bee|
  byebug
  a <=> b
end
```

It leaves the first 2 calling objects (1 and 2) in their place as both method calls return -1. It then switches 3 and 4 as 4 <=> 3 returns 1. The new array is now `[1, 2, 3, 4]`. To verify 2 and 3 are in the right order (as it only compared 2 and 4), sort then executes `2 <=> 3`. As it returns -1, it finally returns `[1, 2, 3, 4]`. This simple example shows how sort works in larger scales.

# block

A block is a snippet of code that is executed in certain methods.

A block, which can be defined within `{}` or `do...end`, executes the code within it and returns the result of the last evaluated expression. It then sends this value to the calling method.

For example, in `[1, 2, 3].map { false }`, the block executes 3 times and returns each time `false`.

There are 2 important nuances with block execution:
1. A block passed to a method that does not execute blocks is equivalent to calling the method with no parameters
  - `puts { false }` outputs an empty newline and returns nil
  - `p { false }` outputs nothing and returns nil
2. A block that is not passed to a method will create a syntax error because it cannot execute on its own.
```ruby
{ false }
=> SyntaxError: unexpected '}'
```



Exam replies

1.

In line 3 we have a loop method invocation that is passed the `do...end` block that is in lines 3 to 7. This block, every time the block is executed, runs the lines of code between lines 4 and 6. In this case, the block only executes once because `break` in line 6 exits the loop and prevents the block from being executed again.

Line 9 outputs `blue` because the variable `color` was reassigned within the block, in line 4, to the string object `blue`.

Conversely, in line 10 `shape` raises an error because it was initialized inside the loop. This demonstrates the principle that local variables defined in outside scopes are accessible within leaky scopes, but not vice versa.


2.

This question illustrates the principle that local variables defined in outside scopes are accessible within leaky scopes, but not vice versa.

In line 1 we initialize the variable `color` and bind it to `"red"`. Following the aforementioned principle, we can reference `color` withini the leaky scope of the `do...end` block of lines 3 to 15 (as proven by outputting `"red"` in line 12).

In line 4 we initialize the variable `shape` and bind it to the value `"circle"`. This can be shown in the output when line 13 is executed because both lines are in the same scope.

Yet `puts size` returns an error in line 14 because it was initizlized within a leaky scope that was one level deeper (between lines 6 and 10). Thus, in line 14 there is no local variable `size` — it only existis within the block in lines 6 and 10.


3.

Line 8 outputs `"purple"` because that's the value that we have binded the variable `color` with in line 1, when we initialized the variable.

`color` was not reassigned in line 4 when we executed `color = "orange"` because we had a block parameter also called `color`. Thus, within the loop the parameter had precedence over the local variable and we initialized and assigned that block parameter to `"orange"` — rather than reassign the local variable in the regular program execution.

This shows the principle of  variable shadowing — when a local variable is inaccessible because of the existance of another variable with the same name. To avoid this issue, we only have to change the parameter name in lines 3 and 4 from `color` to any other name.

4

In line 11 we are calling the method `some_greeting` and passing the object `greeting`, which is binded to the string `"hello"`. Thus, this allows the method `some_method` to reference the `"hello"` object in line 2 and pass it to the method call `puts` in that same line — leading to the object's output.

The reason why line 12 does not also output `"hello"` is that in line 6 `another_method` cannot reference `greeting`. The problem is that method are defined within self-contained scopes, so only objects passed to the method as arguments or defined within the method definition are accessible. As neither has occurred within lines 5 to 7, the variable `greeting` doesn't exist within that scope and it returns the error.

This thus illustrates the principle of local variable scoping and its relationship with self-contained scopes.


5.

The variable `a` is initialized in line 1 and binded to the string `"red"`. 

The variable `b` is initialized in line 2 and binded to the string `"blue"`. 

The variable `c` is initialized in line 3 and binded to the string `"green"`.

The reason why `puts a` on line 9 outputs `"blue"` is that the variable `a` is reassigned in line 5 to the variable `b`, which points to the object `"blue"`.

Similarly, variable `c` also outputs `"blue"` in line 11 because it is reassigned to the variable `a`, which now points to the object `"blue"`, in line 7.

Conversely, `b` is reassigned in line 6 to the new string object `"yellow"`. This explains why that is its output in line 10. The `"blue"` object still exists, `b` just doesn't ponts to it anymore.

The underlying principle is that variables are pointers — a variable helps us reference the location of the object that it is binded to.


6.

On line `8`, when we call the method `my_method` and pass as an argument the variable `b` that points to the object `"Goodbye"`, we are sending the object to a self-contained scope. Thus, within that scope the variable `a` does not exist.

This implies that in line 2 we are initializing the variable `a` and binding it to the object passed to `my_method` (which returns the value of the object being binded to).

By extension, the variable `a` in the regular program execution is not affected by the initialization of `a` within the method. This explains why `puts a` in line 10 outputs `"Hello"` — because the variable was never reassigned.

This example shows how local variables defined outside of a self-contained scope cannot be referenced inside of it.


7.

In line 6 we are passing the object `"hello world"` as an argument to the method call `shout`. Line 2 shows how the method `upcase` is called on the object `"hello world"`. This line creates a new object `"HELLO WORLD"`, which is the object returned by the method.

However, `String#upcase` creates a new string object — it doesn't mutate the calling object. This is why in line 8 `puts sentence` outputs `"hello world"`.


8.

In line 6 we are passing the object `"hello world"` as an argument to the method call `shout`. Line 2 shows how the method `upcase!` is called on the object `"hello world"`. This line mutates that object and modifies its value to `"HELLO WORLD"`, which is the object returned by the method and printed in line 9 by `puts sentence`.

The reason why line 9 does not print `"HELLO WORLD!!!"` is that in line 2 we create a new object `"hello world!!!"` when we invoke the method `+` and pass it as an argument `"!!!"`. We would be able to print `"HELLO WORLD!!!"` if we had mutated the object in line 2 or reassigned the local variable `string` from the `"hello world"` object to the new object `"hello world!!!"`.

This demonstrates the difference between creating a new object and mutating an object.


9.

The method call `shout` in line 7, which is passed the object `"hello world"`, returns the object `"HELLO WORLD!!!"` in that same line 7. However, this same object not outputted in line 9 because it is a different object from the `"hello world"` object referenced by the variable `sentence`.

This happens because in line 2 we create a new object with `String#+` method and reassign the method parameter `string` to that new object using the `String#=` method. Thus, when `"string.upcase!"` is executed in line 3 the calling object is the object created in line 2 — not the object created in line 6 of the regular program execution and binded to the variable `sentence`.


10.

In the first code block we are mutating twice the same object passed into the method call `shout`. This is done in line 2, with the mutating shovel (`String#<<`) method, and in line 3, with the also mutating `String#upcase!` method. Thus, thorughout lines 1 to 9 we only maniputlate and create that single object.

In the second code block we are reaching the same conclusion by reassigning the local variable `sentence` to a different object returned by `shout(sentence)`.

In line 6 `sentence` is initialized and binded with `"hello world"`, which is passed in line 7 to the method call. Yet in line 2 `String#+` creates a new object with value `"hello world!!!"` and assigns it to the method local variable `string`. In line 3 a third object is created by the object returned by `string.upcase` with value `"HELLO WORLD!!!"`. This last object is returned by the method call `shout(sentence)` and binded to `sentence` due to its reassignment in line 7.

Thus, this example shows the nuances between object mutation and variable reassignment.



13

In line 1 we are initializing the variable `arr` and binding it to the value returned by `[1, 2, 3].map { |num| num }`.

`[1, 2, 3].map { |num| num }` creates a new array from the value returned by each block execution. As the block has a parameter which takes the value of the current element being iterated, and the block returns the value of the parameter, the new array will have a value of `[1, 2, 3]`.

Thus, line 1 is essentially `arr = [1, 2, 3]`. The key caveat is that the `[1, 2, 3]` that is binded to `arr` is not the same object as the calling object of `[1, 2, 3].map { |num| num }` — despite having the same value.


14.

Like in the above example, in line 1 we are initializing the variable `arr` and binding it to the value returned by `[1, 2, 3].map { |num| num }`.

Also like the previous example, the `[1, 2, 3]` that is binded to `arr` is not the same object as the calling object of `[1, 2, 3].map { |num| num }` — despite having the same value.

The crucial distinction is the difference between how `Array#select` and `Array#map` work. We are also returning in each block execution the value of the current element being iterated – first 1, then 2 and finally 3. But `Array#select`, rather than placing that return value in the new array, evaluates its truthiness. As all positive integers have a truthy value, it then places the element being iterated into the new array.

Thus, the value returned by the block tells `Array#select` whether an element goes into the new array or not — the value returned does not go by default into the new array as it does in `Array#map`.


15.

In line 1 we are initializing the `letters_and_numbers` variable and assigning it to the hash `{"a" => 1, "b" => 2, "c" => 3}`.

In line 3 we are initializing the `hsh` variable and assigning it to the value returned by `letters_and_numbers.each`.

`p hsh` in line 7 then executes the same object pointed to by `letters_and_numbers`. If we were to write `letters_and_numbers.object_id == hsh.object_id` this would return true.

This is because `Hash#each` returns its calling object regardless of what code is executed within the block. Even if we were to mutate the object, the same object would be returned (though it'd have a different value as before).

In this specific case, the block always returns a value `true` in each of its 3 iterations because line 4 evaluates `num < 4` — but it's irrelevant to the object returned.



16.

There are 2 key distinctions in this example relative to the previous one:

1. The hash object assigned to `hsh` in line 3 has the same values but is a different object (i.e., it has a different location in physical memory) to the object assigned to the variable `letters_and_numbers`. This is because `Hash#select` returns a new object.


2. The block's truthiness of the return value determines whether a key-value pair is included in the new hash, unlike `Hash#select` where the block's return value was irrelevant in determining the object returned by the method. In this specific case, every block execution returns the value `true` given all values are lower than 4 (see line 4: `num < 4`). When a block returns `true` the method includes in the new hash the key-value pair of the current iteration.

Thus, `hsh` gets assigned the same value — but a different object — and in `Hash#select` — unlike `Hash#each` — the block plays a crucial role in determining the value of the new object.


18

In line 1, we initialize the variable `my_hash` and bind it to a hash with 3 key-value pairs
  - `:a` is the key to the value `1`
  - `:b` is the key to a fourth key-value pair: `{ :d => 3, :e => 5 }`
  - `:c` is the key to the value `7`

In line 3, the variable `my_hash` calls twice on the `Hash#[]` method to reference its elements. `my_hash[:b]` retrieves the value `{ :d => 3, :e => 5 }`. The second method call, that uses the second key `:d`, then retrieves `3`.

This example shows how collections in Ruby can reference specific elements contained within them. More specific to hashes (and arrays, does this example doesn't cover them), it also shows how we can nest elements.


19.

In line 1 we initialize the variable `my_arr` and bind it to a two dimensional array — `[["a", "b"], ["c", "d"], ["e", "f"]]`.

In line 3 the variable `my_arr` calls the method `Array#each`. The `do...end` block between lines 3 and 7 executes code using the parameter `arr`, which takes the value of the current element of `my_arr` being iterated.

In line 4 the parameter `arr` — which implies the current element of `my_arr` being iterated, calls `Array#each`. This method call is also passed a `do...end` block that runs from line 4 to 6 and has a parameter `letter`, which takes the value of the current element of `arr` being iterated.

Within this second block, in line 5 we are calling `puts` and passing `letter`.

To be more specific of how it works, let's go through one iteration.

1. `my_arr` invokes `Array#each` and `arr` has the value of `["a", "b"]`.
2. `arr` invokes a second `Array#each` and its parameter `letter` has the value of `"a"`.
3. `puts letter` is equivalent in this first iteration to `puts "a"`, and thus prints `"a"` to the output.
4. `letter` changes value to the second element: `"b"`. Line 5 now output `"b"`.
5. `arr` changes value to `["c", "d"]` and repeats the process until the end.




20.

In lines 1 to 3 we define the method `greeting`. In line 2 we state that greeting will execute `puts "Hello"` — which prints to the output `"Hello"` and returns `nil`.

In line 5 we initialize the variable `a` and bind it to the value returned by the method `greeting`. As already discussed, `greeting` returns `nil` — thus, this is the value binded to `a`.

In line 7, `if a` evaluates the truthiness of the variable `a`. As `a` is binded to a value of `nil`, and `nil` is not truthy (which can be shown via `!!nil`, which returns `false`) `if a` evaluates to `false`.

Given the `if` statement evaluated to false, its succeeding `else` statement in line 9 leads to the execution of `puts "Goodbye"` in line 10. 

The underlying concepts are that `if` statement evaluate the truthiness of the argument passed to it and that the return value of methods is the return value of its last evaluated expression.



21.

In lines 1 to 3 we are defining the method `some_method`. Line 2 shows that it will print the string `"True"` and return `nil` (as `puts` always does).

Thus, line 5 is equivalent to `nil == false`. This is `false` because they're both different objects – `nil` is an object of class `NilClass` whereas `false` is an object of class `FalseClass`. This can also be proven by comparing object ids — `nil.object_id == false.object_id` returns false because they're stored in different locations.

The key underlying concept is the distinction between an object and whether its truthy or not. While `nil` is not truthy (`!!nil` returns `false`), `nil` is not the object `false`. This is equivalent to saying that `5` is truthy but is not the object `true`.