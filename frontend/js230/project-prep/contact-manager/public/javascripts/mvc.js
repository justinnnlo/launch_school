class Model {
  deleteContact(id) {
    const index = this.contacts.findIndex(obj => obj.id === id);
    this.contacts.splice(index, 1);
  }

  editContact(json) {
    let index = this.contacts.findIndex(obj => obj.id === json.id);
    this.contacts[index] = json;
  }

  addContact(json) {
    let largestIndex;

    if (this.contacts.length === 0) {
      json.id = 1;
    } else {
      largestIndex = this.contacts.map(obj => obj.id).reduce((num, acc) => {
        if (num > acc) {
          return num;
        } else {
          return acc;
        }
      });
      json.id = largestIndex + 1;
    }
    this.contacts.push(json);
  }

  validContact(json) {
    let validName = /[\w ]+/i;
    let validPhone = /[0-9 +-]/;
    let validEmail = /[0-9a-z@.]/i;
    return validName.test(json.name) && validPhone.test(json.phone_number) && validEmail.test(json.email) && !!json.tags;
  }
}

class View {
  constructor() {
    this.quickActions = document.getElementById('quick_actions');
    this.noContacts = document.getElementById('no_contacts');
    this.displaySection = document.getElementById('display_contacts');
    this.addContactFormSection = document.getElementById('contact_form');
    this.submitForm = document.querySelector('section#contact_form form');
    this.displayList = document.querySelector('#display_contacts ul');
    this.contactCard = document.getElementById('contact_card');
    this.formHeadline = document.getElementById('form_headline');
  }

  resetUi(contacts) {
    this.removeContactCards();

    if (!Array.isArray(contacts) || contacts.length === 0) {
      this.noContacts.classList.remove('hidden');
      this.displayAddContactForm();
    } else {
      this.updateContacts(contacts);
      this.displayContacts();
    }
  }

  removeContactCards() {
    this.displayList.innerHTML = '';
  }

  resetContactForm() {
    this.submitForm.reset();
  }

  searchUi(contacts) {
    this.removeContactCards();
    this.updateContacts(contacts);
    this.displayContacts();
  }

  updateContacts(array) {
    const template = Handlebars.compile(this.contactCard.innerHTML);

    array.forEach(obj => {
      let contact = template(obj);
      this.displayList.insertAdjacentHTML('beforeend', contact);
    });
  }

  displayContactForm() {
    this.quickActions.classList.add('hidden');
    this.displaySection.classList.add('hidden');
    this.addContactFormSection.classList.remove('hidden');
  }

  displayAddContactForm() {
    this.displayContactForm();
    this.formHeadline.innerText = 'Add a contact';
    this.submitForm.dataset.purpose = 'add';
    this.resetContactForm();
  }

  displayEditContactForm(contact) {
    this.displayContactForm();

    const inputs = [...this.submitForm.querySelectorAll('input')];
    const select = this.submitForm.querySelector('select');

    inputs.forEach(input => input.value = contact[input.name]);
    select.value = contact[select.name];

    this.formHeadline.innerText = 'Edit Contact';
    this.submitForm.dataset.purpose = 'edit';
    this.submitForm.dataset.id = contact.id;
  }

  displayContacts() {
    this.quickActions.classList.remove('hidden');
    this.noContacts.classList.add('hidden');
    this.displaySection.classList.remove('hidden');
    this.addContactFormSection.classList.add('hidden');
  }
}

class Controller {
  constructor(model, view) {
    this.model = model;
    this.view = view;
  }

  init() {
    this.startUpApp();
    this.deleteOrEditContactListener();
    this.addContactListeners();
    this.returnToHomeListener();
    this.submitContactListener();
    this.searchListener();
    return this;
  }

  addContactListeners() {
    const addContactButtons = [...document.querySelectorAll('.btn_add')];

    addContactButtons.forEach(button => {
      button.addEventListener('click', event => {
        event.preventDefault();
        this.view.displayAddContactForm();
      });
    });
  }

  deleteOrEditContactListener(button) {
    this.view.displaySection.addEventListener('click', event => {
      event.preventDefault()
      let id = Number(event.target.parentElement.dataset.id);

      if (event.target.classList.contains('delete')) {
        this.handleDeleteContact(id);
      } else if (event.target.classList.contains('edit')) {
        let contact = this.model.contacts.filter(obj => obj.id === id)[0];
        this.view.displayEditContactForm(contact);
      }
    })
  }

  submitContactListener() {
    this.view.submitForm.addEventListener('submit', event => {
      event.preventDefault();
      const formData = new FormData(this.view.submitForm);
      const json = Object.fromEntries(formData);

      if (this.view.submitForm.dataset.purpose ==='add') {
        this.handleAddContact(json);
      } else if (this.view.submitForm.dataset.purpose ==='edit') {
        json.id = Number(this.view.submitForm.dataset.id);
        this.handleEditContact(json);
      }
    })
  }

  returnToHomeListener() {
    const returnLink = document.querySelector('a[href="#"]')
    returnLink.addEventListener('click', event => {
      event.preventDefault();
      this.view.displayContacts();
    })
  }

  handleAddContact(json) {
    if (!this.model.validContact(json)) {
      return alert('Invalid contact, please check your inputs');
    }

    const request = new XMLHttpRequest();
    request.open('POST', 'http://localhost:3000/api/contacts');
    request.setRequestHeader('Content-Type', 'application/json');
    request.send(JSON.stringify(json));

    this.model.addContact(json);
    this.view.resetUi(this.model.contacts);
    this.view.resetContactForm();
  }

  handleDeleteContact(id) {
    const filteredArray = this.model.contacts.filter(obj => obj.id === id);

    if (filteredArray.length === 0) {
      alert("You tried to delete a contact that doesn't exist, please try again");
    } else {
      this.model.deleteContact(id);
      this.view.resetUi(this.model.contacts)

      const request = new XMLHttpRequest();
      request.open('DELETE', `/api/contacts/${id}`);
      request.addEventListener('load', () => {
        alert('Contact deleted');
      });

      request.send();
    }
  }

  handleEditContact(json) {
    this.model.editContact(json);

    const request = new XMLHttpRequest();
    request.open('PUT', `/api/contacts/${json.id}`);
    request.setRequestHeader('Content-Type', 'application/json');
    request.addEventListener('load', event => {
      if (request.status === 201) {
        alert('Contact successfully edited');
      } else {
        alert('There was an error, please try again');
      }
      this.view.resetUi(this.model.contacts);
    });

    request.send(JSON.stringify(json));
  }

  startUpApp(handler) {
    const request = new XMLHttpRequest();
    request.open('GET', 'http://localhost:3000/api/contacts');
    request.responseType = 'json';
    request.addEventListener('load', () => {
      this.model.contacts = request.response;
      this.view.resetUi(this.model.contacts);
    });

    request.send();
  }

  searchListener() {
    const input = document.querySelector('input[type="search"]');
    input.addEventListener('input', event => {
      const keyword = input.value;
      this.handleSearch(keyword);
    });
  }

  handleSearch(keyword) {
    const pattern = new RegExp(keyword, 'i');
    const filtered = this.model.contacts.filter(obj => pattern.test(obj.full_name));
    this.view.searchUi(filtered);
  }
}

let controller = new Controller(new Model(), new View()).init();

/*

Austin
- Fetch API: cleaner syntax. May change my approach given the use of promises.
- handleOPERATION in the controller, and OPERATION in the model — avoid repeating method names!

*/