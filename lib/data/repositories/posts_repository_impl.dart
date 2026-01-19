import 'package:posts_ebtech/data/models/post_model.dart';

import '../../domain/entities/post.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/remote/posts_remote_datasource.dart';
import '../datasources/local/posts_local_datasource.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource remote;
  final PostsLocalDataSource local;

  PostsRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Post>> getPosts() async {
    try {
      final posts = await remote.fetchPosts();
      final comments = await remote.fetchComments();

      await local.cachePosts(posts);

      return posts.map((post) {
        final count = comments.where((c) => c.postId == post.id).length;
        return post.toEntity(count);
      }).toList();
    } catch (_) {
      final cachedPosts = await local.getCachedPosts();
      if (cachedPosts == null) rethrow;

      return cachedPosts.map((p) => p.toEntity(0)).toList();
    }
  }

  @override
  Future<bool> addPost(Post post) async {
    final postModel = PostModel(title: post.title);
    return await remote.addPost(postModel);
  }

  @override
  Future<bool> deletePost(int postId) async {
    return await remote.deletePost(postId);
  }
}
