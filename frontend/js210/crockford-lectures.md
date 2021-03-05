# JS as an OOP

Is JS OOP or object-based language?

In JS **an object is a dynamic collection of properties** rather than an object as an instance of a class
- Every property has a key string unique within that object
  - If you add 2 properties with the same name the 2nd will replace the 1st one
- Funcamental operations: get, set and delete
  - Get: retirve property value
    - `object.name`
    - `object[expression]`
  - Set: set or update property value
    - `object.name = value`
    - `object[expression] = value`
  - Delete
    - `delete object.name`
    - `delete object[expression]`

A property is a named collection of attributes that *can all be set*
- Property value (any JS value)
- Boolean flags
  - Writeable (boolean): can the value be written?
  - Enumerable (boolean)
  - Configurable (boolean)
- get: can define a function returned when the object is get
- set: can define a function returned when the object is set

Object literals is an expressive notation for creating object:
```javascript
var myObject = { 'foo': 'bar'};
// Sets writeable, enumerable and configurable to true
```

## Classes vs Prototypes

Most languages use classes (classical languages). JS is class-free and uses prototypes.

- Prototypal code is smaller
- You can simulate a classical model with a prototypal model but not vice versa
- No classification of classes needed
  - Turns out to be a hard things to do

# Numbers

Most programming languages have many number types while JS has only 1. C and other languages of the old days had slow CPUs. Working with a smaller number was faster and cheaper. That meant small numbers could fit in more memory. But today memory is cheap — so it makes sense to make them big. Avoiding many types to represent numbers means avoiding error from picking the wrong type when you're programming.

One of the problem of numbers is that the associative law doesn't hold.
```javascript
// x + 1 = x for some large numbers
9007199254740992 + 1; // 9007199254740992
```

Because of binary floating point decimal fractions are more prone to breaking the associative law:
```javascript
// x + y != x + y for some decimals
0.1 + 0.2;                            // 0.30000000000000004

// Variation of this
0.1 + (0.2 + 0.3)                     // 0.6
0.1 + 0.2 + 0.3                       // 0.6000000000000001
0.1 + 0.2 + 0.3 === 0.1 + (0.2 + 0.3) // false

```
We can't accurately represent decimal points. Ideally: turn them into integers.

Numbers are objects in JS. As with most object, they have methods.

All number methods inherit from `Number.prototype`. All `prototype` are global structures available to all programs running on the same page — don't carelessly add methods to a `prototype`. Otherwise, in the future you might:
- Have to change your slow local method for the faster native version
- Have competing libraries trying to do the same thing

Numbers are first class objects, so they can:
- Be stored in a variable
- Passed as a parameter
- Be returned by a function
- Be stored in an object

The `Math` object was created to store methods and constants separately from number with the intention that if they didn't have to be used they didn't need to be included. (This like of thinking was inherited from Java). However, it has basic methods that will be routinely used to manipulate numbers.

- `NaN` is a special number: not a number
- `NaN` results of undefined or erroneous operations
- `NaN` doesn't equal anything, even `NaN === NaN` is `false`
- `5 * NaN` returns `NaN` rather than raise an error

A division of 2 integers can cause a non-integer result.

# Boolean

Type named after mathematitian George Boole

# String

- A sequence of **0** or more 16-bit Unicode characters
- Unicode allows **surrogate character** which are added for characters that aren't in Unicode but need to be used
  - Issue with JS: it'll let you use it but won't be aware
    - E.g.: a string with surrogate characters won't count its surrogate character like it doesn't count array elements with invalid index values
- No separate character type — characters are strings of length 1
- Strings are inmutable: they're frozen
- Similar strings are equal
  - Including: regardless of single or double quotes
- Multiline string literals: put a backslash `\` at the end of the line
  - AVOID A SPACE AFTER THE BACKSLASH
  - Best to avoid multiline literals as it can be hard to deterct error
- Numbers can be converted to strings with a number method `num.toString()` or String function `String(num)`
  - The method is stricter because some data types don't have `prototype.toString()`
    - `undefined.toString()` and `null.toString()` return `TypeError`
  - The function is more effective at *converting* data to a string
    - `String(undefined)` returns `'undefined'`

Converting strings to numbers is more tricky:
- `Number(string)` converts a string to Number primitive
- `parseInt(str, 10)` searches for string representation of numbers and converts it to Number UNTIL it finds a non-number string character
  - `parseInt('100 dollars are owed')` returns `100`
  - ALWAYS input the `radix` that represents the number system — it can incorrectly interpret the inputs
    - `parseInt("08")` is interpreted as `parseInt('0', '8')` — i.e. number system base 8
      - `parseInt('08')` returns `0`
      - `parseInt('08', 10)` returns `8`

AJAX libraries can normalize the libraries so the developer doesn't care what browser version is being used

# Array

Arrays are contiguous sequence of memory divided into equal size slots. You give its slots index numbers which are used for things like determining the array's length.

Arrays are the fastest data structure in most languages.

But JS doesn't have arrays — they have objects and it uses objects to simulate arrays. Array indexes are converted to strings and used as names to retrieve values. Every time you access an element in an array you have to do a hash lookup.

Conclusions: arrays are inefficient! However, there's no need to define the length of an array becuase you aren't setting aside memory — it grows dynamically.

Unlike objects, arrays have a special `length` accessor property. It's 1 larger than the highest integer property/non-negative index value in the array.

This system of integer indices allows us to us the traditional `for` loop statement. However, avoid `for in` with arrays because it doesn't guarantee the order it'll bring the items out!

- Array literals use `[]` and can contain any number of comma-separated expressions
- New items can be appended with `myList[myList.length] = 'item'`
  - In some languages this would raise an error because you're adding something beyond the end of the array
    - However, since arrays are really objects they don't have bounds and can grow dynamically

- `sort` by default can't sort numbers because it interprets them as strings!
  - Pass a function to make it work

Deleting elements
```javascript
myArray = ['a', 'b', 'c', 'd'];

// delete removes the property but left an undefined slot
delete myArray[1];    // ['a', undefined, 'c', 'd']

// splice does it but isn't fast because it has to rehash everything
myArray.splice(1, 1); // ['a', 'c', 'd']
```

# Objects

All values ar eobjects except `null` and `undefined`:
- `null`: value that isn't anything — indicates nothing
- `undefined`: default value for variables and parameters — value of missing members in objects

Arrays are type `object`. So to check if something is an array use the method `Array.isArray(obj)``.

# Falsey values
- `false`
- `null`
- `undefined`
- `''`
- `0`
- `NaN`

# Loosely Types

As a loosely types language, any JS type can be:
- Stored in a variable
- Passed as a parameter to any function

# Reference

- Objects are passed by reference as arguments to functions — not by value
- `===` compares object references — not their values

# C family language

- JS is syntactically a C family language, e.g. use of brackets
- Differs from C largely in its type system by making functions first-class objects

# Identifiers

[Start at 1:15:15 here if needed](https://www.youtube.com/watch?v=RO1Wnu-xKoY)

# Statements

- `break`
- `for``
  - `for (name in object)` iterates through all object members
- `switch`
  - Creates a multiway branch that compares values with `===`
  - Switch values can be a string unlike in other languages that force a number
  - **Case values can be expression**
  - Danger: cases fall through the next case unlessa disruptive statement like `break` ends the case
  - `default:` is the equivalent of `else` in Ruby
- `throw new Error(reasonOfError) creates exceptions
- `with` statements: avoid! Ambiguous and error-prone



# Talk #2

## What influenced JS?
- Self
  - Prototypal inheritance
  - Dynamic objects
- Java
  - Syntax: C family
  - Conventions
- Scheme
  - Lambda
  - Loose typing
- Perl
  - Regular expression notation

## Worse parts

- Global variables: names can collide and it has bad security (e.g. cross-site scripting)
- Semicolon insertion: compiler can do it wrong — so style isn't subjective! Use semicolons!
```javascript
return      // JS inserts a semicolon when it's compiled
{
  ok: false
};          // returns undefined

return {
  ok: false
}           // return false
```
- Long continuation...

## Good parts

- Lambda
- Dynamic objects
- Loose typing
- Object literals

## Inhertiance

Classical (class) vs prototypal schools.

Prototypal inheritance
- Class-free
- Objects inherit from objers
- An object contains a hidden link to another object through which it inherits stuff
  - Delegation (differential inheritance): each object only contains what makes it different from the object it inherits from
    - Implication: objects are smaller

## Closure
A function object contains
- Function
  - Name
  - Parameters
  - Body
- Closure/Context
  - Reference to the environment it was created