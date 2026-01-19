import 'package:flutter/material.dart';
import 'package:posts_ebtech/presentation/providers/posts_provider.dart';
import 'package:posts_ebtech/presentation/screens/post_details_screen.dart';
import 'package:posts_ebtech/presentation/widgets/add_post_comment_bottom_sheet.dart';
import 'package:posts_ebtech/presentation/widgets/post_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Posts', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '${provider.posts.length} posts',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              provider.loadPosts();
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddPostCommentBottomSheet(isComment: false),
          );
        },
      ),
      body:
          provider.isLoading
              ? ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                itemBuilder:
                    (_, __) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 190,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.posts.length,
                itemBuilder: (_, i) {
                  final post = provider.posts[i];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsScreen(post: post),
                        ),
                      );
                    },
                    child: PostCard(
                      avatarUrl:
                          'https://randomuser.me/api/portraits/men/32.jpg',
                      authorName: 'Mike Chen',
                      timeAgo: '22h ago',
                      title: post.title,
                      description:
                          'Web development is evolving rapidly with new frameworks and tools emerging every day. Staying...',
                      commentsCount: post.commentsCount ?? 0,
                    ),
                  );
                },
              ),
    );
  }
}
