document.addEventListener('DOMContentLoaded', () => {
  const form = document.querySelector('form');

  form.addEventListener('submit', event => {
    event.preventDefault();

    const formData = new FormData(form);
    const json = Object.fromEntries([...formData]);

    if (validEmail(json.email) && json.name) {
      const request = new XMLHttpRequest();
      request.open('POST', form.action);
      request.setRequestHeader('Content-Type', 'application/json');
      request.send(JSON.stringify(json));

      request.addEventListener('load', event => {
        const response = JSON.parse(request.response);
        alert(`Staff with id ${response.id} has been created`);
      });
    } else if (!json.name) {
      alert('Please enter a name')
    }

    form.reset();
  });


});

function validEmail(email) {
  const validEmailCharacters = /^[\w#!%'&+*-/=?^_ `.]+$/;
  let [prefix, domain] = email.split('@');

  if (validPrefix(prefix) && validDomain(domain) && email.split('@').length === 2) {
    return true;
  }

  function validPrefix(prefix) {
    if (!validEmailCharacters.test(prefix)) {
      alert(`Your email's prefix has invalid characters`);
      return false;
    } else if (prefix.length > 64) {
      alert(`Your email's prefix should have less than 64 characters`);
      return false;
    } else {
      return true;
    }
  }

  function validDomain(domain) {
    if (!validEmailCharacters.test(domain)) {
      alert(`Your email's domain has invalid characters`);
      return false;
    } else if(domain.split('.').length <= 1) {
      alert(`Your email's domain should should have at least one '.'`);
      return false;
    } else {
      return true;
    }
  }
}
