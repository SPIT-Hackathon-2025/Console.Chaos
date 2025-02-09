const Post = require('../Models/PostModel'); // Import Post model
const jwt=require('jsonwebtoken')

// Function to create a new post
const createPost = async (req, res) => {
    try {
        const jwtSecret=process.env.JWT_SECRET
      const { description, token, latitude, longitude, tags,imgUrl,address } = req.body;
      console.log(req.body)
      const decoded = jwt.verify(token, jwtSecret);
      // Assuming your token payload was signed with an "id" property:
      const user = decoded.id;
  
      // Handling image URL if an image is uploaded
  
      // Create post
      const newPost = new Post({
        imgUrl,
        description,
        user,
        latitude,
        longitude,
        address,
        tags,
      });
  
      await newPost.save();
      res.status(201).json({ message: "Post created successfully", post: newPost });
  
    } catch (error) {
        console.log(error);
        
      res.status(500).json({ error: error.message });
    }
  };

// Function to get all posts
const getAllPosts = async (req, res) => {
    try {
        const posts = await Post.find()
            .populate('user', 'name username email'); // Populate user details

        res.status(200).send(posts);
    } catch (error) {
        console.log(error);
        
        res.sendStatus(500);
    }
};


module.exports = { createPost, getAllPosts }; // Export the functions
