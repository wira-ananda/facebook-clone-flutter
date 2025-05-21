import 'package:flutter/material.dart';

class ProfileOverlay extends StatefulWidget {
  final Offset offset;
  final Size size;
  final VoidCallback onLogout;
  final VoidCallback onDismiss;

  const ProfileOverlay({
    super.key,
    required this.offset,
    required this.size,
    required this.onLogout,
    required this.onDismiss,
  });

  @override
  State<ProfileOverlay> createState() => _ProfileOverlayState();
}

class _ProfileOverlayState extends State<ProfileOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  void _close() async {
    await _controller.reverse(); // play fade out
    widget.onDismiss(); // remove overlay
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background that detects taps outside the overlay
        Positioned.fill(
          child: GestureDetector(
            onTap: _close,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          top: widget.offset.dy + widget.size.height + 8,
          right: 16,
          child: FadeTransition(
            opacity: _opacity,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      title: const Text('Wira Ananda'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      title: const Text('Qoutes Bola'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      title: const Text('Wira Ananda'),
                      onTap: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.switch_account),
                        label: const Text("Lihat Semua Profil"),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                        ),
                      ),
                    ),
                    const Divider(),
                    _menuItem(Icons.settings, "Setelan & privasi"),
                    _menuItem(Icons.help, "Bantuan & dukungan"),
                    _menuItem(Icons.brightness_6, "Tampilan & aksesibilitas"),
                    _menuItem(
                      Icons.feedback,
                      "Beri masukan",
                      shortcut: "CTRL B",
                    ),
                    _menuItem(
                      Icons.logout,
                      "Keluar",
                      onTap: () {
                        _close();
                        widget.onLogout();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Meta © 2025",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuItem(
    IconData icon,
    String label, {
    String? shortcut,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 22),
      title: Text(label),
      trailing:
          shortcut != null
              ? Text(
                shortcut,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
              : null,
      onTap: onTap,
    );
  }
}
