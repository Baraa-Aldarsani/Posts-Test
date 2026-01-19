import 'package:flutter/material.dart';
import 'package:posts_ebtech/data/datasources/local/posts_local_datasource.dart';
import 'package:posts_ebtech/data/datasources/remote/comments_remote_datasource.dart';
import 'package:posts_ebtech/data/datasources/remote/posts_remote_datasource.dart';
import 'package:posts_ebtech/data/repositories/comments_repository_impl.dart';
import 'package:posts_ebtech/data/repositories/posts_repository_impl.dart';
import 'package:posts_ebtech/domain/usecases/add_comment_usecase.dart';
import 'package:posts_ebtech/domain/usecases/add_post_usecase.dart';
import 'package:posts_ebtech/domain/usecases/delete_post_usecase.dart';
import 'package:posts_ebtech/domain/usecases/get_comments_by_post_usecase.dart';
import 'package:posts_ebtech/domain/usecases/get_posts_usecase.dart';
import 'package:posts_ebtech/presentation/providers/comments_provider.dart';
import 'package:posts_ebtech/presentation/providers/posts_provider.dart';
import 'package:posts_ebtech/presentation/screens/posts_screen.dart';
import 'package:provider/provider.dart';

void main() {
  final repository = PostsRepositoryImpl(
    PostsRemoteDataSource(),
    PostsLocalDataSource(),
  );
  final commentsRepository = CommentsRepositoryImpl(CommentsRemoteDataSource());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => PostsProvider(
                GetPostsUseCase(repository),
                AddPostUseCase(repository),
                DeletePostUseCase(repository),
              )..loadPosts(),
        ),
        ChangeNotifierProvider(
          create:
              (_) => CommentsProvider(
                GetCommentsByPostUseCase(commentsRepository),
                AddCommentUseCase(commentsRepository),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts EBTech',
      home: const PostsScreen(),
    );
  }
}
