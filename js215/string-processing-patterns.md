JS has 2 built-in objects that can be used with Regular Expressions: `String` and `RegExp`.

RegExp objects store regex. Like other objects, RegExp objects can call methods.

- `String`
  - `String.prototype.search`
  - `String.prototype.match`
  - `String.prototype.replace`
- `String`
  - `RegExp.prototype.exec`
  - `RegExp.prototype.test`

|Method|Return|
|-|
|`String.prototype.search`|
|`String.prototype.match`|Array that describes matches|`/aeiou/.test('Hello')`|`['e', 'o']`|
|`String.prototype.replace`|String with replaced characters|`'Hello'.replace(/[aeiou]/g, '')`|`'Hll'`|
|`String`|
|`RegExp.prototype.exec`|
|`RegExp.prototype.test`|Boolean|`/aeiou/.test('Hello')`|`true`|

## Basic string methods

- `indexOf`
- `lastIndexOf`
- `replace`
- `split`
- `join`
- `substring`
- `toUpperCase`
- `toLowerCase`