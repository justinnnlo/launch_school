document.addEventListener('DOMContentLoaded', event => {
  const form = document.querySelector('form');
  const submitButton = document.getElementById('submit');
  const scheduleCreatorButton = document.getElementById('new_schedule_entry');

  insertStaff();

  const staffIds = [];
  [...document.querySelectorAll('option')].slice(1).forEach(n => {
      staffIds.push(n.value);
  });

  scheduleCreatorButton.addEventListener('click', event => {
    const newForm = [...document.querySelectorAll('.schedule_creator')].slice(-1)[0].cloneNode(true);
    newForm.id = Number(newForm.id) + 1;
    newForm.children[0].textContent = `Schedule Entry ${newForm.id}`;
    [...newForm.querySelectorAll('input')].forEach(node => node.value = '');
    document.body.insertBefore(newForm, submitButton);
  });

  submitButton.addEventListener('click', event => {
    const forms = [...document.querySelectorAll('form')];
    const formsData = forms.map(form => [...new FormData(form)]);
    const jsonData = formsData.map(data => Object.fromEntries(data));

    const request = new XMLHttpRequest();
    request.open('POST', 'http://localhost:3000/api/schedules');
    request.setRequestHeader('Content-Type', 'application/json')
    request.send(JSON.stringify({schedules: jsonData}));
    request.addEventListener('load', event => {
      console.log(event);
    })
  });

  function insertStaff() {
    const selectInput = document.querySelector('select');

    const request = new XMLHttpRequest();
    request.open('GET', 'http://localhost:3000/api/staff_members');
    request.responseType = 'json';
    request.send();

    request.addEventListener('load', event => {
      const json = request.response;

      json.forEach(node => {
        let option = document.createElement('option');
        option.value = node.id;
        option.innerText = node.name;
        selectInput.appendChild(option);
      });
    });
  }

  function validInputs(array) {
    return array.every(obj => validStaff(obj.staff_id) && validDate(obj.date) && validTime(obj.time));
  }

  function validDate(date) {
    const [year, month, day] = date.split('-');
    return validYear(year) && validMonth(month) && validDay(day);
  }

  function validYear(year) {
    // Year has to be length 4 & in this current year
    return /^[0-9]{4}$/.test(year) && Date.now;
  }

  function validMonth(month) {
    // greater or equal to current month?
    return /^[1-9][0-9]?$/.test(month) && Number(month) <= 12;
  }

  function validDay(day) {
    // greater or equal to current day if in current month?
    return /^[1-9][0-9]?$/.test(day) && Number(day) <= 31;
  }

  function validTime(time) {

  }

  function validStaff(id) {
    return staffIds.includes(id);
  }
});