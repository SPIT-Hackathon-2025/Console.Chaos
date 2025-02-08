const mongoose = require('mongoose');

const PostSchema = new mongoose.Schema({
  // URL for any image associated with the post
  imgUrl: {
    type: String,
  },
  title: {
    type: String,
    trim: true,
  },
  // Linking post to the user who created it
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
  },
  // Voting mechanism
  upvotes: {
    type: Number,
    default: 0,
  },
  downvotes: {
    type: Number,
    default: 0,
  },
  // Detailed description of the issue
  description: {
    type: String,
  },
  // Date of creation (can be used alongside timestamps)
  date: {
    type: Date,
    default: Date.now,
  },
  // Unix timestamp, if needed for specific client logic
  timestamp: {
    type: Number,
    default: () => Date.now(),
  },
  // Location stored as GeoJSON for spatial queries
  location: {
    type: {
      type: String,
      enum: ['Point'],
      default: 'Point'
    },
    coordinates: {
      type: [Number], // [longitude, latitude]
      index: '2dsphere',
    }
  },
  // Array of tags for categorization
  tags: [{
    type: String,
    trim: true,
  }]
}, { timestamps: true });

module.exports = mongoose.model('Post', PostSchema);
