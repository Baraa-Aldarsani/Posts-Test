import 'package:posts_ebtech/domain/entities/post.dart';
import 'package:posts_ebtech/domain/repositories/posts_repository.dart';

class AddPostUseCase {
  final PostsRepository repository;

  AddPostUseCase(this.repository);

  Future<bool> call(Post post) async {
    return await repository.addPost(post);
  }
}
