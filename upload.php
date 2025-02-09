<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$upload_dir = "C:/xampp/htdocs/pokemon_images/"; // Ensure this folder exists

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_FILES["image"])) {
    $file = $_FILES["image"];
    $filename = time() . "_" . basename($file["name"]); // Unique filename
    $file_path = $upload_dir . $filename;

    // Move the uploaded file to the target folder
    if (move_uploaded_file($file["tmp_name"], $file_path)) {
        echo json_encode(["imageUrl" => "http://localhost/pokemon_images/" . $filename]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => "Failed to upload image"]);
    }
} else {
    http_response_code(400);
    echo json_encode(["error" => "No image uploaded"]);
}

?>