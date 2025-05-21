import 'package:flutter/material.dart';

class FacebookHeader extends StatelessWidget {
  const FacebookHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Kiri: Logo + Search Bar
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Image.asset('assets/facebook_logo.png', height: 32),
                const SizedBox(width: 10),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double screenWidth = MediaQuery.of(context).size.width;

                      if (screenWidth > 600) {
                        return Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Cari di Facebook',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search, color: Colors.grey),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // Tengah: Navigasi
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _NavIcon(icon: Icons.home, isActive: true),
                _NavIcon(icon: Icons.ondemand_video),
                _NavIcon(icon: Icons.storefront),
                _NavIcon(icon: Icons.videogame_asset),
              ],
            ),
          ),

          // Kanan: Aksi
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                _CircleIcon(icon: Icons.apps),
                _CircleIcon(icon: Icons.message, notification: '2'),
                _CircleIcon(icon: Icons.notifications, notification: '20+'),
                ProfileMenuButton(), // ⬅️ Tambahkan ini!
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const _NavIcon({required this.icon, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 40,
      alignment: Alignment.center,
      child: Icon(icon, color: isActive ? Colors.blue : Colors.grey[700]),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final String? notification;

  const _CircleIcon({required this.icon, this.notification});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.black87, size: 20),
        ),
        if (notification != null)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Text(
                notification!,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
      ],
    );
  }
}

class ProfileMenuButton extends StatefulWidget {
  const ProfileMenuButton({super.key});

  @override
  State<ProfileMenuButton> createState() => _ProfileMenuButtonState();
}

class _ProfileMenuButtonState extends State<ProfileMenuButton> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _toggleMenu() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder:
          (context) => Positioned(
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
                    _menuItem(
                      Icons.feedback,
                      "Beri masukan",
                      shortcut: "CTRL B",
                    ),
                    _menuItem(Icons.logout, "Keluar"),
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
    );
  }

  Widget _menuItem(IconData icon, String label, {String? shortcut}) {
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
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: _toggleMenu,
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/profile.jpg'),
        radius: 16,
      ),
    );
  }
}
