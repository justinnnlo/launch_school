# `this`

## `this` as a value in an object
I would've expected the below code...

```javascript
const counter = {
  count: 0,
  advance: this,
};
```

...to be equivalent to something like...

```javascript
const counter = {
  count: 0,
  advance: [Object: counter],
};
```

...because within an object `this` refers to the object. However: it returns

```javascript
{ count: 0, advance: undefined }
```

Continuing with the above, if we change the `advance` method of the object to `console.log(this)`...

```javascript
const counter = {
  count: 0,
  advance: console.log(this),
};
```

...I would've expected that the value of `this` printed to the console would've been `undefined`.

However, an empty object `{}` is printed.

1. Why does `this` refer to an empty object if its context is the object pointed by `counter`?
2. If `this` references an empty object, why does the first version of `counter` with the property `advance: this` return `undefined` rather than `{}`?

## `this` in Node vs in a JS file

In Node.js, `this` returns the global object:
```javascript
console.log(this); // <ref *1> Object [global] {...}
```

But in a JavaScript file it returns an empty object.
```javascript
console.log(this); // {}
this.test = 'testing...';
console.log(this); // { test: 'testing...' }
```

# Global object as implicit context

We're told that the global object is the implicit context when we evaluate expressions. NOT using `let`, `var` or `const` implies that JS implicitly gives a variable when it's declared the global object as an implicit evaluation context.

```javascript
foo = 1;   // equivalent to window.foo = 1
foo;       // 1
window.foo // 1
this.foo   // 1
```

# Destructuring assignment

=> I still don't get this

Does anyone know why this works?

I get that it’s array deconstructing — I just don’t understand why that multiple assignment to change the variable values would work. As in, what’s the logical reason/process that allows this to work?
```javascript
let one = 1;
let two = 2;
[one, two] = [two, one];
one;  // 2
two;  // 2
```

Vahid Dejwakh (JS225)  5:00 AM
destructuring assignment

in the right operand, you’re creating an array that contains the values that `two` and `one` point to, and then you’re using destructuring reassignment to set `one` equal to the first element of this array, and `two` to equal the second element of the array

it’s the same reason why `one = one + 1`  works, or `one += 1`

```javascript
```

```javascript
```

```javascript
```