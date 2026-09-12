<?php
require_once 'config/db_connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $latitude = $_POST['latitude'] ?? 0;
    $longitude = $_POST['longitude'] ?? 0;
    // NOTE: For simplicity this demo uses user_id = 1.
    $user_id = $_POST['user_id'] ?? 1;

    $stmt = $conn->prepare("INSERT INTO sos_events (user_id, latitude, longitude) VALUES (?, ?, ?)");
    $stmt->bind_param("idd", $user_id, $latitude, $longitude);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "SOS event logged"]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to log SOS event"]);
    }

    $stmt->close();
}

$conn->close();
?>
