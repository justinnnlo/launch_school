# Quiz 1: Basics
4. A, B, C, D is true in the sense that NaN is a Number primitive
  - INCORRECT: C because primitive values don't necessarily have to be small and compound values don't necessarily have to be large
    - Detail in question: '**All** primitive value... than **all** compound value'

10. The first line returns `undefined` because statements always return `undefined`, whereas the other is an expression that returns the value that it evalautes to
  - Answer: C because D says that the return value of an expression is the value to the right of an operator (which isn't true, e.g. `1 + 2` returns `3` and not the value to the right of the operator, `2`)
  - INCORRECT: it's D because
    - i) C talked about the return value being the values assigned to the variable to its left (i.e. the varibale name)
    - ii) It says that the return value of an expression depends on its operator, **when there can be expression without operators**

# Quiz 2: functions and variable scope

5. No idea what lexical scoping is
  - Lexical scoping determines a variable's scope based on the code's structure
  - Lexical scoping is static scoping
    - I.e., is it a static language? As in variables are checked when they're compiled? Because if so, don't they need to declare the type of a variable when it's declared?
10. B and E
  - D. Expression because anonymous (note: can a ?)
    - WRONG: because it contains a function declaration *inside* an expression
    ```javascript
    const foo = function () {
      function bar() {};
    };
    ```
  - E. Declaration
    - WRONG: hypothesis to explain this — function declarations can't be assigned to a variable

# Quiz 3: arrays
3. A, B, C, D?
  - A is wrong: `sort` mutates the original array
  - D is wrong: `reverse` mutates the original array
  - `splice` and `filter` don't mutate!
5. C, D
  - B is wrong (previous trial): `indexOf` will always search front to back
  - C is wrong: `indexOf` returns `-1` when it isn't found

# Quiz 4: objects


6. Criteria of pure functions: uses its parameter, no side effects, isn't influenced by the rest of the program?
  - No because it depends on `currentTotal`?
    - Yes, as in **it relies on a function that isn't locally scoped**
      - Thus, using the same argument it may not return the same value as a previous invocation if `currentTotal` is reassigned