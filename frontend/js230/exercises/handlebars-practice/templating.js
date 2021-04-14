document.addEventListener('DOMContentLoaded', () => {
  let post = {
    title: 'Lorem ipsum dolor sit amet',
    published: 'April 1, 2015',
    body: '<h2>This should work</h2><br><p>Hope so</p>'
  };

  const template = Handlebars.compile(document.getElementById('post').innerHTML);

  document.body.append(template(post));
});