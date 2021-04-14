const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const bodyParser = require('body-parser');


app.use(bodyParser.urlencoded({extended: true}));

app.get('/', (req, res) => {
  res.sendFile('/Users/jadlp/repos/launch_school/frontend/js230/exercises/express-form/index.html');
});

app.post('/', (req, res) => {
  console.log(req.body);
  // res.send('POST request from homepage');
  // console.log(req);
});

app.listen(port, () => {
  console.log(`App listening at port ${port}`);
});

app.use(function (req, res, next) {
  res.status(404).send("Sorry can't find that!")
});