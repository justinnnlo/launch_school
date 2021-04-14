const http = require('http'); // Return http object
const options = {             // Request header information
  hostname: 'localhost',
  port: 3000,
  path: '/',
  method: 'GET',
}

// Initiate an HTTP request
const req = http.request(options, res => {

  // Log to the client's side
  console.log(`Status code: ${res.statusCode}`);

  res.on('data', d => {
  process.stdout.write(d);    // Using console.log prints gibberish
    process.stdout.write('\n');
  });
});

// When the event 'error' is triggered
req.on('error', error => {
  console.error(error);
});

req.end();