<?php
require_once 'config/db_connect.php';

// NOTE: For simplicity this demo returns contacts for user_id = 1.
// In a full version, pass the logged-in user's ID as a GET parameter.
$user_id = $_GET['user_id'] ?? 1;

$stmt = $conn->prepare("SELECT id, name, phone FROM emergency_contacts WHERE user_id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

$contacts = [];
while ($row = $result->fetch_assoc()) {
    $contacts[] = $row;
}

echo json_encode(["success" => true, "contacts" => $contacts]);

$stmt->close();
$conn->close();
?>
