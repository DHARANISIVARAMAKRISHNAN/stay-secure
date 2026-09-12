<?php
// Database connection settings
// ⚠️ Change these if your MySQL username/password is different
// (default XAMPP username is "root" with an empty password)

$host = "localhost";
$db_name = "stay_secure_db";
$username = "root";
$password = "";

$conn = new mysqli($host, $username, $password, $db_name);

if ($conn->connect_error) {
    die(json_encode([
        "success" => false,
        "message" => "Database connection failed: " . $conn->connect_error
    ]));
}

// Allow requests from the Flutter app (CORS)
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
?>
