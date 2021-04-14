document.addEventListener('DOMContentLoaded', () => {
  const photoData = new XMLHttpRequest();
  photoData.open('GET', '/photos');
  photoData.send();

  photoData.addEventListener('load', () => {
    let json = JSON.parse(photoData.response);
    const slideFigures = [...document.querySelectorAll('#slides figure')];
    for (let index = 0; index < slideFigures.length; index ++) {
      let dataId = slideFigures[index].getAttribute('data-id');
      let image = slideFigures[index].querySelector('img');
      let photo = json.filter(obj => String(obj.id) === dataId)[0];
      image.setAttribute('src', photo.src);
    }
  });
});