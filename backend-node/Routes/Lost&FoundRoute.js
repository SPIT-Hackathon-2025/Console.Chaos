const express = require('express'); // Import express
const router = express.Router(); // Create a router
const { genralComment, claimComment, getAllComments, getGeneralComments, getClaimComments } = require('../Controller/Lost&FoundComments');
const { createPost, getAllPosts } = require('../Controller/lost&foundController');

router.post('/generalComment', genralComment);
router.post('/claimComment', claimComment);
router.get('/AllComments/:postId', getAllComments);
router.get('/getGeneralComments/:postId', getGeneralComments);
router.get('/getClaimComments/:postId', getClaimComments);
router.post('/createPost',createPost)
router.get('/getPost',getAllPosts)
module.exports = router; // Export the router
