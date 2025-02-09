const jwt = require("jsonwebtoken");
const LostFoundPost = require("../Models/Lost&Found");

// Create a new lost & found post
const createPost = async (req, res) => {
  try {
    jwtSecret=process.env.JWT_SECRET

    const { imgUrl, token, description, tags } = req.body;
    user=jwt.verify(token,jwtSecret).id
    console.log(user);
    const newPost = new LostFoundPost({
      imgUrl,
      user,
      description,
      tags: tags || [], // Default to empty array if no tags provided
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
        .populate("user", "username email imgUrl phoneNumber userType") // Include necessary fields
        .sort({ createdAt: -1 });
  
      res.status(200).send(lostFoundPosts);
  
    } catch (error) {
      res.status(500).send({ error: error.message });
    }
  };
  
module.exports = { createPost, getAllPosts };
