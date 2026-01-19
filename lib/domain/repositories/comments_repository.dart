import '../entities/comment.dart';

abstract class CommentsRepository {
  Future<List<Comment>> getCommentsByPostId(int postId);
  Future<bool> addComment(Comment comment);
}
