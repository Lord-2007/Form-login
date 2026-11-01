# Latihan Login & Logout – Flutter + REST API (PHP)

## Struktur
- flutter_api/  -> salin ke C:\xampp\htdocs\flutter_api  (login.php, users.json)
- flutter_app/lib/  -> salin ke folder lib/ project Flutter
- flutter_app/pubspec_dependencies.yaml -> tambahkan ke pubspec.yaml

## Menjalankan
1. Start Apache di XAMPP/Laragon.
2. Tes API (opsional):
   curl -X POST http://localhost/flutter_api/login.php -H "Content-Type: application/json" -d "{\"username\":\"Ahmad royak\",\"password\":\"5250411242\"}"
3. flutter pub get, lalu flutter run.
4. Login: username `Ahmad royak`, password `5250411242`.

## Catatan
- Emulator Android: baseUrl harus 10.0.2.2, bukan localhost.
- HP fisik: pakai IP komputer (satu jaringan Wi-Fi).
- Ke depan, password di server sebaiknya di-hash (password_hash / password_verify).
