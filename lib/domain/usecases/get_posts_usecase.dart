import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class GetPostsUseCase {
  final PostsRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<Post>> call() {
    return repository.getPosts();
  }
}
