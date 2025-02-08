const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../../Models/UserModel');

async function loginUser(req, res) {

    const { email, password } = req.body;
    
    const jwtSecret=process.env.JWT_SECRET
    try {
        // Check if the user exists
        const user = await User.findOne({ email });

        if (!user) {
            return res.status(400).json({ message: 'Invalid email or password' });
        }

        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid email or password' });
        }

        // Generate a JWT token
        const token = jwt.sign({ id: user._id }, jwtSecret, { expiresIn: '720h' });

        return res.status(200).json({
            message: 'Login successful',
            user: {
                id: user._id,
                username: user.name,
                email: user.email,
            },
            token: token
        });
    } catch (error) {
        console.error(error.message);
        return res.status(500).json({ message: 'Server error' });
    }
}

module.exports = loginUser;
