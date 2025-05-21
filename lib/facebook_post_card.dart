import 'package:flutter/material.dart';

class FacebookPostCard extends StatelessWidget {
  const FacebookPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Atas (User Info)
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/lowcostcosplay.jpg'),
            ),
            title: const Text(
              'Lowcostcosplay',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: const [
                Text('2 menit yang lalu • ', style: TextStyle(fontSize: 12)),
                Icon(Icons.public, size: 12),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ),

          // Caption
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Radish... Lihat selengkapnya'),
          ),

          const SizedBox(height: 10),

          // Gambar Utama
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/post_radish.jpg'),
            ),
          ),

          const SizedBox(height: 10),

          // Reaksi & Komentar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Icon(Icons.emoji_emotions, color: Colors.orange, size: 18),
                SizedBox(width: 4),
                Text('215'),
                Spacer(),
                Text('5 komentar   5 kali dibagikan'),
              ],
            ),
          ),

          const Divider(),

          // Tombol Aksi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                PostActionButton(
                  icon: Icons.thumb_up_alt_outlined,
                  label: 'Suka',
                ),
                PostActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Komentari',
                ),
                PostActionButton(icon: Icons.share_outlined, label: 'Bagikan'),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class PostActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const PostActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18, color: Colors.grey[700]),
      label: Text(
        label,
        style: const TextStyle(color: Colors.black87, fontSize: 13),
      ),
    );
  }
}
