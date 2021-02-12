# Defining functions

Most programming languages offer constructs called procedures to execute pieces of code repeatedly. In JS, functions refer to procedures.

A function declaration has the structure:
- `function` keyword
- Function name
- Parameters
- Block of statements: the function body

If a function doesn't have a `return` statement or the `return` statement isn't passed an argument the function will return `undefined`.

Note that a function declaration does 2 things: create a variable and create a function (assigned to the variable). A function declaration is therefore also a variable initialization. Thus, there are 4 ways to declare variables:
- `let`
- `const`
- `var`
- `function`

In JS, functions are local variables that store as values a function. **The type is function.** Thus, we can assign a function to another local variable or reassign the name tied to a function to another value:
```javascript
function startle() {
  console.log('Yikes!');
}

let surprise = startle; // assigning to a new variable
surprise();             // Yikes!

startle = 5;            // Reassigning startñe
startle                 // 5
```

## Anonymous functions and function expressions

An anonymous function is a function without a name. For example:

```javascript
let hi = function () {
  return "I'm anonymous!";
};
```

This piece of code has 3 elements:
1. Variable declaration of `hi`
2. Variable assignment of `hi` to an anonymous function
3. Creation of the anonymous function

In this context, the function is called a function expression because the function is part of a larger expression syntax — in this case a variable assignment.

```javascript
function foo() {
  console.log('function declaration');
}

(function bar() {
  console.log('function expression');
});

foo();    // function declaration
bar();    // Uncaught ReferenceError: bar is not defined
```

For anonymous functions the variable is used in the code to invoke the anonymous function. An anonymous function can be returned by another, outer anonymous function. This is a way to assign functions to variables.

```javascript
let foo = function () {
  return function () {   // function expression as return value
    return 1;
  };
};

let bar = foo();         // bar is assigned to the returned function

bar();                   // 1
```

**Note that declared functions cannot be anonymous**.

Yet function expressions aren't just anonymous functions: after all, they're functions that are part of a larger expression syntax. Thus, a named function can also be a function expression.

```javascript
let hello = function foo() {
  console.log(typeof foo);   // function
};

hello();

foo();                       // Uncaught ReferenceError: foo is not defined
```

Note that named functions used as function expressions can only access their names from inside the function. These named functions for function expressions are useful for:
- Debugging because the function's name appears in the call stack
- Recursive functions

# Parameters and arguments

A parameter is defined in the function definition and specifies the arguments the function will take.

An argument is a value passed to a function.

What happens when a function is passed less arguments than parameters? Rather than raising `ArgumentError` as in Ruby, the argument takes the value of `undefined`.

Remember that using an arithmetic operator with a non-number (barring the exception of `+` and `String` primitives) returns `NaN`.

# Arrow functions

Arrow functions are a special type of function definition that acts as a shorthand for writing function expressions.

```javascript
// Standard function expression
const multiply = function(a, b) {
  return a * b;
}

// Function expression as an arrow function
const multiply = (a, b) => {
  return a * b;
}

// Single line arrow function
const multiply = (a, b) => return a * b;

// Single line arrow function: return is redundant
const multiply = (a, b) => a * b;
```

Arrow functions are most used as **callback functions**.

```javascript
// map with function expression
[1, 2, 3].map(function (element {
  return 2 * element;
}); // returns [2, 4, 6]

// map with arrow function expression
[1, 2, 3].map((element) => 2 * element); // returns [2, 4, 6]

// Arrow function expression without parentheses because of single parameter
[1, 2, 3].map(element => 2 * element); // returns [2, 4, 6]
```

# Hoisting

JS engines operates in 2 main phases: creation and execution phase.

- Creation phase: preliminary work
  - E.g. find all the variable function and class declarations
  - **Hoisting**: effectively move those declaration to the top of their function or block
    - Includes the global scope (or module scope) in the function `main`
    - Hoisting doesn't *change* the program — it just executes as if it changed
- Execution: run the program line by line

JS code isn't read top-down, as Ruby e.g. Hoisting is the process through which the code is read by JS and it moves upwards certain variable and function declarations.

- Variable declarations
  - `let` and `const`: its variables are hoisted but if invoked before its declaration it returns `ReferenceError`
    - Why: though hoisted, they are left in an "unset" state different to `undefined`
    - These unset variables are said to be in the **Temporal Dead Zone (TDZ)**
    ```javascript
    console.log(foo); // Uncaught ReferencfeError: Cannot access 'foo' before initialization
    let foo;
    ```
    - Note that accessing a variable that doesn't exist raises a different type of `ReferenceError`
    ```javascript
    console.log(foo); // Uncaught ReferenceError: foo is not defined
    ```
  - `var`: it's variables are hoisted — if invoked before its declaration it returns `undefined`
  ```javascript
  console.log(bar); // undefined
  var bar = 3;
  console.log(bar); // 3
  ```
- Functions: are hoisted and unlike variable hoisting it also binds the function to its body when its hoisted
  - Why: function declarations have function scope — which is why hoisting also occurs with nested functions
  - Thus, the full function is available in its scope regardless of the location
  ```javascript
  // Code in program
  console.log(getName());

  function getName() {
    return "Pete";
  }

  // Code after hoisting
  function getName() {
    return "Pete";
  }

  console.log(getName());
  ```

## Function expressions and hoisting

Since function expressions are the expressions of a variable declaration, they aren't assigned to the variable when it's hoisted — much more like variable than function hoisting

```javascript
// Program code
console.log(hello());

var hello = function () {
  return 'hello world';
};

// After hoisting
var hello;

console.log(hello());    // raises "Uncaught TypeError: hello is not a function"

hello = function () {
  return 'hello world';
};
```

## How it hoists variable and function declaration

Function declarations are hoisted above variable declarations.

```javascript
// Program code
bar();              // logs undefined
var foo = 'hello';

function bar() {
  console.log(foo);
}

// After hoisting
function bar() {
  console.log(foo);
}

var foo;

bar();          // logs undefined
foo = 'hello';
```

As the example above shows, it's best to avoid calling a variable within a function because things like these could happen!

# Best practices

- **Avoid `var`**
  - If unavoidable, declare all the variables at the top of the scope
- If using `let` and `const`: declare them as close to where they're first used as possible
- Declare functions before using them

# Under the hood

Hoisting doesn't exist. It's only a mental model for understanding how JS works with function and variable declarations. There isn't a point where it *moves* things.

# Closures

Closures let a function access a variable that was in scope at the function's definition even when that variable is no longer in scope. Clores are an artifact in the code's sctructure — not how the code runs.

## Understanding closures

Closures use the scope at the function's definition to determine what variables that function can access. The closure *formed* at the function's definition determines the variables that are in scope in a function's execution. Thus, a closure is *created at the definition of a function or method*.

## Defining closures

- MDN: *the combination of a function and the lexical environment within which that function was defined*
  - Lexical environment: variables, functions, and classes
  - Defined (not declared): because it's for both expressions (which aren't declared) and statement
- LS: A closure is the combination of a function with all the variables (including function and class names) in its lexical scope

Closures *closes over* its environment (what's in scope). What's important to call other artifacts isn't where you invoke the function but where you define a function.

## Mental Model

When you define a function, JS finds all artifacts within the lexical scope of the function definition and puts their names and places inside an object it attaches to the function object. Each name in the envelope is a pointer to the variable, not a value.

## Nesting functions and data protection

One reason nesting functions and variables is powerful is because it protects parts of the code. For example, we could declare and initialize a counter variable within a function that also serves as a counter.

Thus, the only way to get the value of the counter would be to call the function — increasing the count. This implies that the counter is harder to tamper with and protected within the function. This is called a **private variable**.

```javascript
function makeCounter() {
  let counter = 0;    // Private variable

  return function() {
    counter += 1;
    return counter;
  }
}

let incrementCounter = makeCounter();
console.log(incrementCounter()); // 1
console.log(incrementCounter()); // 2
```

# Partial Function Application

A partial function application is a function that creates a function that can call a 2nd function with fewer arguments than the 2nd function expects. The created argument supplies the remaining arguments to the 2nd function.

Thus, it returns a function that with its own input(s) can be used for another task.

```javascript
function add(first, second) {
  return first + second;
}

function makeAdder(firstNumber) {
  // returns an adder function that adds an input with the argument passed to makeAdder
  return function(secondNumber) {
    // add is the 2nd function and it'll need only 1 input as firstNumber is supplied
    return add(firstNumber, secondNumber);
  };
}

let addFive = makeAdder(5);
let addTen = makeAdder(10);

console.log(addFive(3));  // 8
console.log(addFive(55)); // 60
console.log(addTen(3));   // 13
console.log(addTen(55));  // 65
```

