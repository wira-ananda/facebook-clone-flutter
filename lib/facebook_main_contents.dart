import 'package:fb/facebook_post_card.dart';
import 'package:flutter/material.dart';

class FacebookMainContent extends StatelessWidget {
  const FacebookMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          _StatusInputCard(),
          SizedBox(height: 10),
          _StoriesSection(),
          SizedBox(height: 10),

          // Tambahkan beberapa post card
          FacebookPostCard(),
          FacebookPostCard(),
          FacebookPostCard(),
        ],
      ),
    );
  }
}

// Komponen input status
class _StatusInputCard extends StatelessWidget {
  const _StatusInputCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  radius: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      hintText: 'Apa yang Anda pikirkan, Wira?',
                      hintStyle: const TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color(0xFFF0F2F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StatusAction(
                  icon: Icons.videocam,
                  label: 'Video siaran langsung',
                  color: Colors.red,
                ),
                _StatusAction(
                  icon: Icons.photo_library,
                  label: 'Foto/video',
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatusAction({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

// Komponen story
class _StoriesSection extends StatelessWidget {
  const _StoriesSection();

  @override
  Widget build(BuildContext context) {
    final stories = [
      {'name': 'Muhammad Fajar', 'label': 'Ulang tahun'},
      {'name': 'Quenn Ana', 'label': ''},
      {'name': 'PSM Makassar', 'label': ''},
      {'name': 'Hanif A.', 'label': ''},
    ];

    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: stories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _CreateStoryCard();
          }

          final story = stories[index - 1];
          return _StoryCard(
            name: story['name']!,
            label: story['label']!,
            imagePath: 'assets/story_${index - 1}.jpg',
          );
        },
      ),
    );
  }
}

class _CreateStoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/your_story.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 40,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(3),
              child: const Icon(Icons.add, color: Colors.blue, size: 20),
            ),
          ),
          const Positioned(
            bottom: 12,
            child: Text(
              'Buat cerita',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 1, color: Colors.black)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final String name;
  final String label;
  final String imagePath;

  const _StoryCard({
    required this.name,
    required this.label,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          if (label.isNotEmpty)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(label, style: const TextStyle(fontSize: 10)),
              ),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 8,
            right: 8,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 2, color: Colors.black)],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
