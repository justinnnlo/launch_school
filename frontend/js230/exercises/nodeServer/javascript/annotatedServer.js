// Include http module — returns an object
// Object includes: status codes, HTTP methods, and functions
const http = require('http');

// Include file descriptor to open files
const fs = require('fs');

// Process is a Node global object accessible in any module
// Process gives info about the program being executed
// process.env is an object refererencing the user's environment
// Sone environemnts like Heroku set the env's PORT — if none default to 3000
const port = process.env.PORT || 3000;

// Create a server that return a successful response
// Response should include a body with hello world
const server = http.createServer((req, res) => {

  // Info sent to client strictly through the response!
  successfulRequest(res);
  res.end(`<h1>${req.url}</h1>`);
});

// Server listens on port 3000 to establish a TCP connection
server.listen(port, () => {
  // Logs to the server's console
  console.log(`Server running at port ${port}!`);
})

function successfulRequest(res) {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/html');
}