# Objects

JS is an object-oriented programming language. This means that JS as a program sues objects to organize code and data. Typically, objects bind data and behaviors.

JS has some built-in objects like:
- `String`
- `Object`
- `Array`
- `Math`
- `Date`

Some objects share the names of primitives (e.g. `String`) and some do not (e.g. `Array`). However, object and primitives that share names aren't the same. (The inverse exceptions are `null` and `undefined`: they're primitives without built-in objects).

- Primitive values can't theoretically call methods on them (e.g. length of string)
  - You can only call methods on the object data type

So what happens? JS *temporarily* coerses primitives to their object counterpart when it's necessary.

```javascript
let a = 'hi';                        // Create a primitive string with value "hi"
typeof a;                            // "string"; This is a primitive string value

let stringObject = new String('hi'); // Create a string object
typeof stringObject;                 // "object"; This is a String object

a.toUpperCase();                     // "HI"
stringObject.toUpperCase();          // "HI"

typeof a;                            // "string"; The coercion is only temporary
typeof stringObject;                 // "object"
```

# Creating custom objects

We can do this with in 3 ways:
1. Object literal notation:
  ```javascript
  let colors = {
    red: '#f00',
    orange: '#ff0',
    method1: function () {},
  };

  typeof colors;      // "object"
  colors.red;         // "#f00"
  colors.orange;      // "#ff0"
  ```
2. An object constructor function like `new String('foo')`
3. `Object.create` method

Note that multiline custom objects should use `,` in each line, even in the last one.

## Properties

Objects contain 2 things:
1. States (names and values)
  - Names: any valid string
  - Values: any valid expression
2. Behaviors (methods)

States are associations between names (or keys) and values. These associations are called **properties** or states.

To retrieve the value of a property we need to append the object with the property name as in `'hi'.length`, where `length` is the name of the property with value `2`. For custom objects, we don't seem to need to define getter and setter methods.

We can also set the value of a property with its name: e.g. `[1, 2, 3].length = 5;` modifies the array to create 2 empty items at the end of the array `[1, 2, 3, <2 empty items> ]` which now has a length of 5.

```javascript
let object = {
  a: 'hello',
  b: 'world',
  ab: 'hello world',
};

// Getting values
object.a;                 // "hello", dot notation
object['b'];              // "world", bracket notation
object.c;                 // undefined when property is not defined

// Setting values
object.a = 5;             // Reassigns the property a to value 5
object.a                  // 5

// Getting with expressions
object['a' + 'b']         // Bracket notation can take expressions
object('a' + 'b')         // SyntaxError: dot notation cannot take expressions
```

We can access a property value with either dot or bracket notation, but dot notation is highly preferred.

We can use the `delete` reserved keyword to delete properies.

```javascript
let object = {
  a: 'hello',
  b: 'world',
  ab: 'hello world',
};

delete object.a           // true
delete object.z           // true — even if the property doesn't exist!
object.a                  // undefined
object                    // { b: 'world', ab: 'hello world' }
```

## Stepping through Object properties

Objects are a collection type. A single object can store many values. So how can we perform a task for each element in an object?

```javascript
let object = {
  a: 'hi',
  b: 'there',
};

for (let name in object) {
  console.log(name);
  console.log(object[name]);
}

// logs:
a
hi
b
there
```

Key insight: `let name in object` allows us to use `name` as a placeholder to iterate through object property names.

Alternatively, we can use the `Object.keys(obj)` method to retrieve all of the names to an array.

```javascript
let object = {
  a: 'hi',
  b: 'there',
};

Object.keys(object)       // ['a', 'b']
```


## Methods

Functions define the behavior of an object. Methods are functions bound with an object. Methods are accessed by appending them to the object via dot notation. They're accessed as properties because **methods are properties**.

Sample method calls:
```javascript
(5.234).toString();       // "5.234"
'pizza'.match(/z/);       // [ "z", index: 2, input: "pizza" ]
Math.ceil(8.675309);      // 9
Date.now();               // 1467918983610
```

## Compact method notation

Traditionally, we'd have needed to write the property name, colon and full function expression.

```javascript
let myObj = {
  foo: function (who) {
    console.log(`hello ${who}`);
  },

  bar: function (x, y) {
    return x + y;
  },
};
```

This can be simplified with the compact method notation that allows us to omit the colon and `function`. Use this form — it's easier to read.

```javascript
let myObj = {
  foo(who) {
    console.log(`hello ${who}`);
  },

  bar(x, y) {
    return x + y;
  },
};
```

### Arrow functions and methods

Arrow functions have subtle behaviors. These behaviors means that it's a poor idea to bind a method to an arrow function. However, an arrow function can be placed within the method body.

## Capitalization

- Primitive type: use lowercase names like `string` and `boolean`
- Object form of a primitive type: capitalize them `String`, `Boolean`, etc.
- `object` refers to objects in general, `Object` to methods and properties of the `Object` class
  - E.g. `array` refers to array objects,  `Array` to the class, methods and properties
- Prototype objects should have capitalized names
  - `new Date()` instead of `new date()`

```javascript
```

```javascript
```

```javascript
```