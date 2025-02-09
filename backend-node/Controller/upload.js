const axios = require("axios");
const FormData = require("form-data");
const fs = require("fs");

const uploadImage = async (imagePath) => {
    try {
        const formData = new FormData();
        formData.append("image", fs.createReadStream(imagePath)); // Attach file

        const response = await axios.post("https://pleasant-nearby-hermit.ngrok-free.app/pokemon_images/upload.php", formData, {
            headers: {
                ...formData.getHeaders(), // Include correct form-data headers
            },
        });

        console.log("Response:", response.data);
    } catch (error) {
        console.error("Error uploading image:", error.message);
    }
};
module.exports=uploadImage
// Usage
