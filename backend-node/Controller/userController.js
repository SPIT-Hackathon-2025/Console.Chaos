const User = require('../Models/UserModel'); // Import User model

// Function to create a new user
const createUser = async (req, res) => {
    try {
        const user = new User(req.body); // Create a new user instance with request body
        await user.save(); // Save the user to the database
        res.status(201).send(user); // Respond with the created user
    } catch (error) {
        res.status(400).send(error); // Respond with an error if something goes wrong
    }
};

// Function to get all users
const getAllUsers = async (req, res) => {
    try {
        const users = await User.find(); // Retrieve all users from the database
        res.status(200).send(users); // Respond with the list of users
    } catch (error) {
        res.status(500).send(error); // Respond with an error if something goes wrong
    }
};

module.exports = { createUser, getAllUsers }; // Export the functions
