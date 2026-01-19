import '../entities/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts();
  Future<bool> addPost(Post post);
  Future<bool> deletePost(int postId);
}
