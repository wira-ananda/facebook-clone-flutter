import 'package:flutter/material.dart';

class FacebookSidebar extends StatelessWidget {
  const FacebookSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFFF0F2F5), // Warna background sidebar
      padding: const EdgeInsets.only(top: 16),
      child: ListView(
        children: const [
          _SidebarItem(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
              radius: 12,
            ),
            title: 'Wira Ananda',
          ),
          _SidebarItem(
            icon: Icon(Icons.blur_circular, color: Colors.blueAccent),
            title: 'Meta AI',
          ),
          _SidebarItem(
            icon: Icon(Icons.people, color: Colors.blue),
            title: 'Teman',
          ),
          _SidebarItem(
            icon: Icon(Icons.history, color: Colors.lightBlue),
            title: 'Kenangan',
          ),
          _SidebarItem(
            icon: Icon(Icons.bookmark, color: Colors.pink),
            title: 'Tersimpan',
          ),
          _SidebarItem(
            icon: Icon(Icons.group, color: Colors.blue),
            title: 'Grup',
          ),
          _SidebarItem(
            icon: Icon(Icons.ondemand_video, color: Colors.lightBlue),
            title: 'Video',
          ),
          _SidebarItem(
            icon: Icon(Icons.storefront, color: Colors.blueAccent),
            title: 'Marketplace',
          ),
          Divider(),
          _SidebarItem(
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            title: 'Lihat selengkapnya',
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final Widget icon;
  final String title;

  const _SidebarItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      dense: true,
      horizontalTitleGap: 12,
    );
  }
}
