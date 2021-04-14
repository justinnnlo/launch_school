// When you click on a team member
// 1. Introduce a modal that prevents you from interacting with the elements underneath
// - Tradeoff: hide and unhide it in the HTML file or insert and remove it every time with JS?
// - Images: icons_close.png and img_NAME.jpg in the images/ folder
// 2. Put the info of the team members on top of the modal => with existing elements?, Handlebars?
// - Starting implementation: same text for all
// - Challenge: vary text depending on the character
// 3. Exit the modal/team member info by clicking on either the "X" or directly on the modal
// - Challenge: animate the modal by fading in and out

document.addEventListener('DOMContentLoaded', () => {
  const unorderedList = document.querySelector('article ul');

  unorderedList.addEventListener('click', event => {
    event.preventDefault();


  })
});