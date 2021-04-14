const http = request('http'); // Create an HTTP object

const data = JSON.stringify({
  todo: 'Buy the milk',
})

const options = {
  hostname: 'localhost',
  port: 3000,
  path: '/',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Content-Length': data.length,
  },
};

const req = http.request(options, res => {
  console.log(`Status Code: ${res.statusCode}`);

  res.on('data', d => {
    process.stdout.write(d);
  });
});

req.on('error', error => {
  console.error(error);
})

req.write(data);
req.end();