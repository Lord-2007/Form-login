import 'package:flutter/material.dart';
import 'home_page.dart';
import 'services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  String result = "";
  bool isLoading = false;

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    if (userController.text.trim().isEmpty || passController.text.isEmpty) {
      setState(() => result = "Username dan password wajib diisi");
      return;
    }

    setState(() {
      isLoading = true;
      result = "";
    });

    final response = await AuthService.login(
      userController.text.trim(),
      passController.text,
    );

    if (!mounted) return;

    if (response['status'] == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(username: response['username']),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
        result = response['message'] ?? 'Terjadi kesalahan';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login API")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: userController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : handleLogin,
              child: isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Login"),
            ),
            const SizedBox(height: 20),
            Text(result, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
