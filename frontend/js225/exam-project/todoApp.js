const Todo = (() => {
  let counter = 0;

  function generateId() {
    return counter += 1;
  }

  return {
    init(title, month, year, description) {
      this.id = generateId();
      this.completed = false;

      this.title = String(title);
      this.month = String(month);
      this.year = String(year);
      this.description = String(description);

      return this;
    },

    isWithinMonthYear(month, year) {
      let onlyDigits = /^\d+$/;
      return this.month === String(month) && onlyDigits.test(this.month) && this.year === String(year) && onlyDigits.test(this.year);
    },
  };
})();

let todo1 = Object.create(Todo).init('Buy Milk', '1', '2017', 'Milk for baby');
let todo2 = Object.create(Todo).init('Buy Milk', '', '2017', 'Milk for baby');
let todo3 = Object.create(Todo).init(undefined, null, '2017', 'Milk for baby');
let todo4 = Object.create(Todo).init(undefined, null, '2017');

console.log(todo1);
// { id: 1, completed: false, title: 'Buy Milk', month: '1', year: '2017', description: 'Milk for baby'}
console.log(todo2);
// { id: 2, completed: false, title: 'Buy Milk', month: '', year: '2017', description: 'Milk for baby'}
console.log(todo3);
// { id: 3, completed: false, title: 'undefined', month: 'null', year: '2017', description: 'Milk for baby'}
console.log(todo4);
// { id: 4, completed: false, title: 'undefined', month: 'null', year: '2017', description: 'undefined'}

console.log(todo1.isWithinMonthYear('1', '2017'));  // true
console.log(todo1.isWithinMonthYear(1, 2017));      // true
console.log(todo2.isWithinMonthYear('1', '2017'));  // false
console.log(todo2.isWithinMonthYear(1, 2017));      // false
console.log(Object.getPrototypeOf(todo1) === Todo); // true

const todoList = (function() {
  let todos = [];

  function isTodo(element) {
    return Object.getPrototypeOf(element) === Todo;
  }

  function shallowCopyObject(obj) {
    if (typeof obj === 'object') {
      let emptyTodo = Object.create(Todo);
      return Object.assign(emptyTodo, obj);
    }

    return false;
  }

  function shallowCopyTodoList() {
    return todos.map(obj => shallowCopyObject(obj));
  }


  function getObject(todoID) {
    for (let index = 0; index < todos.length; index ++) {
      if (todos[index].id === todoID) {
        return todos[index];
      }
    }

    return false;
  }

  function updateObject(todo, key, value) {
    if (key === 'completed' && typeof value !== 'boolean') {
      return;
    } else {
      todo[key] = key === 'completed' ? value : String(value);
    }
  }

  return {
    init(array) {
      todos = array;
      return this;
    },

    addTodo(element) {
      if (isTodo(element)) {
        todos.push(element);
      }

      return this.getAllTodos();
    },

    delete(todoID) {
      let object = getObject(todoID);

      if (object) {
        todos.splice(todos.indexOf(object), 1);
      }

      return this.getAllTodos();
    },

    update(todoID, object) {
      let todo = getObject(todoID);

      if (todo) {
        const validProperties = ['completed', 'title', 'month', 'year', 'description'];
        const objectKeys = Object.keys(object);

        for (let index = 0; index < objectKeys.length; index ++) {
          if (validProperties.includes(objectKeys[index])) {
            let key = objectKeys[index];
            let value = object[key];

            updateObject(todo, key, value);
          }
        }
      }

      return this.getAllTodos();
    },

    fetchTodo(todoID) {
      return shallowCopyObject(getObject(todoID));
    },

    getAllTodos() {
      return shallowCopyTodoList();
    },
  };
})();

let todoArray = [todo1, todo2, todo3, todo4];

todoList.init(todoArray);

console.log(todoList.getAllTodos());                                  // Logs array with 4 todos
console.log(todoList.getAllTodos() === todoArray);                    // false
console.log(todoList.getAllTodos() === todoList.getAllTodos());       // false

console.log(todoList.fetchTodo(1));                                   // Logs array of id 1
console.log(todoList.fetchTodo(1) === todo1);                         // false
console.log(todoList.fetchTodo(10));                                  // false

let emptyTodo = Object.create(Todo).init();
console.log(todoList.addTodo(emptyTodo));
// Logs array with the empty todo as the last item

console.log(todoList.addTodo({}));
// Logs array as the previous log — no object added because the argument wasn't a `todo`

console.log(todoList.getAllTodos() === todoList.getAllTodos())        // false
console.log(todoList.getAllTodos()[0] === todoList.getAllTodos()[0])  // false
// This method returns unique, shallowlly copied arrays and objects

let newProperties = {
  id: 100,
  completed: true,
  title: 'My updated todo',
  month: 3,
  year: 2021,
  description: 'This has updated!',
};

console.log(todoList.update(5, newProperties));
// Logs array with all of the last todo's properties modified except its id
// All modified values are strings except 'completed', which is a boolean,

todoList.update(5, {});
// Return array with all of the last todo's properties unchanged

todoList.update(10, {});
todoList.update('10', {});
todoList.update(5, { completed: 'bananas'} );
// All 3 return the array with unchanged values

todoList.delete(10);
// Return array with unchanged values
console.log(todoList.delete(2));
// Logs array with the todo with id 2 removed

const todoManager = {
  allTodos(todoList) {
    return todoList.getAllTodos();
  },

  completedTodos(array) {
    if (array === todoList) {
      array = this.allTodos(todoList);
    }

    return array.filter(obj => obj.completed);
  },

  isWithinMonthYear(array, month, year) {
    if (array === todoList) {
      array = this.allTodos(todoList);
    }

    return array.filter(obj => obj.isWithinMonthYear(month, year));
  },

  isCompletedAndWithinMonthYear(array, month, year) {
    let completedTodos = this.completedTodos(array);
    return this.isWithinMonthYear(completedTodos, month, year);
  }
}

todoList.update(4, {month: 3, year: 2021});

let allTodos = todoManager.allTodos(todoList);
// allTodos is an array with shallow copied objects

console.log(allTodos);
// Logs all the todo objects: i.e. ids 1, 3, 4, 5
allTodos.constructor === Array;
// Returns true as it's a standard array
console.log(Object.getPrototypeOf(allTodos[0]) === Todo);
// Logs `true` as objects are `todo` objects to `Todo` as prototype

console.log(todoManager.completedTodos(allTodos));
console.log(todoManager.completedTodos(todoList));
// Both log objects with id 5
// Can handle both an array of todo objects or the todoList object

console.log(todoManager.isWithinMonthYear(allTodos, '1', '2017'));
// Logs object with id 1
console.log(todoManager.isWithinMonthYear(allTodos, 'null', '2017'));
// Logs empty array

console.log(todoManager.isWithinMonthYear(allTodos, '3', '2021'));
// Logs object with id 4, 5
console.log(todoManager.isCompletedAndWithinMonthYear(allTodos, '3', '2021'));
// Logs object with id 5
