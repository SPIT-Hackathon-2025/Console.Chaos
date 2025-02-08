const express = require('express'); // Import express
const router = express.Router(); // Create a router
const userController = require('../Controller/userController'); // Import user controller

// POST route to create a new user
router.post('/', userController.createUser);

// GET route to retrieve all users
router.get('/', userController.getAllUsers);

module.exports = router; // Export the router
