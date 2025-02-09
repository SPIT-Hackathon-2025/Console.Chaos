const mongoose = require('mongoose');

const LostFoundPostSchema = new mongoose.Schema({
  imgUrl: {
    type: String,
    required: false, // Optional image URL
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  tags: [{
    type: String,
    trim: true,
  }],
}, { timestamps: true });

module.exports = mongoose.model('LostFoundPost', LostFoundPostSchema);
