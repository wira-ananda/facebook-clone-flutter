import 'package:flutter/material.dart';
import 'facebook_main_contents.dart'; // Pastikan file ini ada dan sudah benar

class FacebookHeaderMobile extends StatelessWidget {
  const FacebookHeaderMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> iconBadges = const [
      _IconBadge(icon: Icons.home, badge: '15+'),
      _IconBadge(icon: Icons.people, badge: '2'),
      _IconBadge(icon: Icons.chat, badge: '2'),
      _IconBadge(icon: Icons.tv, badge: '15+'),
      _IconBadge(icon: Icons.notifications, badge: '15+'),
      _IconBadge(icon: Icons.store, badge: ''),
    ];

    return Column(
      children: [
        // Top bar: logo, search, menu
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: const [
              Text(
                'facebook',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                ),
              ),
              Spacer(),
              Icon(Icons.search, size: 26),
              SizedBox(width: 12),
              Icon(Icons.menu, size: 26),
            ],
          ),
        ),

        // Icon bar with badges
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: iconBadges,
          ),
        ),

        const Divider(height: 1),

        // Konten utama (status, story, post) di bawah header mobile
        const Expanded(child: FacebookMainContent()),
      ],
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final String badge;

  const _IconBadge({required this.icon, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: 28),
        if (badge.isNotEmpty)
          Positioned(
            top: -6,
            right: -8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(minWidth: 20),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
