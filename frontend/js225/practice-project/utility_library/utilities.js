let _ = (function(element) {
  let u = {
    extend(oldObj, ...args) {
      // Mutates first object by adding properties of 2nd+ objects
      for (let i = 0; i < args.length; i += 1) {
        let keys = Object.keys(args[i]);
        for (let j = 0; j < keys.length; j += 1) {
          console.log(keys)
          oldObj[keys[j]] = args[i][keys[j]];
        }
      }
      return oldObj;
    },

    findWhere(array, obj) {
      // Return first object with all the matched properties
      // Else, return undefined
      // let objKeys = Object.keys(obj);
      // let objValues = Object.values(obj);

      // for (let i = 0; i < array.length; i ++) {
      //   let keys = Object.keys(array[i]);
      //   let values = Object.values(array[i]);
      //   if (matchValues(objKeys, keys) && matchValues(objValues, values)) {
      //     return array[i];
      //   }
      // }

      // return undefined;

      // function matchValues(arr1, arr2) {
      //   arr1 = arr1.slice().sort();
      //   arr2 = arr2.slice().sort();

      //   for (let i = 0; i < arr1.length; i ++) {
      //     if (arr1[i] !== arr2[i]) {
      //       return false;
      //     }
      //   }

      //   return true;
      // }
    },

    first(arg) {
      return arg[0];
    },

    has(obj, prop) {
      return Object.keys(obj).includes(prop);
    },

    isElement() {

    },

    isArray(arg) {
      return Array.isArray(arg);
    },

    isObject(arg) {
      return (typeof arg === 'object' || typeof arg === 'function');
    },

    isFunction(arg) {
      return typeof arg === 'function';
    },

    isBoolean(arg) {
      return typeof arg === 'boolean' || arg.constructor.name === 'Boolean';
    },

    isString(arg) {
      return typeof arg === 'string' || arg.constructor.name === 'String';
    },

    isNumber(arg) {
      return /[\d]/.test(arg) && typeof arg !== 'string';
    },

    keys(obj) {
      return Object.keys(obj);
    },

    last(arg) {
      return arg[arg.length - 1];
    },

    lastIndexOf(array, ele) {
      for (let i = array.length - 1; i >= 0; i -- ) {
        if (array[i] === ele) {
          return i;
        }
      }

      return -1;
    },

    omit() {

    },

    pick() {

    },

    pluck(array) {
      return array.map(obj => Object.values(obj)[0]);
    },

    range(...args) {
      let start = 0;
      let end;
      let result = [];

      if (args.length >= 2) {
        start = args[0];
        end = args[1];
      } else if (args.length === 1) {
        end = args[0];
      }
      for (let i = start; i < end; i++) {
        result.push(i);
      }

      return result;
    },

    sample() {

    },

    values(obj) {
      return Object.values(obj);
    },

    where() {
      //
    },

    without(arg, ...args) {
      return arg.filter(ele => !args.includes(ele) );
    },
  };

  return u;
})();

function matchValues(arr1, arr2) {
  arr1 = arr1.slice().sort();
  arr2 = arr2.slice().sort();

  for (let i = 0; i < arr1.length; i ++) {
    if (arr1[i] !== arr2[i]) {
      return false;
    }
  }

  return true;
}

// let dict = [{ foo: "bar", idx: 0 }, { foo: "baz", idx: 1 }, { foo: "bar", idx: 2 }];

// console.log(matchValues(Object.values(dict[0]), ['bar', 1]))
// console.log(_.findWhere(dict, { foo: "bar" }).idx === 0)
console.log(_.has({ foo: 'bar' }, 'foo'))
console.log(_.has({ foo: 'bar' }, 'fa'))
