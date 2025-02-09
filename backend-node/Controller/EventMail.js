const nodemailer = require('nodemailer');
require('dotenv').config();

const senderEmail = process.env.SENDER_EMAIL;
const senderPass = process.env.SENDER_APP_PASS;

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: senderEmail,
        pass: senderPass
    }
});

const htmlContent = (userName, eventDescription, eventDate, longitude, latitude) => {
    return `
      <!DOCTYPE html>
<html>
<head>
    <title>Congratulations on Your Participation!</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            text-align: center;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
        }
        h1 {
            color: #4CAF50;
        }
        p {
            font-size: 16px;
            color: #555555;
        }
        .event-details {
            background-color: #e8f5e9;
            padding: 10px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .footer {
            margin-top: 20px;
            font-size: 12px;
            color: #888888;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Congratulations, ${userName}! 🎉</h1>
        <p>We are thrilled to have you participate in our event!</p>
        
        <div class="event-details">
            <p><strong>📅 Date:</strong> ${eventDate}</p>
            <p><strong>📍 Location:</strong> <a href="https://www.google.com/maps?q=${latitude},${longitude}" target="_blank">View on Google Maps</a></p>
            <p><strong>📝 Description:</strong> ${eventDescription}</p>
        </div>

        <p>We appreciate your enthusiasm and look forward to seeing you at more events in the future!</p>
        
        <p class="footer">Thank you for being part of our community! 🚀</p>
    </div>
</body>
</html>
    `;
};



const EventMail = async (req, res) => {
    const { user, description, eventDate, longitude, latitude } = req.body;

    const mailOptions = {
        from: senderEmail,
        to: user.email,
        subject: `Congratulations on Joining the Event`,
        html: htmlContent(user.username, description, eventDate, longitude, latitude)
    };

    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            console.error('Error sending email:', error);
            res.status(500).send('Error sending email');
        } else {
            console.log('Email sent:', info.response);
            res.status(200).send('Email sent successfully');
        }
    });
};



module.exports = EventMail;
