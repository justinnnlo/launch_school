document.addEventListener('DOMContentLoaded', event => {
  const form = document.querySelector('form');

  form.onsubmit = event => {
    event.preventDefault()
    const formData = new FormData(form);
    console.log(formData);
    for(let pair of formData) {
      console.log(pair[0], pair[1]);
    }
    console.log(Object.fromEntries([...formData])); // Create JS object
  }
});



























// document.addEventListener('DOMContentLoaded', () => {
//   const form = document.querySelector('form[name = "myform"]');

//   form.addEventListener('submit', (e) => {
//     e.preventDefault();
//     const formData = new FormData(form);
//     console.log(form);
//     console.log(formData);
//     for (let pair of formData) {
//       console.log(pair[0] + ', ' + pair[1]);
//     }
//     console.log([...formData]);             // Creates key-value pairs in an array
//     console.log(...formData);               // Displays key-value pairs, but can't manipulate them
//     console.log(formData.entries());
//     for (let pair of formData.entries()) {
//       console.log(pair[0] + ', ' + pair[1]);
//     }
//     // console.log(`The form is: ${form}`);
//     // console.log(`The FormData object is: ${formData}`);
//     // console.log(`FormData.entries is: ${formData.entries()}`);
//   });
// });