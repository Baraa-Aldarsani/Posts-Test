import 'package:flutter/material.dart';
import 'package:posts_ebtech/domain/usecases/add_post_usecase.dart';
import 'package:posts_ebtech/domain/usecases/delete_post_usecase.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts_usecase.dart';

class PostsProvider extends ChangeNotifier {
  final GetPostsUseCase getPosts;
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  PostsProvider(this.getPosts, this.addPostUseCase, this.deletePostUseCase);

  bool isLoading = false;
  List<Post> posts = [];

  Future<void> loadPosts() async {
    isLoading = true;
    notifyListeners();

    posts = await getPosts();

    isLoading = false;
    notifyListeners();
  }

  Future<String> addPost(Post post) async {
    isLoading = true;
    notifyListeners();
    final newPosts = Post(title: post.title);
    bool success = await addPostUseCase(post);
    if (success) {
      posts.insert(0, newPosts);
    }
    isLoading = false;
    notifyListeners();

    return success ? "Post added successfully" : "Failed to add post";
  }

  Future<String> removePost(int postId) async {
    isLoading = true;
    notifyListeners();

    bool success = await deletePostUseCase(postId);

    if (success) {
      posts.removeWhere((p) => p.id == postId);
    }

    isLoading = false;
    notifyListeners();

    return success ? "Post deleted successfully" : "Failed to delete post";
  }
}
