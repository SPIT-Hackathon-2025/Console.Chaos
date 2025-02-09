const mongoose = require('mongoose');

const EventSchema = new mongoose.Schema({
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
    trim: true,
    required: false, // Optional description
  },
  tags: [{
    type: String,
    trim: true,
  }],
  eventDate: {
    type: String, // Storing in DDMMYYYY format as a string
    required: true,
  },
  latitude: {
    type: Number,
    required: true,
  },
  longitude: {
    type: Number,
    required: true,
  }
}, { timestamps: true });

module.exports = mongoose.model('Event', EventSchema);
