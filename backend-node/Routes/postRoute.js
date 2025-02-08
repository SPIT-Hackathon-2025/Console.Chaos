const express = require('express'); // Import express
const router = express.Router(); // Create a router
const postController = require('../Controller/postController'); // Import post controller

// POST route to create a new post
router.post('/', postController.createPost);

// GET route to retrieve all posts
router.get('/', postController.getAllPosts);

module.exports = router; // Export the router
