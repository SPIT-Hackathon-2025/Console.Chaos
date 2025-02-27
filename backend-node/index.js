const express = require('express'); // Import express
const mongoose = require('mongoose'); // Import mongoose
const app = express(); // Create an instance of express
const cors=require('cors')
require('dotenv').config()
app.use(cors())

const uri = "mongodb+srv://rorifim199:vpJzSwKhWjECoho9@spithack1.ul5ys.mongodb.net/?retryWrites=true&w=majority&appName=SpitHack1"; // Replace 'your_actual_password' with your MongoDB password

const PORT = 3000; // Define the port
app.use(express.json())
const userRoutes = require('./Routes/user_Routes');
const postRoutes = require('./Routes/postRoute');
const commentRoutes = require('./Routes/commentRoute');
const authRoute = require('./Routes/authRoute');
const LFRoutes = require('./Routes/Lost&FoundRoute');
const eventRoutes = require('./Routes/eventRoutes');
const aiRoutes = require('./Routes/aiRoutes');

// Connect to MongoDB using Mongoose
mongoose.connect(uri)
  .then(() => console.log("Connected to MongoDB!"))
  .catch(err => console.error("Could not connect to MongoDB:", err));

app.get('/', (req, res) => { // Define a route
    res.send('Hello World!'); // Send a response
});

app.listen(PORT, () => { // Start the server
    console.log(`Server is running on http://localhost:${PORT}`); // Log the server status
});

app.use('/api/auth', authRoute)
app.use('/api/user', userRoutes)
app.use('/api/post', postRoutes)
app.use('/api/comments', commentRoutes)
app.use('/api/lostandfound', LFRoutes)
app.use('/api/event', eventRoutes)
app.use('/api/aiRoutes',aiRoutes )

