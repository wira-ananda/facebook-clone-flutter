import 'package:flutter/material.dart';

class FacebookMobileMenu extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onLogout;

  const FacebookMobileMenu({
    super.key,
    required this.onClose,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          color: Colors.black.withOpacity(0.3), // Backdrop
          child: Center(
            child: Material(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 300,
                height: MediaQuery.of(context).size.height * 0.85,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.arrow_back),
                        const SizedBox(width: 8),
                        const Text(
                          "Menu",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: onClose,
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const Divider(),

                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _menuItem("Reels", Icons.movie),
                            _menuItem("Pesan", Icons.message),
                            _menuItem("Grup", Icons.group),
                            _menuItem("Video", Icons.ondemand_video),
                            _menuItem("Marketplace", Icons.store),
                            _menuItem("Halaman", Icons.flag),
                            _menuItem("Tersimpan", Icons.bookmark),
                            _menuItem("Acara", Icons.event),
                            _menuItem("Kenangan", Icons.history),
                            _menuItem("Game", Icons.games),
                            _menuItem("Pengelola Iklan", Icons.campaign),
                          ],
                        ),
                      ),
                    ),

                    const Divider(),

                    // Logout button
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Keluar"),
                      onTap: onLogout,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(String title, IconData icon) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: () {});
  }
}
