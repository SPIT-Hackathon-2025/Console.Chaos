const express = require('express'); // Import express
const router = express.Router(); // Create a router
const registerUser = require('../Controller/auth/createUser'); // Import user controller
const  loginUser = require('../Controller/auth/validateUser'); // Import user controller

router.post('/register', registerUser);
router.post('/login', loginUser);

module.exports = router; // Export the router
