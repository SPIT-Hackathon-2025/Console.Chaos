const express = require('express'); // Import express
const searchWIthAI = require('../Controller/searchWithAi');
const router = express.Router(); // Create a router

router.post('/', searchWIthAI);

module.exports = router; // Export the router
