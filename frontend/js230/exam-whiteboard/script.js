document.addEventListener('DOMContentLoaded', () => {

  rewrite();

  function rewrite() {
    document.body.removeChild(document.querySelector('h2'));

    const h1 = document.createElement('h1');
    const headline = document.createTextNode("The Day's News");
    h1.appendChild(headline);

    document.body.prepend(h1);

    const article = document.createElement('article');
    article.classList.add('breaking');

    let p1 = document.createElement('p');
    p1.append(document.createTextNode("Fire breaks out at the old factory"));
    article.append(p1);

    let p2 = document.createElement('p');
    let link = document.createElement('a');
    link.href = '/stories/15';
    link.append(document.createTextNode("Read more"));

    p2.append(link);
    article.append(p2);

    document.querySelector('div').prepend(article);
  }
});