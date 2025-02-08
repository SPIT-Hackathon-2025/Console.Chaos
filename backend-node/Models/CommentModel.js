const mongoose = require('mongoose');

const CommentSchema = new mongoose.Schema({
  comment: {
    type: String,
    trim: true,
  },
  upvotes: {
    type: Number,
    default: 0,
  },
  downvotes: {
    type: Number,
    default: 0,
  },
  // Linking comment to the user who posted it
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
  },
  // Linking comment to the post it belongs to
  post: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Post',
  },
  // Optional tags for the comment (e.g., sentiment or categorization)
  tags: [{
    type: String,
    trim: true,
  }]
}, { 
  // Use custom names for timestamps if needed. Here, 'createdAt' is renamed to 'posted'.
  timestamps: { createdAt: 'posted', updatedAt: 'updated' } 
});

module.exports = mongoose.model('Comment', CommentSchema);
