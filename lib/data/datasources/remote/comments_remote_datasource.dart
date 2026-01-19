import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/comment_model.dart';

class CommentsRemoteDataSource {
  static const _baseUrl = 'https://my-json-server.typicode.com/typicode/demo';

  Future<List<CommentModel>> fetchComments() async {
    final response = await http.get(Uri.parse('$_baseUrl/comments'));

    final List data = jsonDecode(response.body);
    return data.map((e) => CommentModel.fromJson(e)).toList();
  }

  Future<bool> addComment(CommentModel comment) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/comments'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"postId": comment.postId, "body": comment.body}),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Remote Add Comment Error: $e');
      return false;
    }
  }
}
