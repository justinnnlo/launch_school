// Note to self: do results vary with strict mode?

// What is garbage collected and when?

let myNum = 1;

function foo() {
  let myStr = 'A string';
}

foo();

// What is a higher order and first-class function?
// Use examples



// What does the code below log?

a = 10;

console.log(window.a === a);

// What will the code below output?

function foo() {
  return this;
}

let context = foo();
console.log(context);

// What will the code below output?

let obj = {
  foo() {
    return this;
  },
};

let context = obj.foo();

console.log(context);

// What will the code below output?

let obj = {
  a: 'Amazebulous!',
};
let otherObj = {
  a: "That's not a real word!",
};

function foo() {
  console.log(this.a);
}

let bar = foo.bind(obj);

bar.call(otherObj);

// What will the code below output?

let TESgames = {
  titles: ['Arena', 'Daggerfall', 'Morrowind', 'Oblivion', 'Skyrim'],
  seriesTitle: 'The Elder Scrolls',
  listGames() {
    this.titles.forEach(function(title) {
      console.log(this.seriesTitle + ' ' + title);
    });
  }
};

TESgames.listGames();

// Note to self on above: in how many ways can the output be fixed?

// What is printed to the console?

function foo() {
  function bar() {
    function baz() {
      console.log(this);
    }

    baz();
  }

  bar();
}

foo();

// What is printed to the console?

let foo = {
  a: 1,
  bar() {
    console.log(this.baz());
  },

  baz() {
    return this;
  },
};

foo.bar();
let qux = foo.bar;
qux();


// // QUERY: why does this work in Node, but in this file line 24 doesn't print 2?

// let a = 1;
// let foo;
// let obj;

// function Foo() {
//   this.a = 2;
//   this.bar = function() {
//     console.log(this.a);
//   };
//   this.bar();
// }

// foo = new Foo();  // Execution context is new object; prints 2

// foo.bar();        // 2
// Foo();            // Creates global object property a to 2; prints 2

// obj = {};
// Foo.call(obj);    // Uses obj as the execution context, creating the a and bar properties. Prints 2
// obj.bar();        // 2

// console.log(global.a);
// console.log(this.a);  // Prints 2 as Foo() changed the global object
// console.log(global)

let RECTANGLE = {
  area() {
    return this.width * this.height;
  },
  perimeter() {
    return 2 * (this.width + this.height);
  },
};

function Rectangle(width, height) {
  this.width = width;
  this.height = height;
  this.area = RECTANGLE.area.apply(this);
  this.perimeter = RECTANGLE.perimeter.apply(this);
}

let rect1 = new Rectangle(2, 3);
console.log(rect1.area);
console.log(rect1.perimeter);


//Key: functions that don't exist raise error, not undefined

// let ninja;
// function Ninja() {
//   this.swung = true;
// }

// ninja = new Ninja();

// Ninja.prototype = {
//   swingSword: function() {
//     return this.swung;
//   },
// };  // Set the prototype property of the function Ninja to a new object

// console.log(ninja.swingSword());

let ninjaA;
let ninjaB;
function Ninja() {
  this.swung = false;
}

ninjaA = new Ninja();
ninjaB = new Ninja();

// WHy is this wrong? Why does it NEED dot notation?
Ninja.prototype[swing] = function() {
  this.swung = this.swung ? false : true;
  return this;
}

// Add a swing method to the Ninja prototype which
// returns the calling object and modifies swung

console.log(ninjaA.swing().swung);      // must log true
console.log(ninjaB.swing().swung);      // must log true


// create a new instance of an object, without having direct access to the constructor function

let ninjaA = (function() {
  function Ninja(){};
  return new Ninja();
})();

// create a ninjaB object
let ninjaB = new ninjaA.constructor()

// Why does this work? What's the relationship between constructors and prototypes? Are they the same?
ninjaB = Object.create(Object.getPrototypeOf(ninjaA));

// Could we do?
// let ninjaC = Object.create(ninjaB);
// console.log(ninjaC.constructor); => [Function: Ninja]
// console.log(ninjaC.constructor === ninjaB.constructor);

console.log(ninjaB.constructor === ninjaA.constructor);    // should log true


let shape = {
  getType() {
    return this.type;
  }
}

function Triangle(a, b, c) {
  Object.setPrototypeOf(this, shape);
  this.a = a;
  this.b = b;
  this.c = c;
  this.type = 'triangle';
}

shape.getPerimeter = function() {
  return this.a + this.b + this.c;
}

let t = new Triangle(3, 4, 5);
console.log(t.constructor);                 // Triangle(a, b, c)
console.log(t.constructor === Triangle);    // False => WHY????
console.log(shape.isPrototypeOf(t));        // true
console.log(t.getPerimeter());              // 12
console.log(t.getType());                   // "triangle"

// Write a constructor function that can be used with or without the new operator, and return the same result in either form

function User(first, last) {
  this.first = first;
  this.last = last;
  this.name = first + ' ' + last;
  return this;
}

let name = 'Jane Doe';
let user1 = new User('John', 'Doe');
let user2 = User('John', 'Doe');

console.log(name);         // => Jane Doe
console.log(user1.name);   // => John Doe
console.log(user2.name);   // => John Doe


function Dog() {
  Object.setPrototypeOf(this, prototype);
};

let prototype = {
  bark() {
    console.log('Bark!');
  },
};

let dog = new Dog();
console.log(dog instanceof Dog) // Why is this false?
                                // Topic: scope-safe constructors, OCP 11 Q2


// Create a function that can create an object with a given object as its prototype, without using Object.create

function createObject(obj) {
  // ...
}

let foo = {
  a: 1
};

let bar = createObject(foo);
foo.isPrototypeOf(bar);         // true