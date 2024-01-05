// Import express router and assign into UserRoute object
const UserRoute = require('express').Router();

// Import UserController 
const UserController = require('./../controllers/user_controller');

// Creating routes
UserRoute.post("/createAccount", UserController.createAccount);
UserRoute.post("/signIn", UserController.signIn);
UserRoute.put("/:id", UserController.updateUser);

// Exporting the user routes module
module.exports = UserRoute;