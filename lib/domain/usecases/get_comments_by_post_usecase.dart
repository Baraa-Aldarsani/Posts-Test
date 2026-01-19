import 'package:posts_ebtech/domain/repositories/comments_repository.dart';

import '../entities/comment.dart';

class GetCommentsByPostUseCase {
  final CommentsRepository  repository;

  GetCommentsByPostUseCase(this.repository);

  Future<List<Comment>> call(int postId) {
    return repository.getCommentsByPostId(postId);
  }
}
