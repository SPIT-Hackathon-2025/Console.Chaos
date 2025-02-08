const jwt = require('jsonwebtoken');
const Comment = require('../Models/CommentModel'); // Adjust the path as needed
const Post = require('../Models/PostModel'); // Import Post model
const { default: ollama } = require("ollama");


const genralComment = async (req, res) => {
  try {
    // Get JWT secret from environment variables
    const jwtSecret = process.env.JWT_SECRET;
    if (!jwtSecret) {
      return res.status(500).json({ message: 'Server configuration error: JWT secret is not defined' });
    }

    // Extract required data from the request body
    const { text, token, postId } = req.body;
    if (!text || !token || !postId) {
      return res.status(400).json({ message: 'Missing required fields: text, token, or postId' });
    }

    // Verify the token and extract the payload
    const decoded = jwt.verify(token, jwtSecret);
    // Assuming your token payload was signed with an "id" property:
    const userId = decoded.id;

    // Create a new comment using the Comment model
    const newComment = new Comment({
      comment: text,
      user: userId,
      post: postId,
      // Optionally, if you want to add tags you can include them here, e.g.,
      // tags: req.body.tags
    });

    // Save the comment to the database
    await newComment.save();

    // Respond with a success message and the saved comment data
    return res.status(201).json({
      message: 'Comment added successfully',
      comment: newComment
    });
  } catch (error) {
    console.error('Error adding comment:', error.message);
    return res.status(500).json({ message: 'Server error', error: error.message });
  }
};


const claimComment = async (req, res) => {

  try {
    // Get JWT secret from environment variables
    const jwtSecret = process.env.JWT_SECRET;
    if (!jwtSecret) {
      return res.status(500).json({ message: 'Server configuration error: JWT secret is not defined' });
    }

    // Extract required data from the request body
    const { text, token, postId } = req.body;

    if (!text || !token || !postId) {
      return res.status(400).json({ message: 'Missing required fields: text, token, or postId' });
    }

    // Verify the token and extract the payload
    const decoded = jwt.verify(token, jwtSecret);
    // Assuming your token payload was signed with an "id" property:
    const userId = decoded.id;
    const format_1 = {
      type: "object",
      properties: {
        keyword: {
          type: "string",
        },
      },
      required: ["fund_age_yr", "risk_level", "returns_1yr"],
    };
    const userQuery=`Extract a keyword or phrase that best describes the main topic of this comment: ${text}`
    const data = [
      {
        role: "system",
        content:
          "Extract a keyword or phrase that best describes the main topic of this comment",
      },
      {
        role: "user",
        content: userQuery,
      },
    ];

    const response = await ollama.chat({
      model: "llama3.2",
      messages: data,
      format:format_1
        });
    const tag=JSON.parse(response.message.content).keyword
    

    // Create a new comment using the Comment model
    const newComment = new Comment({
      comment: text,
      user: userId,
      post: postId,
      tag:tag
      // Optionally, if you want to add tags you can include them here, e.g.,
      // tags: req.body.tags
    });

    // Save the comment to the database
    await newComment.save();

    // Respond with a success message and the saved comment data
    return res.status(201).json({
      message: 'Comment added successfully',
      comment: newComment,
      tag:tag
      
    });
  } catch (error) {
    console.error('Error adding comment:', error.message);
    return res.status(500).json({ message: 'Server error', error: error.message });
  }
}
module.exports = { genralComment, claimComment };
