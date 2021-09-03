const database = require("./database");
const express = require("express");

router = express.Router();

//upon form submit on index.html, api call to user table
router.post("/login", (request, response) => {
  database.connection.query("select * from user where email = '" + request.body.text1 + "' and u_password = '"+ request.body.pw + "'",
  (error, result) => {
    if (error) {
      console.log(error);
      response.send("Login error. Please try again.");
    } else {
      if(result[0].profile_id == 1)
        response.redirect('/child?id='+result[0].user_id);
      else
        response.redirect('/parent?id='+result[0].user_id);
    }
  });
});

// return all data about user to return parent_id for user
router.get("/user", (request, response) => {
  database.connection.query(`select * from user where user_id = ${request.query.id}`, (error, result) => {
    if (error) {
      console.log(error);
      response.status(500).send("Some error occurred at the Backend.");
    } else {
      response.status(200).send(result);
    }
  });
});

module.exports = {
  // get_all_products,
  // get_product_by_id,
  // create_new_product,
  // delete_product_by_id,
  // update_price_by_id,
  router,
};
