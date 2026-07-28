import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:prod_pin/src/core/index.dart'
    show
        APIException,
        Endpoints,
        NetworkService,
        Request,
        RequestMethod,
        ResultFuture,
        ResultVoid;

import '../entities/post.dart';
import 'pin_data_source.dart';

class PinDataSourceImpl implements PinDataSource {
  PinDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  final NetworkService _networkService;

  @override
  ResultFuture<List<Post>> getPosts({
    List<String>? status,
    List<String>? category,
    List<String>? imageGenerated,
    DateTime? dateFrom,
    DateTime? dateTo,
    int page = 1,
    int limit = 20,
  }) async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: Endpoints.posts,
      queryParams: {
        if (status != null && status.isNotEmpty) 'status': status.join(','),
        if (category != null && category.isNotEmpty)
          'category': category.join(','),
        if (imageGenerated != null && imageGenerated.isNotEmpty)
          'image_generated': imageGenerated.join(','),
        if (dateFrom != null) 'date_from': dateFrom.toIso8601String(),
        if (dateTo != null) 'date_to': dateTo.toIso8601String(),
        'page': page,
        'limit': limit,
      },
    );
    try {
      final response = await _networkService.request(request);
      final data = response.data['data'] as List<dynamic>;
      log(data.toString(), name: 'Data');
      final posts =
          data.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
      log(posts.toString(), name: 'Posts');
      return Right(posts);
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }

  @override
  ResultFuture<Post> getPost(String id) async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: Endpoints.postById(id),
    );
    try {
      final response = await _networkService.request(request);
      return Right(
          Post.fromJson(response.data['data'] as Map<String, dynamic>));
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }

  @override
  ResultFuture<Post> createPost(Map<String, dynamic> body) async {
    final request = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.posts,
      body: body,
    );
    try {
      final response = await _networkService.request(request);
      return Right(
          Post.fromJson(response.data['data'] as Map<String, dynamic>));
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }

  @override
  ResultFuture<Post> updatePost(String id, Map<String, dynamic> body) async {
    final request = Request(
      method: RequestMethod.put,
      endpoint: Endpoints.postById(id),
      body: body,
    );
    try {
      final response = await _networkService.request(request);
      return Right(
          Post.fromJson(response.data['data'] as Map<String, dynamic>));
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }

  @override
  ResultVoid deletePost(String id) async {
    final request = Request(
      method: RequestMethod.delete,
      endpoint: Endpoints.postById(id),
    );
    try {
      await _networkService.request(request);
      return const Right(null);
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }

  @override
  ResultVoid deleteManyPosts(List<String> ids) async {
    final request = Request(
      method: RequestMethod.delete,
      endpoint: Endpoints.postsBulkDelete,
      body: {'ids': ids},
    );
    try {
      await _networkService.request(request);
      return const Right(null);
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }
}
