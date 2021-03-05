function calculateBonus() {
  return arguments[1] ? arguments[0] / 2 : 0;
}

console.log(calculateBonus(2800, true));               // 1400
console.log(calculateBonus(1000, false));              // 0
console.log(calculateBonus(50000, true));              // 25000

// Lesson: arguments can be passed and accessed via the local variable `arguments`, an array-like structure even if no parameters are defined in the function definition



function one() {
  function log(result) {
    console.log(result);
  }

  function anotherOne(...args) {
    let result = '';
    for (let i = 0; i < args.length; i += 1) {
      result += String.fromCharCode(args[i]);
    }

    log(result);
  }

  function anotherAnotherOne() {
    console.log(String.fromCharCode(87, 101, 108, 99, 111, 109, 101));
    anotherOne(116, 111);
  }

  anotherAnotherOne();
  anotherOne(116, 104, 101);
  return anotherOne;
}

one()(77, 97, 116, 114, 105, 120, 33);
// one() calls the function, which returns the function anotherOne
// Therefore, one() is equivalent to anotherOne(77, 97, 116, 114, 105, 120, 33)
// Why: because anotherOne was passed without a pair of parentheses



// What does the following code print to the console?

var arr = ["boy", 42, 23, function () { return "gotta catch 'em all, Pokemon!" }, 56];

console.log(arr[3]());

// Functions are values and can be treated like any other value in JavaScript
// Functions can be assigned to variables, stored in arrays, etc
// arr[3] fetches the function object from the array and arr[3] invokes the function
// When a function is invoked the function's code block is executed



// What does the following code print to the console?

var lambchop = function () {
  "This is the song that never ends";
}
console.log(lambchop());

// lambchop() does not have a return statement, so nothing is returned



var result = function () { return "meow meow meow"; }();
console.log(result);        // 'meow meow meow'
console.log(typeof result); // 'string'

result = function () { return function test() ; }();
console.log(result);        // [Function: test]
console.log(typeof result); // 'function'

// Lesson: assignments with function expressions bind the variable to the return value of the function



let sally = {
  first_name: 'Sally',
  last_name: 'Gordon',
  full_name: () => this.first_name + ' ' + this.last_name,
}

console.log(sally.full_name()); // ReferenceError
// Arrow expressions don't have their own bindinds to `this` or `super`

let sally = {
  first_name: 'Sally',
  last_name: 'Gordon',
  full_name: function() {
    return this.first_name + ' ' + this.last_name;
  },
}

console.log(sally.full_name()); //'Sally Gordon'



// Defining constructor functions to create an object

function Mammal() {
  this.warm_blooded = true;
  this.scaly = false;
}

// Constructor functions need to be preceded by `new`
var fido = new Mammal();  // Mammal { warm_blooded: true, scaly: false }

// Creating the same object with literal object notation
var spot = {
  warm_blooded: true,
  scaly: false,
}

console.log(spot);        // { warm_blooded: true, scaly: false }

const conditional = () => {
  if ('') {
    return '';
  } else if (0) {
    return 0;
  }
}

const conditionalTwo = function () {
  if ('') {
    return '';
  } else if (0) {
    return 0;
  }
}()

console.log(conditional);     // Error
console.log(conditionalTwo);  // undefined
// Lesson: arrow functions aren't executed with () at the end of their definition