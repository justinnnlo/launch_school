let divs = document.querySelectorAll('.pick');                // Pics divs 1, 2 and 4

for(let index = 0; index < divs.length; index += 1) {
  divs[index].addEventListener('click', highlightThis, true); // Capture event propagation — top down
}

document.querySelector('.d3').addEventListener('click', highlightThis, false);

function highlightThis(e) {
  alert(`${this} ${e.currentTarget.tagName}`);      // e.className === Mouse? : e.currentTarget.tagName === nodeName
}

// Click on 4: all 3 events fire, but it's top down since it's capture
// Order of firing: 1, 2, 4, 3 as 3 is bubble rather than capture
// Alert: Mouse DIV => Key mistake: `this` is the target object NOT the event
// d# pick DIV/MAIN/SECTION