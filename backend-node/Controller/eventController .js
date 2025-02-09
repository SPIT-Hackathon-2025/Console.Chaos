const Event = require("../Models/Event");
const jwt = require("jsonwebtoken");
const jwtSecret = process.env.JWT_SECRET; // Replace with your actual secret

// Create a new event
const createEvent = async (req, res) => {
  try {
    const { imgUrl, token, description, tags, eventDate,longitude,latitude } = req.body;
    console.log(req.body);
    
    const user = jwt.verify(token, jwtSecret).id;

    // Format date to DDMMYYYY if not provided
    const formattedDate = eventDate || new Date().toLocaleDateString("en-GB").split("/").join("");

    const newEvent = new Event({
      imgUrl,
      user,
      description: description || "", // Default to empty string if not provided
      tags: tags || [], // Default to empty array if not provided
      eventDate: formattedDate,
      longitude:longitude,
      latitude:latitude

    });

    await newEvent.save();
    res.status(201).send({ message: "Event created successfully", event: newEvent });

  } catch (error) {
    res.status(500).send({ error: error.message });
  }
};

// Get all events
const getAllEvents = async (req, res) => {
  try {
    const events = await Event.find()
      .populate("user", "username email imgUrl phoneNumber userType") // Include necessary user fields
      .sort({ createdAt: -1 });

    res.status(200).send(events);

  } catch (error) {
    res.status(500).send({ error: error.message });
  }
};

module.exports = { createEvent, getAllEvents };
