let words = ['HELLO'];
words = shuffleArray(words);

let incorrectGuesses = 0;

function shuffleArray(array) {
  let newArray = [];

  while (words.length > 0) {
    let index = Math.floor(Math.random() * words.length);
    newArray.push(words[index]);
    words.splice(index, 1);
  }

  return newArray;
}

document.addEventListener('DOMContentLoaded', () => {
  const apples = document.querySelector('#apples');
  const message = document.querySelector('#message');
  const replay = document.querySelector('#replay');
  let word = newRound();

  document.addEventListener('keyup', (event) => {
    const userInput = event.key.toUpperCase();

    if (validInput(userInput)) {
      displayGuessedLetter(userInput);

      if (letterInWord(userInput)) {
        const indices = locationsInWord(userInput);
        displayCorrectGuess(indices, userInput);
      } else {
        incorrectGuesses += 1;
        apples.classList = `guess_${incorrectGuesses}`;
      }

      if (gameOver()) {
        if (won()) {
          displayResult(true);
        } else {
          displayResult(false);
        }
      }
    }

  });

  replay.onclick = event => {
    event.preventDefault();
    if (words.length === 0) {
      message.innerText = 'Game over: you ran out of words!'
      replay.innerText = 'Restart the game';
      replay['href'] = '/';
      replay.onclick = null;
    } else {
      word = newRound();
    }
  };

  function validInput(userInput) {
    const alphabet = /^\w$/i;
    return alphabet.test(userInput) && !previouslyGuessed(userInput) && incorrectGuesses < 6 && !gameOver();
  }

  function newRound() {
    removeAllLetters();
    resetStyles();

    incorrectGuesses = 0;
    let firstWord = words.shift()
    const wordSpaces = document.querySelector('#spaces');
    firstWord.split('').forEach(_ => wordSpaces.append(document.createElement('span')));
    return firstWord;
  }

  function resetStyles() {
    document.body.classList = '';
    apples.classList = '';
    replay.style = 'display: none';
    message.style = 'display: none';
  }

  function displayResult(boolean) {
    const win = {
      true: {
        body: 'win',
        message: 'You win!'
            },
      false: {
        body: 'lose',
        message: 'Sorry, you ran out of guesses!'
      },
    }

    document.body.classList = win[boolean].body;
    message.innerText = win[boolean].message;
    message.style = 'display: inline';
    replay.style = 'display: inline';
  }

  function previouslyGuessed(userInput) {
    let guessedLetters = [...document.querySelectorAll('#guesses span')];
    return guessedLetters.some(node => node.innerText === userInput);
  }

  function displayCorrectGuess(indices, userInput) {
    let spans = [...document.querySelectorAll('#spaces span')];
    indices.forEach(index => spans[index].innerText = userInput);
  }

  function displayGuessedLetter(userInput) {
    let node = document.createElement('span');
    node.innerText = userInput;
    document.getElementById('guesses').append(node);
  }

  function removeAllLetters() {
    [...document.querySelectorAll('#guesses span')].forEach(n => n.parentNode.removeChild(n));
    [...document.querySelectorAll('#spaces span')].forEach(n => n.parentNode.removeChild(n));
  }

  function letterInWord(userInput) {
    let pattern = new RegExp(userInput, 'i');
    return pattern.test(word);
  }

  function locationsInWord(userInput) {
    let locations = [];
    word.split('').forEach((char, index) => {
      if (char === userInput) {
        locations.push(index);
      }
    })
    return locations;
  }

  function gameOver() {
    return won() || lose();
  }

  function won() {
    return [...document.querySelectorAll('#spaces span')].every(n => n.innerText !== '');
  }

  function lose() {
    return incorrectGuesses === 6;
  }
});