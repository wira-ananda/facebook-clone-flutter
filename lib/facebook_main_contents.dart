import 'package:fb/status_input_card.dart';
import 'package:fb/stories_section.dart';
import 'package:flutter/material.dart';
import 'package:fb/models/post.dart';
import 'package:fb/services/post_service.dart';
import 'package:fb/facebook_post_card.dart';

class FacebookMainContent extends StatefulWidget {
  const FacebookMainContent({super.key});

  @override
  State<FacebookMainContent> createState() => _FacebookMainContentState();
}

class _FacebookMainContentState extends State<FacebookMainContent> {
  late Future<List<Post>> futurePosts;

  Future<void> _loadPosts() async {
    futurePosts = PostService.fetchPosts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _handleNewPost() => _loadPosts();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StatusInputCard(onPostSuccess: _handleNewPost),
          const SizedBox(height: 10),
          const StoriesSection(),
          const SizedBox(height: 10),
          FutureBuilder<List<Post>>(
            future: futurePosts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              final posts = snapshot.data ?? [];

              return Column(
                children:
                    posts.map((post) => FacebookPostCard(post: post)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
