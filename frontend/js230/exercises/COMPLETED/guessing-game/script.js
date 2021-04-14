
document.addEventListener('DOMContentLoaded', () => {
  let count;
  let answer;
  const inputNumber = document.querySelector('#guess');
  const form = document.querySelector('form');              // Get form itself to place the listener
  const message = document.querySelector('#message');
  const link = document.querySelector('a');
  const submitCallback = (e) => {                           // input type name is the event name + element to target is FORM, not button or input
    e.preventDefault();
    let guess = parseInt(inputNumber.value, 10);            // Form input value in input.value, ie the text content of input

    if (guess === answer) {
      message.textContent = `You guessed it! It took you ${count} guesses.`;
      form.removeEventListener('submit', submitCallback);
    } else if (guess < 1 || guess > 100 || !Number.isInteger(guess)) {
      message.textContent = 'Incorrect guess. Enter an integer between 1 and 1º00.';
      inputNumber.value = '';
    } else if (guess < answer) {
      message.textContent = `My number is higher than ${guess}.`;
      count += 1;
      inputNumber.value = '';
    } else if (guess > answer) {
      message.textContent = `My number is lower than ${guess}.`;
      count += 1;
      inputNumber.value = '';
    }
  }

  startGame();

  link.addEventListener('click', startGame);

  function startGame() {
    count = 1;
    answer = Math.ceil(Math.random() * 100);
    message.textContent = 'Guess a number between 1 and 100';
    inputNumber.value = '';

    form.addEventListener('submit', submitCallback);
  }

  function generateAnswer() {
    return Math.ceil(Math.random() * 100);
  }
});