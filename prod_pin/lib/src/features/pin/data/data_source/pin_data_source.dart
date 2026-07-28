import 'package:prod_pin/src/core/index.dart' show ResultFuture, ResultVoid;

import '../entities/post.dart';

abstract class PinDataSource {
  ResultFuture<List<Post>> getPosts({
    List<String>? status,
    List<String>? category,
    List<String>? imageGenerated,
    DateTime? dateFrom,
    DateTime? dateTo,
    int page = 1,
    int limit = 20,
  });

  ResultFuture<Post> getPost(String id);

  ResultFuture<Post> createPost(Map<String, dynamic> body);

  ResultFuture<Post> updatePost(String id, Map<String, dynamic> body);

  ResultVoid deletePost(String id);

  ResultVoid deleteManyPosts(List<String> ids);
}
