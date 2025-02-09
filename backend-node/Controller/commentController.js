const Comment = require('../Models/CommentModel'); // Import Comment model
const uploadImage = require('./upload');

// Function to create a new comment
const createComment = async (req, res) => {
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

// Function to get all comments
const getAllComments = async (req, res) => {
    try {
      const { postId } = req.params;
  
      const comments = await Comment.find({ post: postId })
        .populate("user", "name email imgUrl phoneNumber userType") // Merge user details
        .sort({ createdAt: -1 }); // Sort comments by latest
  
      res.status(200).send(comments);
    } catch (error) {
      res.status(500).send({ error: error.message });
    }
  };
  

module.exports = { createComment, getAllComments }; // Export the functions
