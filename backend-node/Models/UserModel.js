const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  name: {
    type: String,
    trim: true,
  },
  username: {
    type: String,
    unique: true, // Ensure usernames are unique
    required: true, // Make username required
    trim: true,
  },
  email: {
    type: String,
    unique: true,
    lowercase: true,
    trim: true,
  },
  
  // storing password hash is recommended
  password: {
    type: String,
  },
  // Profile image URL
  imgUrl: {
    type: String,
    trim: true,
  },
  // Optional type field, e.g., "regular", "admin"
  userType: {
    type: String,
    enum: ['regular', 'admin'],
    default: 'regular',
  },
  // Optional degree field (could be educational qualification)
  degree: {
    type: String,
  },
  // Contact number or any numeric field
  phoneNumber: {
    type: String,
  },
  // Points earned by the user through contributions
  points: {
    type: Number,
    default: 0,
  },
  // User location with separate latitude and longitude fields
  latitude: {
    type: Number,
    required: true, // Optional: make it required if necessary
  },
  longitude: {
    type: Number,
    required: true, // Optional: make it required if necessary
  }
}, { timestamps: true });

module.exports = mongoose.model('User', UserSchema);
