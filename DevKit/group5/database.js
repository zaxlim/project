const mysql = require("mysql");

const properties = {
  host: "34.126.172.116",
  user: "root",
  password: "fintechsglab",
  port: 3306,
  database: "group5",
};

let connection = mysql.createConnection(properties);

connection.connect((error) => {
  if (error) {
    console.log("Connection to MySQL failed! \n" + error);
  } else {
    console.log("Connected to MySQL!");
  }
});

module.exports = {
  connection,
};