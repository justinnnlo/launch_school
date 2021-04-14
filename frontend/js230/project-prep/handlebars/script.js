document.addEventListener('DOMContentLoaded', () => {
  let template = document.querySelector('#post').innerHTML;
  let post = {
    title: 'Lorem ipsum dolor sit amet',
    published: 'April 1, 2015',
    body: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.'
  };

  let compilation = Handlebars.compile(template);
  let htmlCode = compilation(post);

  // insertAdjacentHTML inserts a string as HTML
  // Inversely, prepend turns a string into a text node
  document.body.insertAdjacentHTML('afterbegin', htmlCode);
});
