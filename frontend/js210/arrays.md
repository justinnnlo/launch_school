# Arrays

Arrays are the basic ordered collection type of JS. Unlike Ruby, they aren't their own primitive — rather, it belongs to the `object` class.

Arrays can be constructed either directly (e.g. `[1, 2, 3]`) or with the `Array` constructor (`new Array(1, 2, 3)`).

We can determines if an array is an object via the `isArray(obj)` method.

## Accessing, modifying and detecting values

`[]` returns the value that is accessed. Note that `[]` in JS is an operator — not a method as in Ruby.

- You get `undefined` if you access:
  - A **value that doesn't exist**
  - A **negative value** (see nuance below)

You can also use `[]` to modify the values of the array (also returning said value):
```javascript
> let arr = [];
undefined
> arr[0] = 1;
1
> arr[3] = 5;
5
> arr;
[ 1, <2 empty items>, 5 ]
> arr.length;
4
```

An array can also be modified by changing its `length` property:
```javascript
> arr;
[ 1, <2 empty items>, 5 ]
> arr.length = 1;
1
> arr;
[1]
```

You can't use negative numbers to access values in an array because negative indices don't exist in JS arrays. However, you can create a negative key that becomes part of the "array object". But this doesn't become an index!

```javascript
let digits = [];

digits[-1] = -42;

digits.length     // 0

digits[-1];       // -42
digits['-1'];     // -42 (though using a string!)
```

## Key operations; push, pop, shift, unshift

JS has an `Array` global object. The `Array` global object has a **prototype object that defines the array methods**.

- Push: append elements at end and return the new length
- Pop: delete element at end and return the deleted element
- Unshift: insert a value at the beginning of the array and return the new length
- Shift: delete element at beginning and return the deleted element

## Key array operators

### Arithmetic Operators

These operators convert arrays to strings before operating them.

```javascript
[1, 2, 3] + "B";  // "1,2,3B"

[1, 2, 3] + [4];  // "1, 2, 34"

[5] * 10          // 10: Becomes ('5' * 10) and then (5 * 10)

[5, 2] * 10       // NaN: Becomes ('5, 2' * 10) and then (NaN * 10)
```

The key problem with operators is that they **can create a mess instead of returning a result** — beware!

### Comparison operators

Array comparison operators check whether the arrays are the *same object*. It doesn't check the values stored in the arrays.

## Reset parameter syntax

The reset parameter syntax `...parameterName` allows us to group all succeeding parameters into a single array.

# Arrays vs objects

Both of these are data structures that represent compund data. You should use each if:
- Array: ordered list of items
- Object: entity with many parts
  - Sometimes called associative arrays because there's an association of keys and values

## Arrays and length

JS' built-in Array methods (`join`, `forEach`, `push`, etc) take the value of the `length` property when doing an operation. For example, they can:
- Use the `length` value
- Set the `length` value
- Both

ECMAScript's documentations says that `Array.length`:
- Is always a non-negative integer less than 2^32
- `length` is always one greater than the largest array index value
- Can be set with the `length` property

Yet it can be confusing that we can set an array element with an invalid index value:
```javascript
let myArray = [];
myArray['foo'] = 'bar';
myArray[0] = 'baz';
myArray[1] = 'qux';

console.log(myArray);         // logs ['baz', 'qux', foo: 'bar']
myArray.length;               // returns 2 since foo: 'bar' is not an element
myArray.indexOf('bar');       // returns -1 since 'bar' isn't in an element
```

This implies that:
- An array property name can only be a non-negative index
- Values assigned to an index property are called array elements
- Property names that violate the non-negative index rule and their associated values aren't array elements
- `Array.prototype.indexOf` returns `-1` if the value doesn't have a valid array property name
- The value of `length` depends on the largest array index value (i.e., it doesn't count array elements)
  - This does *not* count all the element — e.g. it counts empty values
  - To count all array elements use `Object.keys(array).length`
- The array loses data when the `length` property is set to a value equal or smaller than the current largest integer
  - However, it doesn't lose values bound to a non-array index because they don't count towards the length

## Array operations

- Ideally avoid the `in` and `delete` operators — they can be confusing in terms of the intention and results
- Use `Array.prototype.splice` to delete values
- Avoid arithmetic operators

The most notable isue is that properties that aren't array indices and empty slots will not be processed by built-in array methods

# What is an element?

ON face value, an array only stores elements without any keys. Yet underneath that is associates a property name with the value.

```javascript
let arr = [2, 3, 4];
console.log(arr);               // [2, 3, 4]
console.log(arr.length);        // 3
console.log(Object.keys(arr));  // ['0', '1', '2']
```

An array element is a property with a valid array index name. Invalid array index names are those that aren't non-negative integers. They don't count towards the array `length` nor work with built-in methods.

```javascript
let arr = [2, 3, 4];
console.log(arr);               // [2, 3, 4]

arr[-3] = 5;

arr.length = 5;

console.log(arr);               // [ 2, 3, 4, <2 empty items>, '-3': 5 ]
console.log(Object.keys(arr));  // [ '0', '1', '2', '-3' ]
```

Note that there are 2 type of properties that aren't array elements:
- Invalid property names like `-3'
- Empty slots
  - Count towards the length but lack a key

## Sparse arrays

Sparse arrays are those whose number of elements doesn't equal its `length` value.

A quirky behavior is that when we create a sparse array by changing the length property the concept of 'undefined' varies:
```javascript
let arr = [1, 2, 3];
arr.length = 5;
arr.length;                       // 5
console.log(Object.keys(arr));    // [ '0', '1', '2' ]

arr[3];                           // undefined
arr[3] = undefined;

console.log(Object.keys(arr));    // [ '0', '1', '2', '3' ]
```

What's the takeway? That an empty item has a value of `undefined` in the sense that it isn't set. This implies that it lacks an index name value. However, if we explicitly set the value to `undefined` it creates an index value for it. Therefore, it seems like index values are only created for values that are explicitly set.


# Object and Value Mutability

Some values are primitives and some are objects:

```javascript
> typeof 'hi';
string
> typeof new String('hi');
object
> typeof undefined
undefined
```

- Primitives are inmutable: operations return a new value of the same type
- Objects are mutable: we can modify their internal data without changing their identity

We can confirm primitives are inmutable:
```javascript
let test = "I won't change!";

test[0] = 'z';                // 'z'

test;                         // "I won't change!"
```
`test` didn't change because we created a string primitive by writing it as a literal instead of using the `new String` object constructor.

The equivalent with an array works. **The array itself is mutable but the string array elements aren't**:

```javascript
let test = ['I', ' ', 'w', 'o', 'n', "'", 't', ' ', 'c', 'h', 'a', 'n', 'g', 'e', '!'];

test[0] = 'z';                // 'z'

test.join('');                // "z won't change!"
```
Thus, we're able to perform this because we're reassinging a mutable array element rather than a character within an inmutable string primitive.

# Pure functions and side effects

A function has side effects if it:
- Reassigns any non-local variable
- Mutates the value of an object referenced by a non-local variable
- Reads or writes from any data entity that isn't local to the program
  - Using `readline-sync` to read from the keyboard and write to the console
  - Accessing the system date or time, e.g. `new Date();`
  - Accessing the random numeber generator with `Math.random();`
- Raises an exception
  - E.g. `if (num === 0) throw new Error("Divide by zero!");` raises an exception
- Calls another function that has side effects
  - E.g. calling `console.log`

It's more precise to talk about function calls and side effects than just functions and side effects. This is because a function may not have a side effect with some arguments but might with others.

E.g., with some arguments a function may raise an exception whereas with others it may not have a side effect.

When we say a "function" has a side effect it means that when they're used as intended they have a side effect regardless of the arguments passed in.

As a rule of thumb **avoid functions that both have a side effect and return values**.

## Pure functions

These are functions that:
1. Have no side effects
2. Always return a value dependent on the arguments passed
  - E.g. if it always returns `undefined` it wouldn't be pure because the value returned doesn't vary based on the arguments
3. **Always returns the same value given the same set of arguments**

For example, a function that adds 2 numbers:
```javascript
function addition(num1, num2) {
  return num1 + num2;
}
```

The last point is the most important: nothing will influence the function's output during the function's lifetime — it's isolated from the rest of the program. A function's lifetime begins when it's created and ends when it's destroyed.

As with side effects, it's more precise to talk about function calls being pure or impure rather than functions per se.

# Destructive assignment

We can simultaneously swap the value of variables with the following syntax:

```javascript
let a = 1;
let b = 2;

[a, b] = [b, a];

a;   // 2
b;   // 1
```

# Function Arguments

`arguments` is an *array-like* local variable inside all functions. It contains all the arguments passed to the function regardless of the number provided or the parameters defined in the function's definition.

```javascript
function logArgs(a) {
  console.log(arguments[0]);
  console.log(arguments[1]);
  console.log(arguments.length);
}

logArgs(1, 'a');

// logs:
1
a         // 'a' is available even though the function defined 1 parameter
2
```

`arguments` is array-like because we can access its elements via bracket notation. But it's unlike an array because it doesn't have any methods.

IF we want to manipulate `arguments` as an array we need to copy it to an array. E.g.

```javascript
function logArgs() {
  // How to copy arguments to an array object
  let args = Array.prototype.slice.call(arguments);

  console.log(typeof args);
  console.log(Array.isArray(args));
  args.pop();
}

logArgs(1, 2);

// logs:
object
true         // args is a proper Array now
```

The problem with `arguments` is that it's slightly difficult to read and understand. Thus, it should only be used when working with an arbitrary number of arguments and working with a JS version that precedes ES6. Why ES6? Because it introduced the reset parameter syntax...

## Modern approach: reset parameters

Reset parameters requires passing `...arrayName` to the function parameter in its definition. `...arrayName` tells JS to expect any number of parameters and to store them in an array binded to `arrayName`. Unlike `argument`, reset parameters binds the variable to an array — not an array-like structure.



```javascript
```