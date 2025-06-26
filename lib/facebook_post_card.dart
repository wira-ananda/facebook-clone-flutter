import 'package:flutter/material.dart';
import 'models/post.dart'; // Pastikan path ini sesuai dengan struktur folder kamu

class FacebookPostCard extends StatelessWidget {
  final Post post;

  const FacebookPostCard({super.key, required this.post});

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
              backgroundImage: AssetImage(
                'assets/profile.jpg',
              ), // Default profil
            ),
            title: Text(
              'User ${post.userId}', // Ganti nanti dengan post.user.name kalau sudah ada
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Text(post.createdAt, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 4),
                const Icon(Icons.public, size: 12),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ),

          // Konten Status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(post.content),
          ),

          const SizedBox(height: 10),

          // Menampilkan gambar jika tersedia
          if (post.imageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  post.imageUrl,
                  errorBuilder:
                      (context, error, stackTrace) => const Text(
                        "Gambar gagal dimuat",
                        style: TextStyle(color: Colors.red),
                      ),
                ),
              ),
            ),

          const SizedBox(height: 10),

          // Reaksi & Komentar (dummy sementara)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
