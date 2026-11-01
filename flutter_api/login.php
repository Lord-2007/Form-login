<?php
header("Content-Type: application/json");

// Hanya menerima metode POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["status" => "error", "message" => "Method not allowed"]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);
$username = isset($data['username']) ? trim($data['username']) : '';
$password = isset($data['password']) ? $data['password'] : '';

if ($username === '' || $password === '') {
    echo json_encode(["status" => "error", "message" => "Username dan password wajib diisi"]);
    exit;
}

$users = json_decode(file_get_contents("users.json"), true);

foreach ($users as $user) {
    if ($user['username'] === $username && $user['password'] === $password) {
        echo json_encode([
            "status"   => "success",
            "message"  => "Login successful",
            "username" => $user['username']
        ]);
        exit;
    }
}

echo json_encode(["status" => "error", "message" => "Invalid credentials"]);
