# Primitive data types

- Number
- Boolean
- String
- Null
- Undefined
- Symbols (ES6)
- Big integers (ES6)

JavaScript also has a compound data type: object.

We can get the data type of a value with the `typeof` operator.
```javascript
typeof 1.2;       // "number"
typeof "hello";   // "string"
typeof false;     // "boolean"
typeof undefined; // "undefined"
typeof { a: 1 };  // "object"
typeof [1, 2, 3]; // "object"
typeof null;      // "object"
```

Note that
- Arrays like `[1, 2, 3]` are objects in JavaScript
- `null` is of type `object` due to a bug from the start of JS that will likely never be fixed as existing code depends on that

Additionally, in JS string interpolation is done with `${}` and surrounding everything with tickmarks (`).

# Number

JavaScript uses [Double Precision Floats](https://en.wikipedia.org/wiki/Double-precision_floating-point_format), which establishes the maximum size of numbers it can handle.

```javascript
> Number.MAX_SAFE_INTEGER
9007199254740991
> Number.MAX_VALUE
1.7976931348623157e+308
```

Numbers support the typical arithmetic operators:
- `+`
- `-`
- `*`
- `/`

Note that unlike other programming languages like Ruby, JavaScript doesn't have multiple numeric data types like `Integer` and `Float` — it only has `Number`.

## Floating point errors

Numbers stored in floating point values may create some discrepancies or rounding errors when looking at results.

```javascript
0.1 + 0.2;    // returns 0.30000000000000004, not 0.3!
```

Takeaway: avoid fractional numbers! Instead, use the smallest possible integers. For example, represent cents as integers (instead of dollars) or seconds as integers (instead of hours).

## Special values

There are 3 special values:
- `Infinity`: number greater than `1.7976931348623157e+308` or a number divided by 0
- `-Infinity`: negative representation of infinity
- `NaN`: not a number
  - Number cannot be parsed: `Number(undefined)`
  - Math operation resulting in a non-real number: `Math.sqrt(-1)`
  - Using `NaN` as an operand: `7 * NaN`
  - Indeterminate form: `0 * Infinity`, `undefined + undefined`
  - Operation with a string that isn't addition: `"foo" / 3`

Any number greater than `1.7976931348623157e+308` is represented as `Infinity`
```javascript
> Number.MAX_VALUE * 2
Infinity
```

# Boolean

```javascript
2 > 1;            // true
0 === 0;          // true
1 > 3;            // false
```

# String

Data type to represent text — i.e. a sequence of numbers.

- JS Strings have no size limit
- Strings can be held within single or double quotes
  - There isn't a functional distinction, unlike Ruby and interpolation
- Concatenate with the `+` operator
- Can hold any character in UTF-16 character set

## Special characters

Characters outside of UTF-16 need to be handled with escape sequences. Some common special characters are:

|Code|Character|
|-|-|
|\n|New line|
|\t|Tab|
|\r|Carriage return|
|\v|Vertical tab|
|\b|Backspace|

Standard characters sometimes need to be escaped — like when you use quote characters in the string that JS would otherwise interpret as the end of the string.

```javascript
> let quote = "I need to escape this \" or JS will end the sentence!";
undefined
> quote
'I need to escape this " or JS will end the sentence!'
```
Note that it's only for the quotes used to surround the string:
```javascript
> let quote = "This ' is fine!";
undefined
> quote
"This ' is fine!"
```

## Character Access

Strings *act* like a collection of characters. The `String.prototype.charAt` method can access characters on a string using the index value (using a 0-based index) of the character we want to access. Bracket notation also does the trick.

```javascript
"Jose".charAt(0); // "J"
"Jose"[0]; // "J"
```

Unlike in Ruby, `[]` is an operator rather than a method. So the method `charAt` works like the *operator* `[]`.

## String length

We can access a string's length *property* with `String.prototype.length` method.

```javascript
"Jose".length // 4
```

### Properties vs Methods

Properties have a value or state. A property is a read-only operation, like `"Jose".length` or `house.isDoorOpen`.

Methods perform actions, like `house.openDoor`.

[String methods are found here.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/prototype).

## Working with large strings

To make a long string easier to read you can set it up by:
- Breaking it up into smaller strings that are concatenated with `+`
- Placing a `\` at the end of each line
  - This tells JS to ignore the following newline and concatenate the next line to the current string
  - Note: spaces after a backslack `\`character prevent it from escaping the newline and raises a `SyntaxError`

```javascript
let lipsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do \
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut \
enim ad minim veniam, quis nostrud exercitation ullamco laboris \
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor \
in reprehenderit in voluptate velit esse cillum dolore eu fugiat \
nulla pariatur. Excepteur sint occaecat cupidatat non proident, \
sunt in culpa qui officia deserunt mollit anim id est laborum.';
```

# Inmutability and primitive values

All primitive values, including strings, are inmutable. *Once you create the value you can't change it*.

While some might appear to change (e.g. strings) this is an illusion. Under the hood it only assigns the values of a variable to new values.

```javascript
a = 'hello';
a.toUpperCase();  // the "hello" string is not mutated, but a new "HELLO" string is returned
a;                // still "hello"
```

However, objects are mutable — which includes arrays and functions.

# Variables

Variables store values in Javascript. They associate data with descriptive names — they're containers that hold data.

## Naming variables

- Accurate description
- Understandable to someone else
- camelCase naming
- Starts with a Unicode letter, underscore (`_`) or dollar sign `$`
  - Note: after the first character numbers can be used
- [Must not be a reserved word](http://www.ecma-international.org/ecma-262/5.1/#sec-7.6.1.1)

## Declaring variables

In JS variables need to be declared before they're used. They're declared with `let`, `const`, and `var`.

- `var`
  - Traditional way to declare variables in JS
    - `let` and `const`: instorduced in ES6
  - Use `var` if you're in a program already using `var` — otherwise stick to `let` and `const`

After a variable is declared the `=` operator can assign a value to it.

```javascript
// single declaration
let myVariable;

// multiple declarations
let otherVariable;
let anotherVariable;

// Constant declaration
const FOO = 'hello';

// var declarati on
var myVariable;

myVariable = 3; // assigns myVariable to the value 3
```

You can also combine the variable declaration with an **initializer**.

- Declaration: stating a new variable you will use, which if uninitialized binds it to `undefined`
- Assignment: a standalone expression that gives a variable a new value
- Initializer: expression to the right of `=` in a variable declaration

```javascript
let myVariable;        // Declared but uninitialized variables are assigned to "undefined"

myVariable = 3         // Assignment

let otherVariable = 10 // Variable declaration with initializer
```

## Variables vs Constants

Unlike variables, constants cannot be assigned a new variable. Therefore, they need to be initialized when they're declared.

```javascript
> const TEST = "Testing";
undefined
> TEST;
"Testing"
```

## Dynamic Typing

JS is a dynamically typed language. This implies that, like Ruby, a variable can be reassigned to a value of any data type.

```javascript
// initialize to a string
let myVariable = 'Hello, World';

// reassign to a number
myVariable = 23;

// now the variable holds a number value
myVariable;      // 23
```

# Operators

## Arithmetic Operators

Standard operators are:
- `+`
- `-`
- `*`
- `/`
- `%`

The remainder `%` operator is not the same as the modulo operator found in toher programming languages. This is relevant when a number is negative!

## Assignment Operators

Besides the assignment operator `=`, like Ruby JS has compound assignment operators: `-=`, `+=`, `*=`, `/=`, and `%=`.

## Comparison Operators

|Operator|Description|
|-|-|
|Equal `==`|`true` if operands are equal|
|Not equal `!=`|`true` if operands are different|
|Strict equal `===`|`true` if operands are equal and of the same type|
|Strict not equal `!==`|`true` if operands are not equal and/or of the same type|
|Greater than `>`|`true` if left operand is greater than right|
|Less than `<`|`true` if right operand is greater than right|

## String operators

The comparison operators work as with numbers — strings are compared using Unicode lexicongraphical ordering:
```javascript
> "a" < "b";
true
> "abc" < "a";
false
> "abc" == "a";
false
> "abc" > "a";
false
```

Strings also support concatenation with `+` and `+=`:
```javascript
> "a" + "a"
"aa"
> let a = 'Hello';
undefined
> a += ', world!';
"Hello, world!"
a;       // "Hello, world!"
```

## Logical operators

- Logical and `&&`
- Logical or `||`
- Logical not `!`
  - Default `false` values include
    - `null`
    - `NaN`
    - `0` (but not negative integers!)
    - Empty strings `""`
    - `false`
    - `undefined`

# Expressions and Statements

**An expression is any valid code that evaluates to a value.**

```javascript
"Hello";
5;
5 + 10;
sum = 10;
```

Expression types include:
- Arithmetic: expressions that evaluate to a number
- String: expressions that evaluate to strings
- Logical: evaluates to `true` or `false`

## Increment and Decrement Operators

Increment `++` and decrement `--` operators increment or decrement their operands by 1. Unlike `+=` or `-=` increment and decrement operators can only change values by a value of 1.

Note that for both `++` and `--`:
- `[operand]++` increases the operand by 1 and **returns the current value**
- `++[operand]` increases the operand by 1 and **returns the new value**

```javascript
> let a = 1;
undefined
> a++;
1
> ++a;
3
> a += 1;
4
> a++;
4
> a;
5
```

**What's going on?**
- With `a++` JS evaluates the expression `a` first and then modifies the operand
- With `++a` JS modifies the operand and then evaluates the expression `a`

Therefore:
```javascript
let a = 1;

b = a++;    // b = 1 because a evaluates first and a = 2 after its modified
c = ++b;    // b and c == 2 because the operand was modified before it was evaluated
```

## Logical short circuiting in expressions

Expressions with logical `&&` and `||` operators are evaluated using short-circuit rules:

```javacript
let a = true;
let b = false;

a || (b = true);  // b is still false after this, because (b = true) is never evaluated
b && (a = 1);     // a is still true after this, because (a = 1) is never evaluated
```

## Statements

An expression is valid code that evaluates to a value. Yet statements don't necessarily resolve to useful values. Rather, **statements control the program execution** and always return `undefined` — which cannot be used as part of an expression

- Variable assignments: expressions — return a useful value
- Variable declarations: statements — return `undefined`

While some statements use expressions (e.g. `let a = (c + 1);`) **expressions can't use statements** because they return `undefined`.

# Input and Output

## Getting user input with `prompt()`

The `prompt()` method opens a pop-up window in the browser for the user to send an input. Within the prompt parentheses we can write a message that the user will see. Otherwise, he will see an empty message.

```javascript
let name = prompt('What is your name?');
let guess = prompt();           // blank prompt window
```

Note that:
- If the user clicks `Cancel` in the window `prompt` will return `null`
- It will always take the user's input as a string

Within `node` we need to use the packet `readlineSync` to get user input:
```javascript
const readlineSync = require("readline-sync");
readlineSync.prompt("This prompt works in Node!");
```

## Sending a message prompt with `alert()`

`alert()` displays an alert message with a button that says `OK`. The alert messages goes within its parentheses — or the message is empty and lacks a message.

## Loading debugging messages with `console.log()`

`console.log()` sends a message to the JavaScript console. This is typically for debugging — users tend not to check their JS console.

```javascript
let name = prompt('What is your name?');  // Input "Jose", return "undefined"

console.log('Hello, ' + name);            // Outputs "Hello, Jose", returns "undefined"
```

Why are `console.log()` actions different? Because when we change page the logs in the console remain in the console window whereas the return values of expressions and statement are reset and thus disappear.

# Primitive Type Coercions

Converting a primitive/native data type is called coercions or conversions. But as JS primitives are immutable it doesn't convert values — it return a new value of the proper type.

## String to Number

The `Number()` function turns strings to integers. If the string represents a valid integer it'll return that integer, otherwise it'll return `NaN` (not a number).
```javascript
> Number("1");
1
> Number("abc");
NaN
```

More specifically:
- `parseInt()` will return an integer value rounded down
- `parseFloat()` with return a floating-point format if the string is in float format

```javascript
> parseFloat("132", 10) // 10 is the optional `radix` argument, i.e. says it's base 10
132
> parseFloat("132.9")
132.9
> parseInt("132.9")
132
```

## Number to String

There are 3 ways:
- `String()` method and passing a number
- Calling the `toString()` method on a number
- Adding a number with an empty string `""`

`String` turns `Number` types into `String`
```javascript
> String(10);
"10"
> String(10.1);
"10.1"
```

Instead of calling the `String()` method and passing a number as an argument we can call the `toString` method on a number.

```javascript
(123).toString();        // "123"
(123.12).toString();     // "123.12"
```

We can also do this by adding an empty string with number.
```javascript
123 + '';                // "123"
'' + 123.12;             // "123.12"
```

BUT this last method is discouraged because it doesn't show as clear intention as the other ones!

## Booleans to Strings

Use either `String()`

```javascript
> String(true)
"true"
> String(false)
"false"
```

Or `toString()`
```javascript
> true.toString()
"true"
```

## Primitive to Booleans

Like Ruby, there isn't a direct conversion from string to boolean. Use comparison operators for that.

```javascript
"true" === "true"  // true
"false" === "true" // false
```

But a simpler way is using a double bang `!!` or `Boolean()` to get the value's boolean equivalent.

```javascript
Boolean(null);           // false
Boolean(NaN);            // false
Boolean(0);              // false
Boolean('');             // false
Boolean(false);          // false
Boolean(undefined);      // false
Boolean('abc');          // other values will be true
Boolean(123);            // true
Boolean('true');         // including the string 'true'
Boolean('false');        // but also including the string 'false'!

!!(null);                // false
!!(NaN);                 // false
!!(0);                   // false
!!('');                  // false
!!(false);               // false
!!(undefined);           // false

!!('abc');               // true
!!(123);                 // true
!!('true');              // true
!!('false');             // this is also true! All non-empty strings are truthy in JavaScript
```

# Implicit Primitive Type Coercions

An implicit type coercion are automatic type coercions that are implicit — e.g. `1 + true`. In most programming languages they'd return an error. Avoid these!

## + Operator

The unary plus operator converts a value to a number according to the `Number()` method
```javascript
+('123')        // 123
+(true)         // 1
+(false)        // 0
+('')           // 0
+(' ')          // 0
+('\n')         // 0
+(null)         // 0
+(undefined)    // NaN
+('a')          // NaN
+('1a')         // NaN
```

The unary `+` operator with 2 operands can mean addition for numbers or string concatenation. Thus, `+` converts the other operand to a string when the 2nd operand is a string or an object:
```javascript
'123' + 123     // "123123" -- if a string is present, coerce for string concatenation
123 + '123'     // "123123"
null + 'a'      // "nulla" -- null is coerced to string
'' + true       // "true"

[1] + 2                     // "12"
[1] + '2'                   // "12"
[1, 2] + 3                  // "1,23"
[] + 5                      // "5"
[] + true                   // "true"
42 + {}                     // "42[object Object]"
(function foo() {}) + 42    // "function foo() {}42"
```

When both operands are a combination of numbers, booleans, `null`s or `undefined`s they are converted to numbers and added:

```javascript
1 + true        // 2
1 + false       // 1
true + false    // 1
null + false    // 0
null + null     // 0
1 + undefined   // NaN
```
Though `1 + undefined` returns `NaN`, **`NaN` is considered to be a number.**

## Implicit Type and other Arithmetic Operators

Other operators are only for numbers — so JS converts operands to numbers

```javascript
1 - true                // 0
'123' * 3               // 369 -- the string is coerced to a number
'8' - '1'               // 7
-'42'                   // -42
null - 42               // -42
false / true            // 0
true / false            // Infinity
'5' % 2                 // 1
```

## Equality Operators

Strict equality operators never coerse operands.

Non-strict equality operators have rules for type coercion before comparing operands.

### Coersion for non-string equality operators

When 2 operands are compared non-strictly they're converted to the same type if they are of different types.

1. When an operand is a string and the other is a number, the string is converted to a number
2. When only one operand is a boolean it's converted to a number
3. `null` and `undefined` return `true` when compared `non-strictly`
```javascript
null == undefined      // true
undefined == null      // true
null == null           // true
undefined == undefined // true
undefined == false     // false
null == false          // false
undefined == ''        // false
undefined === null     // false -- strict comparison
```
4. If `NaN` is one of the operands it always returns `false`
```javascript
NaN == 0              // false
NaN == NaN            // false
NaN === NaN           // false -- even with the strict operator
NaN != NaN            // true -- NaN is the only JavaScript value not equal to itself
```

## Relational Operators

These comparison operators have no strict version. When an operand isn't a number it's converted to one:

```javascript
11 > '9'              // true -- '9' is coerced to 9
'11' > 9              // true -- '11' is coerced to 11
123 > 'a'             // false -- 'a' is coerced to NaN; any comparison with NaN is false
123 <= 'a'            // also false
true > null           // true -- becomes 1 > 0
true > false          // true -- also becomes 1 > 0
null <= false         // true -- becomes 0 <= 0
undefined >= 1        // false -- becomes NaN >= 1
```

# Best practices

1. Always use explicit type conversions
2. Always use strict equality operators to avoid implicit conversions

Do this *even if* if know the rules.


