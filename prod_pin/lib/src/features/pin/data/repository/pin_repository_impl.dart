import 'package:prod_pin/src/core/index.dart' show ResultFuture, ResultVoid;

import '../data_source/pin_data_source.dart';
import '../entities/post.dart';
import 'pin_repository.dart';

class PinRepositoryImpl implements PinRepository {
  PinRepositoryImpl({required PinDataSource dataSource})
      : _dataSource = dataSource;

  final PinDataSource _dataSource;

  @override
  ResultFuture<List<Post>> getPosts({
    List<String>? status,
    List<String>? category,
    List<String>? imageGenerated,
    DateTime? dateFrom,
    DateTime? dateTo,
    int page = 1,
    int limit = 20,
  }) =>
      _dataSource.getPosts(
        status: status,
        category: category,
        imageGenerated: imageGenerated,
        dateFrom: dateFrom,
        dateTo: dateTo,
        page: page,
        limit: limit,
      );

  @override
  ResultFuture<Post> getPost(String id) => _dataSource.getPost(id);

  @override
  ResultFuture<Post> createPost(Map<String, dynamic> body) =>
      _dataSource.createPost(body);

  @override
  ResultFuture<Post> updatePost(String id, Map<String, dynamic> body) =>
      _dataSource.updatePost(id, body);

  @override
  ResultVoid deletePost(String id) => _dataSource.deletePost(id);

  @override
  ResultVoid deleteManyPosts(List<String> ids) =>
      _dataSource.deleteManyPosts(ids);
}
