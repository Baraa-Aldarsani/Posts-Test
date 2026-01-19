import 'package:posts_ebtech/domain/repositories/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository repository;
  DeletePostUseCase(this.repository);

  Future<bool> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
