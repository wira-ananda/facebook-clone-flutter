import 'package:flutter/material.dart';
import 'facebook_main_contents.dart';
import './widgets/facebook_mobile_menu.dart';

class FacebookHeaderMobile extends StatefulWidget {
  const FacebookHeaderMobile({super.key});

  @override
  State<FacebookHeaderMobile> createState() => _FacebookHeaderMobileState();
}

class _FacebookHeaderMobileState extends State<FacebookHeaderMobile>
    with SingleTickerProviderStateMixin {
  bool _showMenu = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
  }

  void _toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
      if (_showMenu) {
        _fadeController.forward();
      } else {
        _fadeController.reverse();
      }
    });
  }

  void _closeMenu() {
    _fadeController.reverse().then((_) {
      setState(() => _showMenu = false);
    });
  }

  void _logout() {
    _fadeController.reverse().then((_) {
      setState(() => _showMenu = false);
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

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

    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'facebook',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.search, size: 26),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _toggleMenu,
                    child: const Icon(Icons.menu, size: 26),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: iconBadges,
              ),
            ),
            const Divider(height: 1),
            const Expanded(child: FacebookMainContent()),
          ],
        ),

        // Overlay menu
        if (_showMenu)
          FadeTransition(
            opacity: _fadeAnimation,
            child: FacebookMobileMenu(onClose: _closeMenu, onLogout: _logout),
          ),
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
