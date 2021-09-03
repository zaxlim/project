const user = require("./user");
const contract = require("./contract");

const express = require("express");
const swaggerUi = require('swagger-ui-express');
const swaggerFile = require('./swagger_output.json');

const cors = require("cors");

server = express();
server.use(express.static('FE'));

// Serve up the page without manual configuration
server.get('/', (req, res) => {
  res.sendFile(__dirname + '/FE/index.html');
});

server.get('/child', (req, res) => {
  res.sendFile(__dirname + '/FE/child.html');
});

server.get('/parent', (req, res) => {
  res.sendFile(__dirname + '/FE/parent.html');
});

server.use(cors());
server.use(express.json());
server.use(express.urlencoded());

server.use('/', user.router);
server.use('/contracts', contract.router);
server.use('/doc', swaggerUi.serve, swaggerUi.setup(swaggerFile));

server.listen(3000, () => {
  console.log("Server is running!");
});
