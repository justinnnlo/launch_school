// Section 1: scopes, hoisting, and variables

let counter = 5;
let rate = 3;

function counter(count) {
  // ...
}

console.log('The total value is ' + String(counter * rate));  // 15

// WRONG: declaring a variable with `let` also raises an error if a function with the same name is declared



let startingBalance = 1;
const chicken = 5;
const chickenQuantity = 7;

function totalPayable(item, quantity) {
  return startingBalance + (item * quantity);
}

startingBalance = 5;
console.log(totalPayable(chicken, chickenQuantity));  // 40

startingBalance = 10;
console.log(totalPayable(chicken, chickenQuantity));  // 45

// Closure retains access to the variable — not the variable's object.



const languages = ['JavaScript', 'Ruby', 'Python'];
console.log(languages);           // ['JavaScript', 'Ruby', 'Python']
console.log(languages.length);    // 3

languages.length = 4;             // Error: can't modify a constant
console.log(languages);           // ['JavaScript', 'Ruby', 'Python']
console.log(languages.length);    // 3

languages.length = 1;             // Can't modify a constant
console.log(languages);           // ['JavaScript', 'Ruby', 'Python']
console.log(languages.length);    // 3

languages.length = 3;             // Error
console.log(languages);           // ['JavaScript', 'Ruby', 'Python']
console.log(languages.length);    // 3

languages.length = 1;             // Error
languages[2] = 'Python';          // Error
console.log(languages);           // ['JavaScript', 'Ruby', 'Python']
console.log(languages[1]);        // 'Ruby'
console.log(languages.length);    // 3

// Why my analysis is wrong: a constant can't be reassigned but if it points to an object it can be mutated



let a = 'outer';

function testScope() {
  let a = 'inner';
  console.log(a);
}

console.log(a);   // outer
testScope();      // inner
console.log(a);   // outer

// Lesson: i) variable shadowing and ii) block scopes for let



let a = 'outer';

function testScope() {
  a = 'inner';
  console.log(a);
}

console.log(a); // outer
testScope();    // inner
console.log(a); // inner

// Lessons: i) block scopes are leaky



let basket = 'empty';

function goShopping() {
  function shop1() {
    basket = 'tv';
  }

  console.log(basket);

  let shop2 = function() {
    basket = 'computer';
  };

  const shop3 = () => {
    let basket = 'play station';
    console.log(basket);
  };

  shop1();  // reassigns to "tv"
  shop2();  // reassigns to "computer"
  shop3();  // declares new basket variable and prints "play station"

  console.log(basket);  // computer
}

goShopping(); // "empty"; "play station"; "computer"

// Lesson: i) variable shadowing in inner block scopes ii) variable reassignment when in scope



function hello() {
  a = 'hi';
}

hello();
console.log(a); // "hi"

// Lesson: variables assigned without being declared become global variables — as if declaring a in the global scope and assigning in an inner scope
// "without an explicit declaration, a becomes a property of the global object"



function hello() {
  let a = 'hello';
}

hello();
console.log(a); // ReferenceError

// Lesson: i) undeclared vs declared variables, ii) calling an undeclared variable



console.log(a);

var a = 1;

// Lessons: i) variables are hoisted and ii) variables declared with var return undefined when declared but unassigned



console.log(a); // ReferenceError: a is unassigned

let a = 1;

// Lessons: i) variables are hoisted and ii) variables declared with let return ReferenceError when declared but unassigned because they're bound to the value/concept of "unset" != undeclared



console.log(a);   // ReferenceError

function hello() {
  a = 1;
}

// Lesson: i) functions that aren't executed are as if their code wasn't run, ii) global variables don't save themselves from this situation
// Why this could be wrong (IT ISN'T): a is hoisted at the global scope because it's undeclared



function say() {
  if (false) {
    var a = 'hello from inside a block';
  }

  console.log(a); // 'undefined' because a is hoisted but the assignment isn't executed
}

say();

// Lesson: variables declared with var have a functional scope



function say() {
  if (false) {
    let a = 'hello from inside a block';
  }

  console.log(a); // ReferenceError: a doesn't exist
}

say();

// Lesson: variables declared with let have a block scope



function hello() {
  a = 'hello';
  console.log(a);

  if (false) {
    var a = 'hello again';
  }
}

hello();
console.log(a);

// Lesson: hoisting precedes variable assignment and can change variable behavior



function hello() {
  a = 'hello';    // Global scope as no hoisting in this block scope
  console.log(a); // "hello"

  if (false) {
    let a = 'hello again';
  }
}

hello();        // prints hello
console.log(a); // prints hello

// Lesson: functional vs block scope rules



var a = 'hello';

for (var index = 0; index < 5; index += 1) {
  var a = index;
}

console.log(a); // 4

// Lesson: a variable can be declared with var multiple times without an error



let a = 'hello';

for (let index = 0; index < 5; index += 1) {
  let a = index;  // Doesnt affect a in the upper scope bc of variable shadowing
}

console.log(a); // "hello"

// Lesson: i) loops reset their scopes in each iteration, ii) block scope rules



let a = 1;

function foo() {
  a = 2;        // Reassigns a
  let bar = function() {
    a = 3;      // Reassign a
    return 4;   // Returns 4
  };

  return bar(); // Returns 4
}

console.log(foo()); // Prints 4
console.log(a);     // Prints 3

// Lesson: variables can be reassigned in inner scopes



var a = 'global';

function checkScope() {
  var a = 'local';        // Creates new a variable in this scope
  const nested = function() {
    var a = 'nested';     // Creates new a variable in this scope
    let superNested = () => {
      a = 'superNested';  // Reassigns a defined in the nested function scope bc it's the closest function
      return a;           // Returns superNested
    };

    return superNested(); // Returns superNested
  };

  return nested();        // Returns superNested
}

console.log(checkScope());  // Prints superNested
console.log(a);             // Prints global

// Lessons: variable reassignment happens in the nearest stack frame where a variable of that name is found



let a = 'outer';
let b = 'outer';

console.log(a); // outer
console.log(b); // outer
setScope(a);
console.log(a); // outer
console.log(b); // inner

function setScope(foo) {
  foo = 'inner';
  b = 'inner';
}

// Lesson: function parameters are local variables



let total = 50;
let increment = 15;

function incrementBy(increment) {
  total += increment;
}

console.log(total);     // PRINTS 50
incrementBy(10);        // 60
console.log(total);     // PRINTS 60
console.log(increment); // PRINTS 15

// Lesson: variable reassignment in different scope



let a = 'outer';

console.log(a); // outer
setScope();     // ReferenceError: variable setScope is hoisted but not assigned to the variable expression
console.log(a);

var setScope = function () {
  a = 'inner';
};

// Lesson: while functions are hoisted with their bodies functional expressions aren't hoisted with their variable names



console.log(foo());             // Prints undeclared, which is the value returned by foo because it doesn't provide return with a value

function foo() {
  console.log('Waiting for bar!');
}

function foo() {
  console.log(foo);             // Prints: [Function: foo] => foo is in scope within itself!
  function bar() {
    console.log('bar again');
  }

  bar();                        // Prints 'bar again and again' because both bar functions are hoisted but the last one is used

  function bar() {
    console.log('bar again and again');
  }
}

// Lessons:
// i) functions can be declared multiple times without raising an error
// ii) If a function is declared multiple times, the last one is used
// iii) A function is in scope within itself
// iv) A function without parentheses returns [Function: functionName]


const species = ['wolf', 'human', 'wasp', 'squirrel', 'weasel', 'dinosaur'];
const isMidnight = true;
const isFullmoon = true;

function isTransformable(species) {
  return species[0] === 'w';
}

function transform(species) {
  return `were${species}`;
}

for (let i = 0; i < species.length; i++) {
  const thisSpecies = species[i];
  let newSpecies;

  if (isMidnight && isFullmoon && isTransformable(thisSpecies)) {
      newSpecies = transform(thisSpecies);
  }

  if (newSpecies !== undefined) {
    console.log(`Beware of the ${newSpecies}!`);
  }
}

// Let resets its scope in each for loop iteration because it has the scope of the block/loop, whereas var doesn't because it has a functional scope.



const totalPages = 364;
let energy = 100;

function read() {
  let currentPage = 1;

  while (energy > 0 && currentPage <= totalPages) {
    currentPage += 1;
    energy -= (5 + currentPage * 0.1);
  }

  console.log(`Made it to page ${String(currentPage)}.`);

  // Drink a cup of coffee.
  energy = 100;

  // Continue reading.
  if (currentPage <= totalPages) {
    read();
  } else {
    console.log('Done!');
  }
}

read();