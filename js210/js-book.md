# Intro

- JS was created at Netscape as a scripting language for the company's web browser; however, it had performance and security issues
- Google's open-source Chrome V8 JS engine was a turning point because it made JS more robust
- Node.js allows JS code to be executed outside a browser — allowing it to be used for other purposes and in other locations

## Abstraction

A programming language is a set of syntactic and semantic rules that describe a formal language used to tell the machine how to convert an input (code) into an output.

Programmers operate at the abstraction of a programming language like JS. JS is processed by a runtime environment (engine) — an execution environment that lets an application program access system resources and provides the tools the app needs to operate. In JS the 2 major runtime environments are Node.js and the browser.

Runtime environments are written in a lower level language like C++ and converting JS code to lower-level code with their compiler or interpreter programs. Compilers produce an output file that the computer can run directly while interpreters run the interpreted code directly or pass it to a companion program. This continues until its a series of 1s and 0s.

JS is an interpreted language but it uses a special type of **compiler call Just in Time (JIT) compiler** that also allows the computer to run the result.

Besides this lower layer abstractions, there are also higher level abstractions like libraries and frameworks to help code more easily in JS.

### Browser

Running JS in the browser has 2 main purposes:
- Programmatically alter a webpage based on a user's action (AJAX) using the DOM API
- Exchange messages with a server over a network using the XHR (XMLHttpRequest) interface and Fetch API

### Node.js

Node.js is a general-purpose programming environment. It needs a few capabilities:
- Reading and writing disk files (disk I/O)
- Reading and writing via the terminal (standard I/O)
- Sending and receiving messages over a network (network I/O)
- To interact with a database

When you run a JS file through the commandline it uses an interpreter.

## Styling

The purpose of a good style guide is to help you be consistent with how other people code. It's also meant to provide rules for:
- Readability: better formatting and aesthetics
- Avoid language pitfalls with best practices

- Variable conventions
  - Preferred: `let` and `const`
    - Declare variables as close to their first use as possible
    - `const` if the variable won't be reassigned
      - If the object will mutate, decide between `let` and `const`
  - `var`: declare variables at the top of the scope
    - When a variable's been assigned as is then redeclared (but not reassigned) it doesn't reassign the variable
  - `let` is initialized in the line it's declared in the execution phase
- Naming conventions
  - Variables and functions: camelCase
  - Constants: SCREAMING_SNAKE_CASE
    - Exception: imported function names can use camelCase
- Spacing
  - Two spaces to indent lines+
  - Spaces between operators, e.g. `1 + 1`
  - One space before and after the opening parentheses of control statements `if`, `switch`, `while`, etc.
    - Exception: space between a function name and its parentheses for parameters, should be as: `functionName()`
- Ternary operators
  - Keep to single line expressions
  - Should not be nested
  - Avoid unneeded ternaty operators
  ```javascript
  // bad
  let foo = a ? a : b;
  let bar = c ? true : false;
  let baz = c ? false : true;

  // good
  let foo = a || b;
  let bar = !!c;
  let baz = !c;
  ```
- Blocks
  - At the end of a block leave an empty line before the next statement
  - Multi-line blocks with `if` and `else` should have `else` in the same line as the block's closing brace
  - Single-lines shouldn't have bracesm multiple-line blocks should
  ```javascript
  // bad
  if (test)
    return false;

  // good
  if (test) return false;

  // good
  if (test) {
    return false;
  }

  // bad
  function foo() { return false; }

  // good
  function bar() {
    return false;
  }
  ```
- Semicolons
  - At the end of ending statement (except if it ends in a block)
    - But should be at the end of a function expression!
  - Note: if JS needs a semicolon that isn't there it automatically inserts it
- Strings
  - Surround with single quotes `'`
  - Use explicit coersion unless you want to raise an error
  ```javascript
  // bad
  let a = 9;
  let string = a + '';

  // good when you want to raise errors
  null.toString();

  // good when you want to guarantee coercion to a String
  String(null);
  ```
- Number
  - Coersions with `Number` and `parseInt` **with a radix** for parsing strings
  ```javascript
  // bad
  let val = parseInt(inputValue);

  // good
  let val = Number(inputValue);

  // good
  let val = parseInt(inputValue, 10);
  ```
- Functions
  - Never name an argument `argument` because the `argument` object is given to every function scope
  - Never declare a function in a non-function block (`if`, `while`, etc)
  - In a non-function block, use an arrow function or function expression
  ```javascript
  // bad
  if (currentUser) {
    function test() {
      console.log('Nope.');
    }
  }

  // good
  let test;
  if (currentUser) {
    test = function () {
      console.log('Yup.');
    };
  }

  // good
  let test;
  if (currentUser) {
    test = () => console.log('Yup.');
  }
  ```

## Methods

Methods are functions that need a value to call the function. For example, `"xyz".toUpperCase()` is a string method because it needs a calling string object for the function to execute.

There are 2 types of methods: instance and static methods. Instance methods are described as `Constructor.prototype.methodName()`, where `Constructor` is the class. Static methods are described as `Constructor.methodName`. There isn't an obvious way to know if something is an instance or static method besides checking the documentation.

## Data Types

JS has 5 traditional primitive data types:
- String
- Number: includes `Infinite`, `-Infinite` and `NaN`
- Undefined
- Null
- Boolean

And ES6 introduced 2 more:

- Symbol
- BigInt

All non-primitive types are of type `object`.

Data values can be represented as literas. A literal is a fixed value, such as `"Hello!"` and `5`.
```javascript
'Hello, world!'     // string literal
3.141528            // numeric literal
true                // boolean literal
{ a: 1, b: 2 }      // object literal
[ 1, 2, 3 ]         // array literal
undefined           // undefined literal
```

### Strings

Strings are a sequence of characters enclosed in single or double quotes. Strings can be escaped with the `\` character.

```javascript
> "He said, 'Hi there!'"    // with double quotes
= "He said, 'Hi there!'"

> 'He said, \'Hi there!\''  // with single quotes and escaping
= "He said, 'Hi there!'"
```

We can interpolate strings with template literals: strings enclosed in backticks "\`" with expressions within `${}`.

### Numbers

The Number class encompassess all numbers in JS, unlike other languages. You can't use commas or periods for grouping!

### Undefined vs Null

`Undefined` represents an absence of value. It's returned by all statement and by accessing values that don't exist in collections.

How are `Undefined` and `Null` different?
- `Null` means an intentional abscence of value whereas `Undefined` arises implicitly
- `Null` is of type `Object` whereas `Undefined` is of type `Undefined`
  - `Null` being type `Object` is a mistake going back to the origin of JS

### Data structures

Arrays are ordered lists that store any data type within `[]`. The `[]` syntax is also used to retrieve an array value, as in Ruby. Arrays are type `object`.

Hashes or dictionaries are also `object` type. They are created with the same syntax as in Ruby. However, to use the `[]` notation to retrieve a value we need to enclose the hash in a parentheses:

```javascript
> ({ dog: 'barks', cat: 'meows', pig: 'oinks' })['cat']
= 'meows'
```

## Variable Scope

A variable's scope is where it is accessible within the program. A scope depends on where a variable isdeclared. Variables declared with `let` or `const` have **block scope**.

In JS, a block is the code within a pair of opening and closing curly braces.

Oddly, **undeclared variables have a global scope**! Global variables can be accessed anywhere in the program

However, `var`, unlike `let` and `const`, scopes to the immediate function body rather than the immediate enclosing block. Hence, `var` has a function rather than block scope.
- Block scope: within a block, e.g. `if`, `switch`, `for`, `while` — usually within curly braces
- Functional scope: only within a function

Regardless of how a variable is defined JS has the same process when it looks up a variable that is referenced:
- JS will look for a variable in the current scope
- JS will move up through subsequent outer scopes until the variable is found
- JS will raise a `ReferenceError` if it reaches the  outermost, global scope without finding the variable

### Hoisting: `var` vs `let`

Variables declared with `var` are hoisted (initialized with `undefined`) — making them accessible before they're declared.

```javascript
function run() {
  console.log(foo); // undefined
  var foo = "Foo";
  console.log(foo); // Foo
}

run();
```

How is this possible? Because **JS doesn't execute the program's code line by line**. Rather, it goes over the code and finds and associates variable declarations with their appropriate scope — as if it moved `var` variable declarations (but not assignment) to the top of the scope.

However, variables declared with `let` are not hoisted and thus return a `ReferenceError` if they're called before they're declared.

```javascript
function run() {
  console.log(foo); // ReferenceError
  let foo = "Foo";
  console.log(foo);
}

run();              // ReferenceError
```

### Function hoisting

The JS interpreter also hoists function declarations. But unlike variables which are only declared, functions are hoisted with their function declaration and function body. Thus, a function can be executed before being declared — unlike in Ruby.

### Local variables vs Global variables

Local variables are confined to a function. A variable is local based on the keyword used to declare it and its location in the program.

Any variable declared with `let` or `const` inside a function or block is a local variable. Doing so is called **block scoping**.

## CLI Input/Output

Node.js has an API to read CLI inputs called `readline`. A simplified version of that API is `readline-sync`.

We can store dependencies by creating a `package.json` file and running the `nom init -y` command. Dependencies can then be installed via `npm install [dependency] --save`. This installs the package in the `node_modules` subdirectory of that directory, allowing you to access the package with a `require` call.

## Functions

Functions are procedures to extract code and run it as a repeatable, separate unit.

Functions are defined with the reserved keyword `function` followed by its name and function body.

```javascript
function functionName() {
  // function body
}
```

Extracting the logic to a function gives us flexibility. Even if we extract something as simple as `console.log`, that allows us to in the future modify that function and thus change how we output all our data that uses said function.

An argument is a value supplied to a function. A parameter is the definition of an argument in a function definition. Thus, arguments are the values of parameters.

```javascript
function functionName(parameter) {
  console.log(parameter) // parameter is an argument here
}

functionName(argument);
```

Default parameters are defined with a `=` and used when an argument isn't passed.
```javascript
function say(words = "hello") {
  console.log(words + "!");
}

say("Howdy"); // => Howdy!
say();        // => hello!
```

Interestingly, functions can be nested:
```javascript
function foo() {
  function bar() {
    console.log("BAR");
  }

  bar(); // => BAR
  bar(); // => BAR
}

foo();
bar(); // ReferenceError: bar is not defined
```

Function names and parameters are local variable names in JS — they're defined locally.

As in Ruby, the `return` keyword returns the value of an expression for a function or method. Unlike Ruby, there isn't implicit `return`.

### Defining functions

1. Function declaration: with `function functionName(arguments) { // function body }`
  - Unlike in Ruby, we can call a function before it's defined — it won't raise an error
2. Function expression: a function definition saved to a variable — can't be invoked before it's declared
  - How to identify: any function definition where `function` isn't at the very beginning, e.g. `(function ...`
  - How can this happen? JS functions are first-class functions: we can treat them like any value because functions are objects
    - Assign them to variable
    - Pass them as arguments
    - Return them from a function call
```javascript
let greetPeople = function () {
  console.log("Good Morning!");
};

greetPeople();
```
3. Arrow functions
  - They have implicit returns: we can omit `return` if the function body contains a single expression
```javascript
let add = (a, b) => a + b;
let greetPeople = () => console.log("Good Morning!");
greetPeople();
```

### Function composition

We can pass functions as arguments of other functions. This is a process called function composition.

```javascript
add(subtract(80, 10), times(subtract(20, 6), add(30, 5))); // => 560
```

## Call Stack

The call stack helps JS keep track of what functions it's executing and where execution should resume when the function returns. The call stack is made of stack frames.

The initial stack frame is the `main` function, which represents the global, top-level portion of the program.

|Call Stack|
|-|
|`main`|

When a function is invoked JS updates the call stack and places the function (e.g. `greeting()`) stack frame on top of the `main` stack frame.

|Call Stack|
|-|
|`greeting`|
|`main`|

Since `main` is underneath of `greeting` in the call stack `main` is inaccessible. This is because `greeting` function has become active and `main` has become dormant. This can continue. E.g., if `greeting` calls the `console.log` method the call stack pushes down the `greeting` stack as it makes `console.log` the active stack.

|Call Stack|
|-|
|`console.log`|
|`greeting`|
|`main`|

Note that all of these stack frames share the same call stack. This process can continue. E.g., `console.log` probably has its own internal function calls that would push `console.log` down the call stack as new frame become active on top of it.

This process reverses as methods and functions return their values. E.g., when `console.log` returns its value the call stack pops the `console.log` stack frame.

|Call Stack|
|-|
|-|
|`greeting`|
|`main`|

Thus, execution resumes in `greeting` as its the next stack frame in the call stack. This continues until JS returns to `main`. **When the `main` function has no more code to run the `main` frame is popped from the stack and the program ends.**

Note that `RangeError` means that the call stack has exceeded its capacity — it can hold up to aprox. 10,000 stack entries

## Functions vs Methods

Functions have the syntax `function(obj)`. Some **functions mutate their arguments**.

Methods have the syntax `obj.function()`. Some **methods mutate the caller**.

But the caller or argument has to be an `object` instance because it's the only type that isn't inmutable. E.g., `[1, 2, 3].pop();` removes the last element of the array permanently.

## Pass by value vs pass by reference

- Primitive values: pass-by-value
- Objects and arrays: pass-by-reference


# Truthiness

Weirdly, `&&` and `||` evaluate based on truthiness and can return the truthy values instead of boolean values. They return the last *evaluated* operand, which includes short-circuiting

```javascript
3 && 4        // 4
1 || "a"      // 1
true || false // true
true || NaN   // true
true || 0     // true
true || Null  // true
1 || NaN      // 1
3 && "foo"    // "foo"
"foo" && 3    // 3
0 && "foo"    // 0
"foo" && 0    // 0
0 || ""       // ""
0 && ""       // 0
"" || 0       // 0
"" && 0       // ""
```

Thus, code like this can be seen as wrong because it's using logical operators that will return the last evaluated value of the expression:
```javascript
let foo = null;
let bar = 'qux';
let isOk = foo || bar;
```

There are more readable and accurate ways of getting to our objective (representing if it's OK):
```javascript
let isOk = (foo || bar) ? true : false; // Ternary operator
let isOk = !!(foo || bar);              // Double bang
```

# Arrays

- 0 indexing
- `arr[-1]` doesn't work, you need to do `arr[arr.length - 1]`
- Arrays assigned to constants can't be reassigned (i.e., we can't change what object we point to)but the array's *contents* can be because reassigned they aren't the array itself
  - Array elements can be made constant with the `Object.freeze(array)` method
  ```javascript
  > const MyArray = Object.freeze([1, 2, 3])
  > MyArray[1] = 5
  > MyArray
  = [1, 2, 3]

  > const MyArray = Object.freeze([1, 2, 3, [4, 5, 6]])
  > MyArray[3][1] = 0
  > MyArray
  = [1, 2, 3, [4, 0, 6]] // Freeze only works one level deep! Hence why this array can be changed

  > const MyArray = Object.freeze([1, 2, 3, Object.freeze([4, 5, 6])])
  > MyArray[3][1] = 0
  > MyArray
  = [1, 2, 3, [4, 5, 6]]
  ```
- Mutating methods
  - `arr.push(obj)` adds an object to the end of the array
    - `arr.concat(obj)` is a non-mutating alternative
  - `arr.pop(obj)` destroys the last element of the array
  - `arr.splice(startingIndex, number)` removes at least one object of the array and returns those objects as a new array

# Iteration Methods

To use most iterative methods you need to pass a callback function. A callback functin is a function passed as an argument to another function. The callback function is invoked by the calling function when it runs.

All of these built-in methods only use elements with a valid index value!

## `forEach`

Iterates through each element and always returns undefined.

## `map`
Iterates through each element and returns a new array.

## `filter`
Iterates through each element and creates a new array with the elements that satisfied the condition.

## `reduce`
Uses the accelerator and current element being iterated to manipulate it in many ways. It doesn't mutate the calling object.

# Other array methods

- `includes`: checks whether an array has a given element and returns a boolean
  - Internally uses `===` to compare array elements
  - Why we can't sue includes to check nested arrays unless we're looking for an exact object
- `sort`: destructively sorts array elements (i.e., mutates the calling array)
- `slice`: extract and return a portion of the array (non-mutating)
  - No arguments: returns copy of the entire array
  - Omission of 2nd argument: goes until the end of the array
  - Can accept negative integers
- `splice`: mutating equivalent of `slice` — removes and returns elements selected
- `reverse`: destructively reverse the order of the array

# Objects

## Prototypes
In JS, objects can inherit from other objects. When `a` inherits from `b` we say that `a` is a prototype of `b`. As a prototype of `b`, `a` has access to the properties of `b` even though it didn't define those properties itself. We can create prototypes with the `Object.create` method.

```javascript
let student = { school: 'Launch School' };
let jose = Object.create(student);
jose['course'] = 'JS 210';
jose.age = 25;

jose            // { course: 'JS 210', age: 25 }
jose.school     // 'Launch School'
// Note: school property is accessible by 'jose' but NOT IN 'jose'
```

Objects don't have access to the built-in array iterator methods like `forEach` and `reduce`, but can be iterated via standard `for` and other looping structures.

```javascript
let student = { school: 'Launch School' };
let jose = Object.create(student);
jose['course'] = 'JS 210';
jose.age = 25;

for (let prop in jose) {
  console.log(`Name: ${prop}, Value: ${jose[prop]}`)
}
// Name: course, Value: JS 210
// Name: age, Value: 25
// Name: school, Value: Launch School

for (let prop in jose) {
  console.log(`Name: ${prop}, Value: ${jose.prop}`) // jose.prop is interpreted as access the key "prop" in "jose"!
}
// Name: course, Value: undefined
// Name: age, Value: undefined
// Name: school, Value: undefined
```

Note that the `for` loop iterates through the properties of the object and the object's prototype! This is why in the above exampel we iterated over `school` property even though it belongs to the object it was created from.

We can work around this using an `if` statement and passing the current key to the `Object.hasOwnProperty` method:
```javascript
let obj1 = { a: 1, b: 2 }
let obj2 = Object.create(obj1);
obj2.c = 3;
obj2.d = 4;

for (let prop in obj2) {
  if (obj2.hasOwnProperty(prop)) {
    console.log(obj2[prop]);
  }
} // => 3
  //    4
```

### Object methods

- `Object.keys(obj)`: returns object keys (excluding the prototype object's keys)
- `Object.values(obj)`: returns values — but order can be hard to predict
- `Object.entries(obj)`: returns subarrays with keys and values!
- `Object.assign(obj1, obj2)`: merge the 2 objects into the first

### Understanding identifiers

Identifiers are neither string nor objects. They aren't values in themselves but are used to name things that have values.

```javascript
```