const mongoose = require('mongoose');

const LostFoundCommentSchema = new mongoose.Schema({
  // The text content of the comment
  comment: {
    type: String,
    required: true,
    trim: true,
  },
  // Voting fields
  upvotes: {
    type: Number,
    default: 0,
  },
  downvotes: {
    type: Number,
    default: 0,
  },
  // Reference to the user who posted this comment
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  // Reference to the LostFound item this comment is associated with
  lostFound: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'LostFound',
    required: true,
  },
  // Tags for the comment; defaults to ["normal"] unless the user explicitly tags it (e.g., "ClaimingThis")
  tags: {
    type: [String],
    default: ['normal']
  }
}, {
  // Custom timestamps: 'posted' for creation time and 'updated' for last update
  timestamps: { createdAt: 'posted', updatedAt: 'updated' }
});

module.exports = mongoose.model('LostFoundComment', LostFoundCommentSchema);
