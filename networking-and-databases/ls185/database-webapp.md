- HTTP request includes a cookie
- Application handles the incoming request, sets values in the session stored in the cookie
- Sends the cookie in the browser in the HTTP response

- Limitation of working with cookies: it siloes information — makes it hard to share between browsers (even in the same device) and users

- Code for working in the session will be extracted into a new class and create a class to interact with the database
  - Remove code for manipulating the session from the Sinatra application itself