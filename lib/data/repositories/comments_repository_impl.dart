import 'package:posts_ebtech/data/datasources/remote/comments_remote_datasource.dart';
import 'package:posts_ebtech/data/models/comment_model.dart';
import 'package:posts_ebtech/domain/repositories/comments_repository.dart';

import '../../domain/entities/comment.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource remote;

  CommentsRepositoryImpl(this.remote);

  @override
  Future<List<Comment>> getCommentsByPostId(int postId) async {
    final models = await remote.fetchComments();

    return models
        .where((c) => c.postId == postId)
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<bool> addComment(Comment comment) async {
     final model = CommentModel(
      id: 0,
      postId: comment.postId,
      body: comment.body,
    );
    return await remote.addComment(model);
  }
}
