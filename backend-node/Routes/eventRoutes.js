const express = require('express'); // Import express
const router = express.Router(); // Create a router
const eventController = require('../Controller/eventController '); // Import comment controller
const EventMail = require('../Controller/EventMail');

// POST route to create a new comment
router.post('/', eventController.createEvent);
router.post('/EventMail', EventMail);

// GET route to retrieve all comments
router.get('/', eventController.getAllEvents);

module.exports = router; // Export the router
