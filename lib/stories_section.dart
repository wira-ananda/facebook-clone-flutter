import 'package:flutter/material.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

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
          if (index == 0) return const CreateStoryCard();

          final story = stories[index - 1];
          return StoryCard(
            name: story['name']!,
            label: story['label']!,
            imagePath: 'assets/story_${index - 1}.jpg',
          );
        },
      ),
    );
  }
}

class CreateStoryCard extends StatelessWidget {
  const CreateStoryCard({super.key});

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

class StoryCard extends StatelessWidget {
  final String name;
  final String label;
  final String imagePath;

  const StoryCard({
    super.key,
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
