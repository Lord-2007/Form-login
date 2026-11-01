import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cek apakah user masih punya sesi login tersimpan
  final username = await AuthService.getLoggedInUser();

  runApp(MyApp(startUsername: username));
}

class MyApp extends StatelessWidget {
  final String? startUsername;
  const MyApp({super.key, this.startUsername});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login API',
      debugShowCheckedModeBanner: false,
      home: startUsername != null
          ? HomePage(username: startUsername!)
          : const LoginPage(),
    );
  }
}
