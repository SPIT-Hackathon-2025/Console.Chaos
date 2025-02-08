const Comment = require('../Models/CommentModel'); // Import Comment model

// Function to create a new comment
const createComment = async (req, res) => {
    try {
        const comment = new Comment(req.body); // Create a new comment instance with request body
        await comment.save(); // Save the comment to the database
        res.status(201).send(comment); // Respond with the created comment
    } catch (error) {
        res.status(400).send(error); // Respond with an error if something goes wrong
    }
};

// Function to get all comments
const getAllComments = async (req, res) => {
    try {
        const comments = await Comment.find(); // Retrieve all comments from the database
        res.status(200).send(comments); // Respond with the list of comments
    } catch (error) {
        res.status(500).send(error); // Respond with an error if something goes wrong
    }
};

module.exports = { createComment, getAllComments }; // Export the functions
