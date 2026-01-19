import 'package:flutter/material.dart';
import 'package:posts_ebtech/domain/entities/post.dart';
import 'package:posts_ebtech/presentation/providers/comments_provider.dart';
import 'package:posts_ebtech/presentation/widgets/comment_card.dart';
import 'package:posts_ebtech/presentation/widgets/comments_header.dart';
import 'package:posts_ebtech/presentation/widgets/post_details_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({super.key, required this.post});
  Post post;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommentsProvider>().loadComments(widget.post.id ?? -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Post Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostDetailsCard(post: widget.post),
            const SizedBox(height: 24),
            CommentsHeader(id: widget.post.id ?? -1),
            const SizedBox(height: 16),
            Consumer<CommentsProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return Column(
                    children: List.generate(
                      3,
                      (index) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 10,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: double.infinity,
                                      height: 12,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      width: 150,
                                      height: 12,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                if (provider.comments.isEmpty) {
                  return const Text(
                    'No comments yet',
                    style: TextStyle(color: Colors.grey),
                  );
                }

                return Column(
                  children:
                      provider.comments.map((comment) {
                        return CommentCard(
                          authorName: 'User ${comment.id}',
                          timeAgo: '21h ago',
                          body: comment.body,
                        );
                      }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
