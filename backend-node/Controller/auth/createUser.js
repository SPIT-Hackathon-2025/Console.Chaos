const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../../Models/UserModel');

async function registerUser(req, res) {
    console.log(req.body);
    
    const { username, email, password,longitude=72.8362765,latitude=19.1231786 } = req.body;
    const jwtSecret = process.env.JWT_SECRET
    try {
        // Check if the user already exists
        const userExists = await User.findOne({ email });

        if (userExists) {
            return res.status(400).json({ message: 'User with this email already exists' });
        }

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // Create new user
        const newUser = new User({
            username: username,
            email,
            password: hashedPassword,
            longitude:longitude,
            latitude:latitude
          });

        await newUser.save();

        const token = jwt.sign({ id: newUser._id }, jwtSecret, { expiresIn: '720h' });

        return res.status(201).json({
            message: 'User registered successfully',
            user: {
                id: newUser._id,
                username: newUser.name,
                email: newUser.email,
            },
            token: token,
        });
    } catch (error) {
        console.error(error.message);
        return res.status(500).json({ message: 'Server error' });
    }
}

module.exports = registerUser;
