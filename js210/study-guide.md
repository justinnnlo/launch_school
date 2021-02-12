# Topics

Confidence is ranked 1 (low) to 3 (high).

|Topic|Confidence|
|-|-|
|assignments and comparison|2|
|variable scope, especially how variables interact with function definitions and blocks|2|
|function scope|2|
|hoisting|2|
|primitive values, types and type conversions/coercions|Primitives (1), coersions (2)|
|object properties and mutation|2|
|understand the differences between loose and strict equality|2|
|how passing an argument into a function may or may not permanently change the value that a variable contains or points to|2|
|working with Strings, Arrays, and Objects. In particular, you should be thoroughly familiar with the basic Array iteration methods (forEach, map, filter, and find) and how to use Object methods to access the keys and values in an Object as an Array.|2|
|understand that arrays are objects, and be able to determine whether you have an Array|2|
|variables as pointers|2|
|console.log vs return|2|
|truthiness: false and true vs. falsy and truthy|2|
|function definition and function invocation|2|
|function declarations, function expressions, and arrow functions|1|
|implicit return value of function invocations|2|
|first-class functions|2|
|side-effects|2|
|naming conventions (legal vs idiomatic)|1|
|pure functions and side effects| |

# Functions

- What are first-class functions?
- Functions as first-class objects
- Pure functions
  - No side effects
  - Uses inputs
  - Consistent outcomes?
  - Implication of above: independent from the rest of the code base, consistent behavior using inputs

## Function definition and invocation

## Function declaration vs expressions vs arrow functions

### Function declarations

Functions are declared with the syntax:
```javascript
function functionName(parameter) {
  // function body
}
```

Just as variables start with `var` or `const`, functions need to be declared with `function`. This assigns the function to a variable of the same name as any variable (remember functions are first-class objects).

We can prove this by first assigning a variable with `var` and then declaring a function with the same name as the function. In both cases it assigns the same identifier to a first class object: first to a number and then to a function.
```javascript
var test = 10;

function test() {             // SyntaxError: identifier 'test' has already been declared
  return 'I\'m a function!';
}

test    // [Function: test]
test()  // I'm a function!
```

Note that if we declare the variable with `let` the function declaration would return an error (this also applies to `const`). This is because identifiers declared with `let` can't be declared again — and `function` is declaring the variable and assigning it to a function object.

```javascript
let test = 10;

function test() {             // SyntaxError: identifier 'test' has already been declared
  return 'I\'m a function!';
}
```

Functions can access their arguments with the `arguments` array-like object, even if it didn't specify parameters in its function definition. Note that besides the bracket notation it doesn't share any behaviors with arrays
```javascript
function functionName() {
  return arguments
}

functionName(1, 2, 3, 'All in here'); // [Arguments] { '0': 1, '1': 2, '2': 3, '3': 'All in here'}
```

Alternatively, we can capture and pass an undefined number of arguments with the `...arguments` reset parameter syntax established in ES6. Notice that unlike the `arguments` object the reset parameter is a standard array.
```javascript
function functionName(...args) {
  return args
}

functionName(1, 2, 3, 'All in here'); // [1, 2, 3, 'All in here']
```

`...` is the spread operator!

### Function expressions

A function expression is a function that serves as an expression. An expression is ``a part of a statement that evaluates`` valid code that returns a meaningful value (`undefined` isn't considered meaningful). The value that they return is a function object — which itself returns a value when executed. Thus, a function is code that evaluates just like `1 + 1` — but with much more flexibility and power.

They're typically used as part of variable declarations so that the variable it's assigned to can call the function expression.

```javascript
let test = () => 'I\'m a function!';

test    // [Function: test]
test()  // "I'm a function!"
```

Note that function expressions assigned in a variable declaration with `let` or `var` are hoisted as any other object assigned with these keywords. Thus, the function body isn't hoisted alongside the identifier at the top of its scope — this is reserved for function definitions and function bodies.

- Function declarations load before any code is executed
- Function expressions load only when the interpreter in the execution phase reaches that line of the code
  - HOWEVER, the key benefit of function expressions is that it makes it clear that the function is bound to a variable name

```javascript
function test() {             // SyntaxError: identifier 'test' has already been declared
  return 'I\'m a function!';
}
```

With function expressions, a key difference is between named and unnamed functions. Named functions are great for debugging because they can be referrence with their name — not so with unnamed functions

- Note: named function expressions are only available within the scope of their function.

Function expressions and arrow functions are great for callback functions, e.g. when passing them to an iterator.

### Arrow functions

- Arrow functions don't have their own `this` or `argument` bindings/identifiers
  - They refer to `this` and `argument` outside of the arrow function
- Arrow functions are only callables
  - Function declarations and expressions are both callable and constructable (can be invoked with `new`)
  ```javascript
  // Callable function expression
  let x = function(){
   console.log(arguments);
  };

  // Non-arrow functions are constructable
  new x =(1,2,3);
  ```

## Functional scope and variables



# Arrays and objects

Objects are collections of key-value pairs, where they keys are always string and the values can be any data type. These key-value pairs are also called properties.

Arrays are different because they associate ordered index keys with values.



- What are arrays?
- How do they relate to objects?
- How do they differ?
- Objects and mutability
- Primitive values vs objects

## Array iteration methods

Note that the callback functions passed to the iterator methods are called without parentheses!

- `forEach(item, [index, [array]])` iterates through the array and passes it to a callback function
  ```javascript
  let printItem = (item) => console.log(item);

  [1, 2, 3].forEach(printItem);
  // 1
  // 2
  // 3

  let printItemAndIndex = (item, index) => console.log(`${item} is index ${index}`);
  [1, 2, 3].forEach(printItemAndIndex);
  // 1 is index 0
  // 2 is index 1
  // 3 is index 2

  let printEverything = (item, index, arr) => console.log(`${item} is index ${index} in ${arr}`);
  [1, 2, 3].forEach(printEverything);
  // 1 is index 0 in 1,2,3
  // 2 is index 1 in 1,2,3
  // 3 is index 2 in 1,2,3
  ```
  - We can use either of the 3 parameters to control the logic of the callback function
    ```javascript
    let printEvenIndices = (item, index) => {
      if (index % 2 === 0) {
        console.log(item);
      }
    }

    [1, 2, 3].forEach(printEvenIndices);
    // 1
    // 3
    ```
- `map`: like `Array#map`
  ```javascript
  [1, 2, 3].map(num => num * 2);                      // [2, 4, 6]
  ```
- `filter`: like `Array#select`
  ```javascript
  let evenNumbers = (item) => item % 2 === 0;
  [1, 2, 3].filter(evenNumbers);                      // [2]
  [1, 2, 3].filter(item => item % 2 === 0);           // [2]

  let evenIndices = (item, index) => index % 2 === 0;
  [1, 2, 3].filter(evenNumbers);                      // [1, 3]
  [1, 2, 3].filter((item, index) => index % 2 === 0); // [1, 3]
  ```
- `reduce`
  ```javascript
  let sum = (acc, num) => acc + num;
  [1, 2, 3].reduce(sum);                              // 6
  [1, 2, 3].reduce((acc, num) => acc + num);          // 6
  ```
- `find`: returns the first *element* within the array that satisfies a condition
  ```javascript
  [1, 2, true].find(item => item === true);           // true
  [1, 2, 3].find(item => item === true);              // undefined
  ```
  - `Array.prototype.findIndex()` is the equivalent but returns the index of the element that satisfies the condition rather than the element itself
  ```javascript
  [1, 2, true].findIndex(item => item === true);      // 2
  [1, 2, 3].findIndex(item => item === true);         // undefined
  ```

## Properties

# Definitions and examples

- Hoisting
- Variable scope
  - `let`, undeclared variables, `const`, `var`
- Callback
  - A callback is a function passed as an argument to another function
  ```javascript
  function myFunction(num, callback) {
    return callback(num);
  }

  function plusFive(num) {
    return num + 5;
  }

  myFunction(10, plusFive);   // plusFive is the callback
  ```


```javascript
```

```javascript
```

```javascript
```

```javascript
```

```javascript
```