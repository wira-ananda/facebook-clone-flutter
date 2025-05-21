// file: main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart'; // pastikan file ini ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ⬇️ Ini menentukan halaman pertama
      initialRoute: '/login',

      // ⬇️ Daftar halaman berdasarkan route
      routes: {
        '/login': (context) => const LoginPage(),
        '/': (context) => const HomePage(),
      },
    );
  }
}
