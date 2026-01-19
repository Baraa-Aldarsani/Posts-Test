import 'package:posts_ebtech/domain/entities/comment.dart';
import 'package:posts_ebtech/domain/repositories/comments_repository.dart';

class AddCommentUseCase {
  final CommentsRepository repository;
  AddCommentUseCase(this.repository);

  Future<bool> call(Comment comment) async {
    return await repository.addComment(comment);
  }
}