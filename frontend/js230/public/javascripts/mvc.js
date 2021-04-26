class Model {

  constructor() {
    this.todos = [];
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

  updateTodo(json, id) {
    let index = this.todos.findIndex(obj => obj.id === Number(id));
    json.id = id;
    this.assignDueDate(json);
    this.todos[index] = json;
  }

  getTodo(id) {
    return this.todos.filter(obj => obj.id === id)[0];
  }

  completedTodos() {
    return this.todos.filter(obj => obj.completed);
  }

  groupByDate(array) {
    const temp = {};

    array.forEach(obj => {
      if (!!temp[obj.due_date]) {
        temp[obj.due_date].push(obj);
      } else {
        temp[obj.due_date] = [obj];
      }
    });

    let keys = Object.keys(temp);
    const result = {};

    if (keys.includes('No Due Date')) {
      result["No Due Date"] = temp["No Due Date"];
      keys = keys.filter(key => key !== "No Due Date");
    }

    keys = keys.sort((a, b) => Number(a.split('/')[1]) - Number(b.split('/')[1])).sort((a, b) => {
      let yearA = Number(a.split('/')[1]);
      let yearB = Number(b.split('/')[1]);
      let monthA = Number(a.split('/')[0]);
      let monthB = Number(b.split('/')[0]);

      if (yearA - yearB === 0) {
        return monthA - monthB;
      } else {
        return yearA - yearB;
      }
    });

    keys.forEach(key => result[key] = temp[key]);

    return result;
  }

  todoData(context) {
    const todoLength = this.todos.length || 0;
    const doneLength = this.completedTodos().length;
    const allTodos = this.groupByDate(this.todos);
    let selectedTodos = [...this.todos];

    if (context === undefined) {
      context = { title: 'All Todos', data: [...this.todos].length };
    } else {
      if (context.title === 'Completed') {
        selectedTodos = selectedTodos.filter(obj => obj.completed);
      } else if (context.title !== 'All Todos') {
        if (!!context.id) {
          selectedTodos = allTodos[context.title].filter(obj => obj.completed);
        } else {
          selectedTodos = allTodos[context.title];
        }
      }

      context.data = selectedTodos.length;
    }

    var sortedTodos = selectedTodos.sort(obj => obj.completed === true);

    return {
      todos: [...this.todos],
      todos_by_date: this.groupByDate(this.todos),
      done: [...this.completedTodos()],
      done_todos_by_date: this.groupByDate(this.completedTodos()),
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

  resetUi(data, obj) {
    document.body.innerHTML = this.compilation(data);
    this.setProperties();
    this.setSidebarActive(obj);
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

  setSidebarActive(obj) {
    if (obj === undefined) {
      this.allTodosHeader.classList.add('active');
    } else {
      if (!obj.id) {
        var node = document.querySelector(`dl[data-title="${obj.title}"]`);
      } else {
        var node = document.getElementById(obj.id);
      }
      node.classList.add('active');
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
    if (this.model.todos.length === 0) {
      context = undefined;
    }

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
      event.stopPropagation();
      this.view.modalLayer.style = 'display: block';
      this.view.modalForm.style = 'display: block';
    }, true);

    this.view.modalLayer.addEventListener('click', event => {
        this.view.resetForm();
        this.view.modalLayer.style = 'display: none';
        this.view.modalForm.style = 'display: none';
    });
  }

  tableListener() {
    const table = document.querySelector('table');

    table.addEventListener('click', event => {
      event.preventDefault();

      const nodeName = event.target.nodeName;
      let title = document.querySelector('#items time').innerText;
      let data = document.querySelector('#items dd').innerText
      let context = { title: title, data: data };

      if (event.target.classList.contains('delete')) {
        const id = Number(event.target.parentNode.dataset.id);
        this.handleDelete(id);
      } else if (nodeName === 'IMG') {
        const id = Number(event.target.parentNode.parentNode.dataset.id);
        this.handleDelete(id);
      } else if (nodeName === 'LABEL' || nodeName === 'INPUT') {
        let id = Number(event.target.parentNode.parentNode.dataset.id);
        let obj = this.model.todos.filter(obj => obj.id === id)[0];
        this.view.form.dataset.id = id;
        this.view.existingTodoForm(obj);
      } else if (nodeName === 'TD') {
        const id = Number(event.target.parentNode.dataset.id);
        const obj = this.model.getTodo(id);
        this.model.toggleCompleted(obj);
        this.handleUpdateTodo(obj, id, context);
      } else if (nodeName === 'SPAN') {
        const id = Number(event.target.parentNode.parentNode.dataset.id);
        const obj = this.model.getTodo(id);
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
      event.preventDefault();
      const formData = new FormData(this.view.form);
      const json = Object.fromEntries(formData);

      if (!!this.view.form.dataset.id) {
        this.handleUpdateTodo(json);
      } else {
        this.handleAddTodo(json);
      }
    }, true);
  }

  handleUpdateTodo(json, id, context) {
    if (!id) {
      id = this.view.form.dataset.id;
    }

    const request = new XMLHttpRequest();
    request.open('PUT', `/api/todos/${id}`);
    request.setRequestHeader('Content-Type', 'application/json');
    request.addEventListener('load', event => {
      if (request.status === 200) {
        let response = JSON.parse(request.response);
        this.model.updateTodo(response, response.id);
        this.handleResetUi(context);
      } else if (request.status === (400 || 404)) {
        alert(request.response);
      }
    });

    request.send(JSON.stringify(json));
  }

  handleDelete(id) {
    let title = document.querySelector('#items time').innerText;
    let data = document.querySelector('#items dd').innerText
    let context = { title: title, data: data };

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
      let id = Number(this.view.form.dataset.id);
      let existingObj = this.model.todos.filter(obj => obj.id === id)[0]
      if (!!existingObj) {
        existingObj.completed = true;
        this.handleUpdateTodo(existingObj);
      } else {
        alert('You can only complete an existing todo');
      }
    });
  }

  sidebarListener() {
    sidebar.addEventListener('click', event => {
      const target = event.target;
      if (target.nodeName === 'DL') {
        var obj = { title: target.dataset.title, id: target.id };
      } else if (target.nodeName === 'DT' || target.nodeName === 'DD') {
        const title = target.parentNode.dataset.title;
        const id = target.parentNode.id;
        var obj = { title: title, id: id };
      } else if (target.nodeName === 'TIME') {
        const grandparent = target.parentNode.parentNode;
        const title = grandparent.dataset.title;
        const id = grandparent.id;
        var obj = { title: title, id: id };
      }
      this.handleResetUi(obj);
    });
  }
}

const model = new Model();
const view = new View();
const controller = new Controller(model, view);
