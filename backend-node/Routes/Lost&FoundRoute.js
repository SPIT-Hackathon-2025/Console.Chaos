const express = require('express'); // Import express
const router = express.Router(); // Create a router
const { genralComment, claimComment } = require('../Controller/Lost&FoundComments');

router.post('/generalComment', genralComment);
router.post('/claimComment', claimComment);

module.exports = router; // Export the router
