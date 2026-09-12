<?php
require_once 'config/db_connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'] ?? '';
    $phone = $_POST['phone'] ?? '';
    // NOTE: For simplicity this demo uses user_id = 1.
    // In a full version, pass the logged-in user's ID from the app.
    $user_id = $_POST['user_id'] ?? 1;

    if (empty($name) || empty($phone)) {
        echo json_encode(["success" => false, "message" => "Name and phone are required"]);
        exit;
    }

    $stmt = $conn->prepare("INSERT INTO emergency_contacts (user_id, name, phone) VALUES (?, ?, ?)");
    $stmt->bind_param("iss", $user_id, $name, $phone);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Contact added"]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to add contact"]);
    }

    $stmt->close();
}

$conn->close();
?>
