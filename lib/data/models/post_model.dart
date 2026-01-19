import '../../domain/entities/post.dart';

class PostModel {
  int? id;
  final String title;

  PostModel({this.id, required this.title});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {"title": title};
  }

  Post toEntity(int commentsCount) {
    return Post(id: id, title: title, commentsCount: commentsCount);
  }
}
