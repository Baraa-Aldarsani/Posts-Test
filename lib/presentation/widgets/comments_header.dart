import 'package:flutter/material.dart';
import 'package:posts_ebtech/presentation/widgets/add_post_comment_bottom_sheet.dart';

class CommentsHeader extends StatelessWidget {
  CommentsHeader({super.key, required this.id});
  int id;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Comments',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (_) => AddPostCommentBottomSheet(isComment: true, postId: id),
            );
          },
          child: const Text(
            'Add Comment',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
