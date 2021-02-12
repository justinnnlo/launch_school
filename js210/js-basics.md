# JS versions

Browsers have different support of JS versions and features. [Make sure to check what is and isn't supported in this compatibility table](http://kangax.github.io/compat-table/es2016plus/).

# Running JS code

You can run your code by placing it in an HTML file and opening it in Chrome. Add the HTML `script` tags and within the element place the JS code directly. The browser will execute that code when you load or reload the page.

```html
<body>
  <script>
    console.log('I run automatically!');
  </script>
</body>
```

Alternatively, you can have a separate JS file that's included in HTML via a `script` pointing to that file:
```html
<script src="my_javascript.js"></script>
```

Choose between one of the 2: don't have both simultaneously! If that happens, HTML will use the JS file that's loaded.

# Style guide

As in Ruby, there are style conventions that don't change how the code is interpreted but provide readability.

## Variable, Function and Object Names

Variables, functions and objects should start with a lowercase letter and use camelCase.

```javascript
// number, string, array, object
let myNumber = 26;
let myString = 'Double 13';
let myArray = [13, 13];
let myObject = {
  count: 26,
};

// function names
let addValues = function (a, b) {
  return a + b;
};

function multiplyValues(a, b) {
  return a * b;
}
```

Variables that follow naming conventions have **idiomatic names**.

### Constructor functions and PascalCase

Constructure functions — unlike other functions — should use PascalCase.

## Constant names

Unlike variable, objects and functions, constants should start with an uppercase letter — and should ideally be fully capitalized.

```javascript
// Ok
const Title = 'Head-First JavaScript Programming';

// Better
const TITLE = 'Head-First JavaScript Programming';
```

Constants with multiple words use SCREAMING_SNAKE_CASE:
```javascript
// number, string, array, object
const NUMBER_OF_LETTERS = 26;
const DECK_OF_CARDS = ["2 of Clubs", "2 of Diamonds", …, "Ace of Spades"];
```

Constants are typically defined in the top-level scope but can also be declared inside a function.

### Constants and Magic Numbers

As a rule of thumb, avoid magic numbers. A magic number is a number that is in the program by itself — without a variable or pther identifier. This creates the problem that we lack context about why it's there when we read the code.

Instead, use constants to store information and specify what it's for.

Ideally, define a constant with a number with as much contextual information as possible.

```javascript
// Poor
97;
122;

// OK
const FIRST_CHARACTER_CODE = 97;
const LAST_CHARACTER_CODE = 122;

// Best
const FIRST_CHARACTER_CODE = 'a'.charCodeAt();
const LAST_CHARACTER_CODE = 'z'.charCodeAt();
```

# Formatting

- Indent with two space characters — never with tabs.
- Single-line curly braces can be in its own line
- Multi-line curly braces should start in the line of its opening sentence and end on its own line
- A statement should always end with a semicolon — otherwise JavaScript will see the next statement as part of the former
- Use spacing for `if`, `for`, `while` statements and between a closing parentheses and opening brace to prevent confusions between built-in statements and function calls
```javascript
// Bad
let counter=0;
while(counter<15){
  counter+=1;
}

// Good
let counter = 0;
while (counter < 15) {
  counter += 1;
}
```
- Use one `let` declaration per variable
```javascript
// Bad
let firstName = 'Shane',
    lastName = 'Riley',
    dogs = ['Josie', 'Libby'];

// Good
let firstName = 'Shane';
let lastName = 'Riley';
let dogs = ['Josie', 'Libby'];
```