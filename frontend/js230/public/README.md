# Project Comments

This is a pretty standard implementation:

- I used the given HTML and CSS files, and made only tiny changes to the HTML
- My JS is in a single `mvc.js` file
- I approached this problem using an MVC framework
- I used Handlebars but did not use jQuery
- I used XHR requests and vanilla JS throughout

As a heads up, I noticed a bug right before submission time.

Sometimes when I'm in a section with a single todo item and delete it I get an error. The deletion is processed in the server but isn't processed appropiately locally (the todo item remains). The problem is related to my `controller.model.todoData` method but I'm still not sure what are the exact circumstances that raise this bug — sometimes I try to replicate it but fail to do so.

As a more general comment that ties to this bug, you'll see there's a reasonable margin of improvement by refactoring. It gets the job done (barring the above bug). Yet some methods are at times messy and less clear cut than what I am comfortable with. This was a time problem: I only started with the Javascript 1.5 days in because I was having problems getting Handlebars to work properly (some details that took a while to catch raised problems).
