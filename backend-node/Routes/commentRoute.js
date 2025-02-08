const express = require('express'); // Import express
const router = express.Router(); // Create a router
const commentController = require('../Controller/commentController'); // Import comment controller

// POST route to create a new comment
router.post('/', commentController.createComment);

// GET route to retrieve all comments
router.get('/', commentController.getAllComments);

module.exports = router; // Export the router
