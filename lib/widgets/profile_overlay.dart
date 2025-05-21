import 'package:flutter/material.dart';

class ProfileOverlay extends StatelessWidget {
  const ProfileOverlay({super.key, required this.offset, required this.size});

  final Offset offset;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: offset.dy + size.height + 8,
      right: 16,
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
              _menuItem(Icons.feedback, "Beri masukan", shortcut: "CTRL B"),
              // ⬇️ Logout dengan navigasi ke /login
              _menuItem(
                Icons.logout,
                "Keluar",
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
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
    );
  }

  static Widget _menuItem(
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
