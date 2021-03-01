// 1. I would've expected the below code

const counter = {
  count: 0,
  advance: this,
};

// to be equivalent to

const counter = {
  count: 0,
  advance: [Function: counter],
};

// Because within an object `this` refers to the object
// BUT: it returns

// { count: 0, advance: undefined }
