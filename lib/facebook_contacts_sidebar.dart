import 'package:flutter/material.dart';

class FacebookContactsSidebar extends StatelessWidget {
  const FacebookContactsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data kontak
    final contacts = [
      'Nurul Auliah',
      'Elhax Awen',
      'Tri Sktii',
      'Mhmm Rezky',
      'Harun Muchtar',
      'Antye Munandar Huzmar',
      'Juliana Yhuli',
      'Ancha Khonjo',
      'Rizkha Iychka',
      'Rika Astari Bakri',
      'Azzahrah',
      'Qaa II',
      'Andnii',
    ];

    return Container(
      width: 250,
      color: const Color(0xFFF0F2F5),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Kontak
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Kontak', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.search, size: 18),
                  SizedBox(width: 10),
                  Icon(Icons.more_horiz, size: 18),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // List Kontak
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return _ContactItem(
                  name: contacts[index],
                  imagePath:
                      'assets/profile.jpg', // Ganti sesuai kontak jika ada
                );
              },
            ),
          ),

          // Tombol Chat
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              mini: true,
              onPressed: () {},
              backgroundColor: Colors.white,
              child: const Icon(Icons.edit, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final String name;
  final String imagePath;

  const _ContactItem({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 10,
      leading: Stack(
        children: [
          CircleAvatar(radius: 16, backgroundImage: AssetImage(imagePath)),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          ),
        ],
      ),
      title: Text(name, style: const TextStyle(fontSize: 13)),
    );
  }
}
