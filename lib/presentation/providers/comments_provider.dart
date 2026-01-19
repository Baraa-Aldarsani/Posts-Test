import 'package:flutter/material.dart';
import 'package:posts_ebtech/domain/usecases/add_comment_usecase.dart';
import '../../domain/entities/comment.dart';
import '../../domain/usecases/get_comments_by_post_usecase.dart';

class CommentsProvider extends ChangeNotifier {
  final GetCommentsByPostUseCase getComments;
  final AddCommentUseCase addCommentUseCase;
  CommentsProvider(this.getComments, this.addCommentUseCase);

  bool isLoading = false;
  List<Comment> comments = [];

  Future<void> loadComments(int postId) async {
    isLoading = true;
    notifyListeners();

    comments = await getComments(postId);

    isLoading = false;
    notifyListeners();
  }

  Future<String> addComment(int postId, String body) async {
    isLoading = true;
    notifyListeners();

    final newComment = Comment(id: 0, postId: postId, body: body);
    bool success = await addCommentUseCase(newComment);

    if (success) {
      comments.insert(0, newComment);
    }

    isLoading = false;
    notifyListeners();

    return success ? "Comment added successfully" : "Failed to add comment";
  }
}
