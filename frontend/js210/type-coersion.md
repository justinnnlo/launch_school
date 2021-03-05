There are 3 types of coersion in JS:
- To string
- To number
- To boolean

Primitives and objects have different coersion logic but both can only be coersed in those 3 ways.

# String conversion
All primitives are converted to strings as you'd expect

```javascript
String(-12.3)                 // '-12.3'
String(null)                  // 'null'
String(undefined)             // 'undefined'
String(true)                  // 'true'
String(false)                 // 'false'
String(Symbol('my symbol'))   // 'Symbol(my symbol)'
```

Note that `Symbol` primitives can only be converted via explicit type coersion
```javascript
'' + Symbol('my symbol')      // TypeError is thrown
```

# Boolean conversion
The `Boolean()` function explicitly coerses values to a boolean. Implicitly, it's done via logical operators like `||`,  `&&` and `!`.

Note that unlike `!`, `||` and `&&` coerse values into booleans internally but return the original values — regardless of whether they're `true` or `false`.
```javascript
0 && 5      // 0
false || 1  // 1
```

The only values that are falsy are:
- `0`
- `NaN`
- `''`
- `undefined`
- `null`
- `false`

# Numeric conversion

## String to number
1. Trim leading and trailing whitespace, `\n`, `\t` characters
2. Return
  - `NaN` if  the trimmed string isn't a valid number (includes `undefined`)
  - `0` if the string is empty or is `null`

# List of coersion table
[See here](https://dorey.github.io/JavaScript-Equality-Table/)