import 'package:flutter/material.dart';
import 'package:posts_ebtech/domain/entities/post.dart';
import 'package:posts_ebtech/presentation/providers/comments_provider.dart';
import 'package:posts_ebtech/presentation/providers/posts_provider.dart';
import 'package:provider/provider.dart';

class AddPostCommentBottomSheet extends StatefulWidget {
  final bool isComment;
  final int? postId;
  const AddPostCommentBottomSheet({
    super.key,
    required this.isComment,
    this.postId,
  });

  @override
  State<AddPostCommentBottomSheet> createState() =>
      _AddPostCommentBottomSheetState();
}

class _AddPostCommentBottomSheetState extends State<AddPostCommentBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostsProvider>(context);
    final commentsProvider = Provider.of<CommentsProvider>(context);
    final bool isLoading =
        widget.isComment ? commentsProvider.isLoading : postsProvider.isLoading;
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isComment ? 'Add New Comment' : 'Create New Post',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.isComment
                      ? 'Share your thoughts'
                      : 'Share your thoughts with the community',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  'Your Name',
                  nameController,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Name is required'
                              : null,
                ),
                const SizedBox(height: 15),

                _buildTextField(
                  widget.isComment ? 'Email' : 'Title',
                  titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (widget.isComment && !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                _buildTextField(
                  widget.isComment ? 'Comment' : 'Content',
                  contentController,
                  maxLines: 3,
                  validator:
                      (value) =>
                          (value == null || value.length < 5)
                              ? 'Minimum 5 characters'
                              : null,
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 40),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed:
                            isLoading
                                ? null
                                : () async {
                                  if (_formKey.currentState!.validate()) {
                                    final title = titleController.text.trim();
                                    final comment =
                                        contentController.text.trim();
                                    String result;
                                    if (widget.isComment) {
                                      result = await commentsProvider
                                          .addComment(
                                            widget.postId ?? -1,
                                            comment,
                                          );
                                    } else {
                                      result = await postsProvider.addPost(
                                        Post(title: title),
                                      );
                                    }

                                    if (mounted) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(result)),
                                      );
                                    }
                                  }
                                },
                        child:
                            isLoading
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : Text(
                                  widget.isComment ? 'Add' : 'Create',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
