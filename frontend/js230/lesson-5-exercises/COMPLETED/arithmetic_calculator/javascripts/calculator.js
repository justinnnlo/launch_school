document.addEventListener('DOMContentLoaded', () => {
  const result = document.querySelector('#result');

  form.onsubmit = event => {
    event.preventDefault();

    let formData = new FormData(event.target);
    let json = Object.fromEntries(formData.entries());

    if (json.operator === '+') {
      result.innerText = Number(json['first-number']) + Number(json['second-number']);
    } else if (json.operator === '-') {
      result.innerText = Number(json['first-number']) - Number(json['second-number']);
    } else if (json.operator === '*') {
      result.innerText = Number(json['first-number']) * Number(json['second-number']);
    } else {
      result.innerText = Number(json['first-number']) / Number(json['second-number']);
    }
  }
});