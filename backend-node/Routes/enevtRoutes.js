const express = require('express'); // Import express
const router = express.Router(); // Create a router
const eventController = require('../Controller/eventController '); // Import comment controller

// POST route to create a new comment
router.post('/', eventController.createEvent);

// GET route to retrieve all comments
router.get('/', eventController.getAllEvents);

module.exports = router; // Export the router
