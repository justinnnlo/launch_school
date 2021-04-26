class Model {

  constructor() {
    this.todos = [];
    this.context = { title: 'All Todos', data: }
  }

  addTodo(obj) {
    this.assignDueDate(obj);
    this.todos.push(obj);
  }

  assignDueDate(obj) {
    if (!!obj.month && !!obj.year) {
      obj.due_date = obj.month + '/' + obj.year.slice(2);
    } else {
      obj.due_date = 'No Due Date';
    }
  }

  deleteTodo(id) {
    this.todos = this.todos.filter(obj => obj.id !== id);
  }

  updateTodo(obj, id) {
    const index = this.todos.findIndex(obj => obj.id === Number(id));
    obj.id = id;
    this.assignDueDate(obj);
    this.todos[index] = obj;
  }

  getTodo(id) {
    return this.todos.filter(obj => obj.id === id)[0];
  }

  completedTodos() {
    return this.todos.filter(obj => obj.completed);
  }

  groupedByDate(array) {
    const temp = {};

    array.forEach(obj => {
      if (!!temp[obj.due_date]) {
        temp[obj.due_date].push(obj);
      } else {
        temp[obj.due_date] = [obj];
      }
    });

    return temp;
  }

  startWithNoDueDate(temp, result, keys) {
    if (keys.includes('No Due Date')) {
      result["No Due Date"] = temp["No Due Date"];
      keys = keys.filter(key => key !== "No Due Date");
    }
  }

  orderByDate(temp) {
    let keys = Object.keys(temp);
    const result = {};

    this.startWithNoDueDate(temp, result, keys);
    this.sortKeysByDate(keys);

    keys.forEach(key => result[key] = temp[key]);
    return result;
  }

  sortKeysByDate(keys) {
    return keys.sort((a, b) => Number(a.split('/')[1]) - Number(b.split('/')[1])).sort((a, b) => {
      const yearA = Number(a.split('/')[1]);
      const yearB = Number(b.split('/')[1]);
      const monthA = Number(a.split('/')[0]);
      const monthB = Number(b.split('/')[0]);

      if (yearA - yearB === 0) {
        return monthA - monthB;
      } else {
        return yearA - yearB;
      }
    });
  }

  groupAndOrderByDate(array) {
    const temp = this.groupedByDate(array);
    return this.orderByDate(temp);
  }

  setDefaultContext(context) {
    if (context === undefined) {
      return { title: 'All Todos' };
    } else {
      return context;
    }
  }

  setSelectedTodos(context, allOrderedTodos) {
    if (context.title === 'All Todos') {
      return this.todos;
    } else if (context.title === 'Completed') {
      return this.todos.filter(obj => obj.completed);
    } else if (!!context.id) {
      return allOrderedTodos[context.title].filter(obj => obj.completed);
    } else {
      return allOrderedTodos[context.title];
    }
  }

  todoData(context) {
    const allOrderedTodos = this.groupAndOrderByDate(this.todos);
    console.log(context)
    context = this.setDefaultContext(context);
    console.log(context)
    const selectedTodos = this.setSelectedTodos(context, allOrderedTodos) || [];
    const sortedTodos = selectedTodos.sort(obj => obj.completed === true);
    context.data = selectedTodos.length;

    return {
      todos: this.todos.length,
      todos_by_date: allOrderedTodos, // All todos
      done: this.completedTodos().length,
      done_todos_by_date: this.groupAndOrderByDate(this.completedTodos()), // All completed todos
      current_section: context,
      selected: sortedTodos,
    }
  }

  toggleCompleted(obj) {
    if (obj.completed) {
      obj.completed = false;
    } else {
      obj.completed = true;
    }
  }
}

class View {
  constructor() {
    this.setCompilation();
  }

  setProperties() {
    this.addTodo = document.querySelector('label[for="new_item"]');
    this.modalLayer = document.getElementById('modal_layer');
    this.modalForm = document.getElementById('form_modal');
    this.saveButton = document.querySelector('input[value="Save"]');
    this.completeButton = document.querySelector('button[name="complete"]');
    this.form = document.querySelector('form');
    this.allTodosHeader = document.querySelector('section#all header');
    this.sidebar = document.getElementById('sidebar');
    this.allTodosSection = document.getElementById('all');
    this.completedTodosSection = document.getElementById('completed_items');
  }

  setCompilation() {
    const mainTemplate = document.getElementById('main_template');
    const allTodosTemplate = document.getElementById('all_todos_template').innerHTML;
    const allListTemplate = document.getElementById('all_list_template').innerHTML;
    const completedTodosTemplate = document.getElementById('completed_todos_template').innerHTML;
    const completedListsTemplate = document.getElementById('completed_list_template').innerHTML;
    const titleTemplate = document.getElementById('title_template').innerHTML;
    const itemsTemplate = document.getElementById('item_partial').innerHTML;
    const listTemplate = document.getElementById('list_template').innerHTML;

    Handlebars.registerPartial({
      'all_todos_template': allTodosTemplate,
      'all_list_template': allListTemplate,
      'completed_todos_template': completedTodosTemplate,
      'completed_list_template': completedListsTemplate,
      'title_template': titleTemplate,
      'list_template': listTemplate,
      'item_partial': itemsTemplate,
    });

    this.compilation = Handlebars.compile(mainTemplate.innerHTML);
  }

  resetUi(data, context) {
    document.body.innerHTML = this.compilation(data);
    this.setProperties();
    this.setSidebarActive(context);
  }

  existingTodoForm(obj) {
    this.modalLayer.style = 'display: block';
    this.modalForm.style = 'display: block';

    this.modalForm.querySelector('#title').value = obj.title;
    this.modalForm.querySelector('#day').value = obj.day;
    this.modalForm.querySelector('#month').value = obj.month;
    this.modalForm.querySelector('#year').value = obj.year;
    this.modalForm.querySelector('textarea').value = obj.description;
  }

  resetForm() {
    this.form.reset();
    this.form.dataset.id = '';
  }

  setSidebarActive(context) {
    if (context === undefined) {
      this.allTodosHeader.classList.add('active');
    } else {
      if (!context.id) {
        var node = document.querySelector(`dl[data-title="${context.title}"]`);
      } else {
        var node = document.getElementById(context.id);
      }
      node.classList.add('active');
      // TypeError: null is not an object (evaluating 'node.classList')
    }
  }
}

class Controller {
  constructor(model, view) {
    this.model = model;
    this.view = view;
    this.startUpApp();
  }

  setListeners() {
    this.modalListeners();
    this.formListener();
    this.addOrUpdateTodoListener();
    this.tableListener();
    this.completeButtonListener();
    this.sidebarListener();
  }

  startUpApp() {
    const request = new XMLHttpRequest();
    request.open('GET', '/api/todos');
    request.responseType = 'json';
    request.addEventListener('load', () => {
      request.response.forEach(obj => this.model.addTodo(obj));
      this.handleResetUi();
    });

    request.send();
  }

  handleResetUi(context) {
    this.view.resetUi(this.model.todoData(context), context);
    this.setListeners();
  }

  handleAddTodo(obj) {
    const request = new XMLHttpRequest();
    request.open('POST', '/api/todos');
    request.setRequestHeader('Content-Type', 'application/json');
    request.addEventListener('load', event => {
      if (request.status === 201) {
        const response = JSON.parse(request.response);
        this.model.addTodo(response);
        this.handleResetUi();
      } else if (request.status === 400) {
        alert(request.response);
      }
    });

    request.send(JSON.stringify(obj));
  }

  modalListeners() {
    this.view.addTodo.addEventListener('click', event => {
      this.view.modalLayer.style = 'display: block';
      this.view.modalForm.style = 'display: block';
    });

    this.view.modalLayer.addEventListener('click', event => {
        this.view.resetForm();
        this.view.modalLayer.style = 'display: none';
        this.view.modalForm.style = 'display: none';
    });
  }

  tableListener() {
    // How could this improve?
    // Limited by HTML design and different logic for transversing DOM
    const table = document.querySelector('table');

    table.addEventListener('click', event => {
      event.preventDefault();

      const nodeName = event.target.nodeName;
      const title = document.querySelector('#items time').innerText;
      const context = { title: title };

      // Need to add the context when deleting!
      if (event.target.classList.contains('delete')) {
        const id = Number(event.target.parentNode.dataset.id);
        this.handleDelete(id, context);
      } else if (nodeName === 'IMG') {
        const id = Number(event.target.parentNode.parentNode.dataset.id);
        this.handleDelete(id, context);
      } else if (nodeName === 'LABEL' || nodeName === 'INPUT') {
        const id = Number(event.target.parentNode.parentNode.dataset.id);
        const obj = this.model.todos.filter(obj => obj.id === id)[0];
        this.view.form.dataset.id = id;
        this.view.existingTodoForm(obj);
      } else if (nodeName === 'TD') {
        const id = Number(event.target.parentNode.dataset.id);
        const obj = this.model.getTodo(id);
        this.model.toggleCompleted(obj);
        this.handleUpdateTodo(obj, id, context);
      } else if (nodeName === 'SPAN') {
        const obj = this.model.getTodo(id);
        const id = Number(event.target.parentNode.parentNode.dataset.id);
        this.model.toggleCompleted(obj);
        this.handleUpdateTodo(obj, id, context);
      }
    });
  }

  formListener() {
    this.view.form.addEventListener('submit', event => {
      event.preventDefault();
    });
  }

  addOrUpdateTodoListener(id) {
    this.view.saveButton.addEventListener('click', event => {
      const formData = new FormData(this.view.form);
      const obj = Object.fromEntries(formData);
      const id = Number(this.view.form.dataset.id);

      if (!!id) {
        this.handleUpdateTodo(obj, id);
      } else {
        this.handleAddTodo(obj);
      }
    }, true);
  }

  handleUpdateTodo(obj, id, context) {
    const request = new XMLHttpRequest();
    request.open('PUT', `/api/todos/${id}`);
    request.setRequestHeader('Content-Type', 'application/json');
    request.addEventListener('load', event => {
      if (request.status === 200) {
        const response = JSON.parse(request.response);
        this.model.updateTodo(response, response.id);
        this.handleResetUi(context);
      } else if (request.status === (400 || 404)) {
        alert(request.response);
      }
    });

    request.send(JSON.stringify(obj));
  }

  handleDelete(id) {
    const title = document.querySelector('#items time').innerText;
    const context = { title: title };

    const request = new XMLHttpRequest();
    request.open('DELETE', `/api/todos/${id}`);
    request.addEventListener('load', event => {
      if (request.status === 204) {
        this.model.deleteTodo(id);
        this.handleResetUi(context);
      } else if (request.status === 404) {
        alert(request.response);
      }
    });

    request.send();
  }

  completeButtonListener() {
    this.view.completeButton.addEventListener('click', event => {
      const id = Number(this.view.form.dataset.id);
      const existingObj = this.model.todos.filter(obj => obj.id === id)[0];

      if (!!existingObj) {
        existingObj.completed = true;
        this.handleUpdateTodo(existingObj, id);
      } else {
        alert('You can only complete an existing todo');
      }
    });
  }

  sidebarListener() {
    sidebar.addEventListener('click', event => {
      const target = event.target;
      if (target.nodeName === 'DL') {
        var context = { title: target.dataset.title, id: target.id };
      } else if (target.nodeName === 'DT' || target.nodeName === 'DD') {
        const title = target.parentNode.dataset.title;
        const id = target.parentNode.id;
        var context = { title: title, id: id };
      } else if (target.nodeName === 'TIME') {
        const grandparent = target.parentNode.parentNode;
        const title = grandparent.dataset.title;
        const id = grandparent.id;
        var context = { title: title, id: id };
      }
      this.handleResetUi(context);
    });
  }
}

const model = new Model();
const view = new View();
const controller = new Controller(model, view);
