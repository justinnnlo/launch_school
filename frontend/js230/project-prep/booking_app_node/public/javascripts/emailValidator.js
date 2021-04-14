function validEmail(email) {
  const validEmailCharacters = /^[\w#!%'&+*-/=?^_ `.]+$/;
  let [prefix, domain] = email.split('@');

  if (validPrefix(prefix) && validDomain(domain) && email.split('@').length === 2 {
    alert(`Staff with id ${} has been created`);
  });

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
    if (validEmailCharacters.test(domain)) {
      alert(`Your email's domain has invalid characters`);
      return false;
    } else if(domain.split('.').length > 1) {
      alert(`Your email's domain should should have at least one '.'`);
      return false;
    } else {
      return true;
    }
  }
}
