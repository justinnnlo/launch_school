# Conditionals

Conditionals are commands triggered when a condition is true. There are 2 conditionals: `if...else` and `switch`.

# `if...else`

```javascript
if ([condition]) {
  [block statements and expressions]
}
```

They can also have optional `else` or `else if` clauses:
```javascript
if (condition1) {
  // statements
} else if (condition2) {
  // statements
} else if (conditionN) {
  // statements
} else {
  // statements
}
```

`if` statements can also be nested within them.

# Truthy and Falsy

There are 6 possible falsey values
- `0`
- `NaN`
- `""`
- `false`
- `undefined`
- `null`

All other values are truthy. Thus, conditionals don't have to evalue strictly to `true` or `false`.

# `switch`

`switch` statements compare an expression against multiple `case` labels. When the expression matches the `case` label it executes the code:

```javascript
let reaction = "negative";

switch (reaction) {
  case "positive":
    console.log("Positive market sentiment");
    break;
  case "negative":
    console.log("Negative market sentiment");
    break;
  case "undeviced":
    console.log("Undecided market sentiment");
    break;
  default:
    console.log("TBC");
}
```

The switch statement will continue until it reaches the `default` clause (`else` in Ruby) `break` statement.

Note that we need a `break;` statement or the `switch` statement will "fall through" and evaluate the other `case` expressions as if all remaining `case` expressions were true!function stringToInteger(string) {
  let answer = 0;
  for (let i = 0; i < string.length; i += 1){
    answer += string[i] * 10 ** (string.length - 1 - i);
  }
  console.log(answer);
}

## Comparing values with `NaN`

`NaN` is the result of an illegal conversion to number, say `Number("a")` (curiously, `NaN` is type `Number`). The problem is that `NaN` returns `false`in every case — even if it's compared with itself.

```javascript
console.log(10 === NaN);     // false
console.log(10 < NaN);       // false
console.log(10 > NaN);       // false
console.log(NaN === NaN);    // false
```

`NaN` can be evaluated with the `Number.isNaN()` function. Alternatively, we can convert `NaN` to a string and make the comparison with the string `"NaN"`.

# Looping

We'll discuss 3 types of loops in JS that allow us to keep executing code:
- `while`
- `for`
- `until`

## `while`

```javascript
while (condition) {
  // statements
}
```

When the execution reaches the end of the `while` block it reavaluates the confition until it produces a falsy value.

Be careful of infinite loops! Besides good code logic, 2 tools to avoid this are:
- `break`: statement to exit a loop immediately
- `continue`: skips the current iteration and returns to the top of the loop

## `do...while`

This type of loop first iterates the `do` loop body and then evaluates the conditional. Thus, unlike `while` it executes at least once even if the conditional is falsy.

```javascript
let counter = 0;
let limit = 0;

do {
  console.log(counter);
  counter += 1;
} while (counter < limit);
```

## `for`

```javascript
for (initialExpression; condition; incrementExpression) {
  // statements
}
```

`for` loops typically use an `iterator` (`i`) variable, though it's best to use more descriptive terms when possible.

```javascript
for (let i = 0; i < 10; i += 1) {
  console.log(i);
}
```

The `for` loop executes in this order:
1. Executes the initialization statement (may include variable declarations)
2. Evaluate the condition, and end if it's falsy
3. Execute the body
4. Execute the increment expression
5. Return to step 2

However, we can skip any of the 3 components of the `for` statement:

```javascript
// put initialization outside of the loop

let index = 0;
for (; index < 10; index += 1) {
  console.log(index);
}

// manually check condition and break out of the loop
// If you omit the condition component in the "for", JavaScript assumes true

for (let index = 0; ; index += 1) {
  if (index >= 10) {
    break;
  }

  console.log(index);
}

// manually increment the iterator

for (let index = 0; index < 10; ) {
  console.log(index);
  index += 1;
}
```

```javascript
```

```javascript
```