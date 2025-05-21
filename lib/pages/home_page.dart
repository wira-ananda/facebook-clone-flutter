// file: pages/home_page.dart
import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ResponsiveLayout()));
  }
}
