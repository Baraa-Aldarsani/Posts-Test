import '../../domain/entities/comment.dart';

class CommentModel {
  final int id;
  final int postId;
  final String body;

  CommentModel({
    required this.id,
    required this.postId,
    required this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['postId'],
      body: json['body'],
    );
  }

  Comment toEntity() {
    return Comment(
      id: id,
      postId: postId,
      body: body,
    );
  }
}
