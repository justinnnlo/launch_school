let cursorInterval;

document.addEventListener('DOMContentLoaded', () => {
  const textField = document.querySelector('.text-field');

  textField.addEventListener('click', e => {
    e.stopPropagation();
    textField.classList.add('focused');
    cursorInterval = setInterval(() => textField.classList.toggle('cursor'), 500);
  });

})

document.addEventListener('keydown', (e) => {
  const textField = document.querySelector('.text-field');
  if (textField.classList[1] === 'focused') {
    if (e.key === 'Backspace') {
      textField.textContent = textField.textContent.substr(0, textField.textContent.length - 1);
    } else {
      if (!['Shift', 'Meta', 'Alt', 'Control', 'CapsLock', 'Tab', 'Enter'].includes(e.key)) {
        textField.textContent += e.key;
      }
    }
  }
})

document.addEventListener('click', e => {
  const textField = document.querySelector('.text-field');

  textField.classList.remove('focused', 'cursor')
  clearInterval(cursorInterval);
});