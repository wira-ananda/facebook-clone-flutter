// file: widgets/responsive_layout.dart
import 'package:flutter/material.dart';
import '../facebook_header.dart' as desktop;
import '../facebook_header_mobile.dart' as mobile;
import '../facebook_sidebar.dart';
import '../facebook_contacts_sidebar.dart';
import '../facebook_main_contents.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.FacebookHeaderMobile();
        } else {
          return Column(
            children: [
              const desktop.FacebookHeader(),
              Expanded(
                child: Row(
                  children: const [
                    FacebookSidebar(),
                    Expanded(child: Center(child: FacebookMainContent())),
                    FacebookContactsSidebar(),
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
