const Post = require('../Models/PostModel'); // Import Post model

// Function to create a new post
const createPost = async (req, res) => {
    try {
        const post = new Post(req.body); // Create a new post instance with request body
        await post.save(); // Save the post to the database
        res.status(201).send(post); // Respond with the created post
    } catch (error) {
        res.status(400).send(error); // Respond with an error if something goes wrong
    }
};

// Function to get all posts
const getAllPosts = async (req, res) => {
    try {
        const posts = await Post.find(); // Retrieve all posts from the database
        res.status(200).send(posts); // Respond with the list of posts
    } catch (error) {
        res.status(500).send(error); // Respond with an error if something goes wrong
    }
};

module.exports = { createPost, getAllPosts }; // Export the functions
