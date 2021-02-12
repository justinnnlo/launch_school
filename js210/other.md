# Strict mode

Enter strict mode by writing at the top `"use string;"`.

`"use strict"` is an example of a **pagma**. This is a language construct (but not part of the language) that tells a compiler, interpreter or other translator to process the code differently.

Since strict mode is lexically scoped it only applies to code that enables it. E.g. if it's within a function strict mode is limited to the function's scope.

Use strict mode for new programs — not for old code bases.

# Errors

When the JS interpreter can't continue executing a program it creates an Error that describes the problem and stops the program.

- ReferenceError: using a variable or function that doesn't exist
- TypeError: accessing the value of a property that doesn't exist
- SyntaxError: errors in the text of the program

## Guard Clause

Guard clauses is code that guarantees that data meets certain preconditions before using it. E.g., a standard function that checks for edge cases that can break the program.

Use it for input validation.

# Syntactical sugar

[Review this later — I'm not ready to go over it yet.](https://launchschool.com/gists/2edcf7d7)

## Methods

```javascript
// Long version
let obj = {
  foo: function() {
    // do something
  },

  bar: function(arg1, arg2) {
    // do something else with arg1 and arg2
  },
}

// Syntactical sugar
let obj = {
  foo() {
    // do something
  },

  bar(arg1, arg2) {
    // do something else with arg1 and arg2
  },
}
```

## Object destructuring

Object destructuring lets you perform multiple assignments in a single expression

```javascript
```

```javascript
```