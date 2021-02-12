const myObject = {
  prop1: '123',
  prop2: '234',
  'prop 3': '345',
};

const prop2 = '456';
myObject['prop2'] = '456';      // reassigns 'prop2' to '456'
myObject[prop2] = '678';      // '456' : '678'

console.log(myObject[prop2]);   // '678' because bracket notation interprets it as an expression that evaluates to '456'
console.log(myObject.prop2);    // '456' because prop2 is interpreted as the string 'prop2'
console.log(myObject)

// Lesson: objects can use non-strings as keys
// Bracket notation will put precedence on expressions over strings



const myObj = {};
myObj[myFunc()] = 'hello, ';

function myFunc() {
  return 'funcProp';
}

console.log(myObj);         // { funcProp: 'hello, '}
myObj[myFunc()] = 'world!'; // Reassigns to 'world!'
console.log(myObj);         //{ funcProp: 'world!'}



const myArray = ['a', 'b', 'c'];

console.log(myArray[0]);    // 'a'
console.log(myArray[-1]);   // undefined

myArray[-1] = 'd';          // '-1': 'd' => I think it coerses -1 to a string WRONG: it isn't
myArray['e'] = 5;           // 'e': 5
myArray[3] = 'f';           // 3: 'f'

console.log(myArray[-1]);   // undefined: treats -1 as index but it was coersed to string: WRONG — it works
console.log(myArray['-1']);
console.log(myArray['e']);  // 5
console.log(myArray);       // ['a', 'b', 'c', 'f', '-1': 'd', 'e': 5]

// Lesson: invalid index values are coerses to strings but are still accessible in their original daya type



const myArray = [5, 5];
myArray[-1] = 5;
myArray[-2] = 5;

function average(array) {
  let sum = 0;

  for (let i = -2; i < array.length; i += 1) {
    sum += array[i];
  }

  return sum / array.length;
}

average(myArray);    // 10

// Lesson: array elements with invalid index values will not count towards length or its built-in methods



// Roles (salary still to be determined)

const ceo = {
  tasks: ['company strategy', 'resource allocation', 'performance monitoring'],
  salary: 0,
};

const developer = {
  tasks: ['turn product vision into code'],
  salary: 0,
};

const scrumMaster = {
  tasks: ['organize scrum process', 'manage scrum teams'],
  salary: 0,
};

// Team -- we're hiring!

const team = {};

team["ceo"] = 'Kim';
team["scrumMaster"] = 'Alice';    // Bracket notation needs strings
team["developer"] = undefined;

const company = {
  name: 'Space Design',
  team: team,
  projectedRevenue: 500000,
};

console.log(team);
console.log(`----{ ${company.name} }----`);
console.log(`CEO: ${company.team["ceo"]}`);
console.log(`Scrum master: ${company.team["scrumMaster"]}`);
console.log(`Projected revenue: $${company.projectedRevenue}`);

// ----{ Space Design }----
// CEO: undefined
// Scrum master: undefined
// Projected revenue: $500000

// Object property names are always string!
// Dot notation coerses it into string
// Brackets coerse but also accept expression — as above where 'ceo' (not string) was interpreted as the constant



function penultimate(string) {
  let splitString = string.split(' ');
  return splitString[splitString.length - 2];
}

function penultimate(string) {
  return string.split(' ').splice(-2, 1)[0];
}

// Splice removes part of the array (mutating) and returns it
// Supports negative indexes (end of sequence offset): -1 is the last element



function penultimate(string) {
  return string.split(' ').slice(-2, -1)[0];
}

// Slice returns a subsection of the array (non-mutatin)
// Supports negative indexes (end of sequence offset): -1 is the last element

console.log(penultimate('last word'));                    // expected: "last"
console.log(penultimate('Launch School is great!'));      // expected: "is"

// Negative index notation in Arrays doesn't work in JS because Arrays are objects
// myArray[-1] tells JS: 'access the PROPERTY that has a key of "1" and return its value'



const array = ['Apples', 'Peaches', 'Grapes'];

array[3.4] = 'Oranges';                 // Invalid index
console.log(array.length);              // 3
console.log(Object.keys(array).length); // 4

array[-2] = 'Watermelon';               // Invalid index
console.log(array.length);              // 3
console.log(Object.keys(array).length); // 5

// Arrays can be thought of as special objects that have only non-negative integer values (from 0 up to 2 32 - 1) as keys
// They have an extra length property that keeps track of how many such key-value pairs exist in the object



var ruff_ryders = {
  dmx: {
    birthplace: "Mount Vernon, NY"
  }
}
console.log(ruff_ryders.lox.birthplace);  // TypeError
// Returns TypeError rather than undefined
// Why: equivalent to undefined.birthplace