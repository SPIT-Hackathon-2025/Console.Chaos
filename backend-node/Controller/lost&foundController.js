const jwt = require("jsonwebtoken");
const LostFoundPost = require("../Models/Lost&Found");

// Create a new lost & found post
const createPost = async (req, res) => {
  try {
    const jwtSecret = process.env.JWT_SECRET;
    const { imgUrl, token, description, tags, address,longitude,latitude } = req.body; // Address added

    const user = jwt.verify(token, jwtSecret).id;

    const newPost = new LostFoundPost({
      imgUrl,
      user,
      description,
      tags: tags || [], // Default to empty array if no tags provided
      address, // Store the address field
      longitude,
      latitude
    });

    await newPost.save();
    res.status(201).json({ message: "Post created successfully", post: newPost });

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get all lost & found posts
const getAllPosts = async (req, res) => {
  try {
    const lostFoundPosts = await LostFoundPost.find()
      .populate("user", "username email imgUrl phoneNumber userType") // Include necessary user fields
      .sort({ createdAt: -1 });

    res.status(200).send(lostFoundPosts);

  } catch (error) {
    res.status(500).send({ error: error.message });
  }
};

module.exports = { createPost, getAllPosts };
