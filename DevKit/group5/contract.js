const database = require("./database");
const express = require("express");

router = express.Router();

router.get("/all", (request, response) => {
  // #swagger.path = '/contracts/all'
  database.connection.query(`select * from contract`, (error, result) => {
    if (error) {
      console.log(error);
      response.status(500).send("Error occurred at backend.");
    } else {
      response.status(200).send(result);
    }
  });
});

router.get("/by-child_id", (request, response) => {
  /* #swagger.path = '/contracts/by-child_id'
     #swagger.parameters['id'] = {
          in: 'query',
          type: 'int',
          description: 'Parent ID'
  } */
  database.connection.query(
    `select * from contract where child_id = ${request.query.id}`,
    (error, result) => {
      if (error) {
        console.log(error);
        response.status(500).send("Error occurred at backend.");
      } else {
        response.status(200).send(result);
      }
    }
  );
});

router.get("/by-parent_id", (request, response) => {
  /* #swagger.path = '/contracts/by-parent_id'
     #swagger.parameters['id'] = {
          in: 'query',
          type: 'int',
          description: 'Parent ID'
  } */
  database.connection.query(
    `select * from contract where parent_id = ${request.query.id}`,
    (error, result) => {
      if (error) {
        console.log(error);
        response.status(500).send("Error occurred at backend.");
      } else {
        response.status(200).send(result);
      }
    }
  );
});

router.post("/add", (request, response) => {
  /* #swagger.path = '/contracts/add'
     #swagger.parameters['body'] = {
        in: 'body',
        description: 'Form fields',
        schema: {
            $c_description: 'Sample Contract',
            $c_value: 0.10,
            $child_id: 1,
            $parent_id: 2,
            $status_id: 1,
        }
} */
  database.connection.query(
    `insert into contract (c_description, c_value, child_id, parent_id, status_id) values ('${request.body.c_description}', '${request.body.c_value}', '${request.body.child_id}', '${request.body.parent_id}', '${request.body.status_id}')`,
    (error, result) => {
      if (error) {
        console.log(error);
        response.status(500).send("Error occurred at backend.");
      } else {
        response.status(200).send("New contract created successfully.");
      }
    }
  );
});

module.exports = {
  // get_all_products,
  // get_product_by_id,
  // create_new_product,
  // delete_product_by_id,
  // update_price_by_id,
  router,
};
