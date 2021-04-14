document.addEventListener('DOMContentLoaded', () => {
  const form = document.querySelector('form');
  const list = document.querySelector('#grocery-list');

  form.onsubmit = event => {
    event.preventDefault();

    let formData = new FormData(form);
    let json = Object.fromEntries(formData.entries());

    if (!json.quantity) {
      json.quantity = '1';
    }

    if (hasRepeatedItem(json.name)) {
      json.quantity = Number(json.quantity) + Number(numberRepeatedItem(json.name));
      list.removeChild(repeatedListItem(json.name));
    }

    let listItem = document.createElement('li');

    listItem.innerText = json.quantity + ' ' + json.name;

    list.append(listItem);

    function repeatedListItem(itemName) {
      let pattern = new RegExp(itemName, 'i');
      return [...list.children].filter(node => node.innerText.match(pattern))[0];
    }

    function hasRepeatedItem(itemName) {
      return !!repeatedListItem(itemName);
    }

    function numberRepeatedItem(itemName) {
      return repeatedListItem(itemName).innerText.split(' ')[0];
    }
  };
});

// If no quantity, defaults to 1
// Assume a name is given for the item
// If the item name is repeated, just add the new entry
// Items get added as bullet points in the ul

// Challenge: if item name is repeated (case insensitive) add their results, eliminate the original item, and post the new one with the updated figure
// Challenge: Hide form when printing the page — how to do this???