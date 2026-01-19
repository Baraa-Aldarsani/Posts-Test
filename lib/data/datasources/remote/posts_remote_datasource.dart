import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:posts_ebtech/data/models/comment_model.dart';
import 'package:posts_ebtech/data/models/post_model.dart';

class PostsRemoteDataSource {
  static const baseUrl = 'https://my-json-server.typicode.com/typicode/demo';

  Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    final data = jsonDecode(response.body) as List;
    return data.map((e) => PostModel.fromJson(e)).toList();
  }

  Future<List<CommentModel>> fetchComments() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'));

    final List data = jsonDecode(response.body);
    return data.map((e) => CommentModel.fromJson(e)).toList();
  }

  Future<bool> addPost(PostModel post) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(post.toJson()),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Remote POST Error: $e');
      return false;
    }
  }

  Future<bool> deletePost(int postId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/posts/$postId'));
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print('Delete Post Error: $e');
      return false;
    }
  }
}
