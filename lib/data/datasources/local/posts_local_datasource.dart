import 'dart:convert';
import 'package:posts_ebtech/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsLocalDataSource {
  static const _cacheKey = 'CACHED_POSTS';

  Future<void> cachePosts(List<PostModel> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        posts.map((p) => {'id': p.id, 'title': p.title}).toList();
    prefs.setString(_cacheKey, jsonEncode(jsonList));
  }

  Future<List<PostModel>?> getCachedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cacheKey);
    if (jsonString == null) return null;

    final List data = jsonDecode(jsonString);
    return data.map((e) => PostModel.fromJson(e)).toList();
  }
}
