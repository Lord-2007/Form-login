import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Emulator Android: 10.0.2.2 = localhost milik komputer.
  // HP fisik: ganti dengan IP komputer, mis. http://192.168.1.10/flutter_api
  static const String baseUrl = 'http://10.0.2.2/flutter_api';

  static const String _keyUsername = 'logged_in_username';

  /// Kirim username & password ke API, simpan sesi jika berhasil.
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login.php'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'username': username, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (data['status'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_keyUsername, data['username'] ?? username);
      }
      return data;
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Tidak dapat terhubung ke server. Pastikan Apache aktif.',
      };
    }
  }

  /// Ambil username yang sedang login (null jika belum login).
  static Future<String?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  /// Logout: hapus sesi lokal.
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
  }
}
