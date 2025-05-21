import 'package:flutter/material.dart';
import '../widgets/login_mobile.dart';
import '../widgets/login_desktop.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: isMobile ? const LoginMobile() : const LoginDesktop(),
    );
  }
}
