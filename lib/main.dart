import 'package:fb/facebook_contacts_sidebar.dart';
import 'package:fb/facebook_main_contents.dart';
import 'package:flutter/material.dart';
import 'facebook_header.dart' as desktop;
import 'facebook_header_mobile.dart' as mobile;
import 'facebook_sidebar.dart'; // import sidebar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SafeArea(child: ResponsiveLayout())),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile Layout: hanya header mobile
          return const mobile.FacebookHeaderMobile();
        } else {
          // Desktop Layout: header + sidebar kiri
          return Column(
            children: [
              const desktop.FacebookHeader(),
              Expanded(
                child: Row(
                  children: const [
                    FacebookSidebar(), // Sidebar kiri
                    Expanded(child: Center(child: FacebookMainContent())),
                    FacebookContactsSidebar(), // Sidebar kanan
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
