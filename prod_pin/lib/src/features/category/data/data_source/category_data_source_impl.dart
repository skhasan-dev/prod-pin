import 'package:dartz/dartz.dart';
import 'package:prod_pin/src/core/index.dart'
    show
        ResultFuture,
        ResultVoid,
        NetworkService,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:prod_pin/src/features/category/index.dart'
    show CategoryDataSource, Category;

class CategoryDataSourceImpl implements CategoryDataSource {
  CategoryDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  final NetworkService _networkService;

  @override
  ResultFuture<List<Category>> getCategories() async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: Endpoints.categories,
    );

    try {
      final response = await _networkService.request(request);
      final data = response.data['data'] as List;

      final list = data
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(list);
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }

  @override
  ResultFuture<Category> createCategory({
    required String name,
    String? coverImage,
    int? maxPins,
  }) async {
    final request = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.categories,
      body: {
        'name': name,
        if (coverImage != null) 'coverImage': coverImage,
        if (maxPins != null) 'maxPins': maxPins,
      },
    );
    try {
      final response = await _networkService.request(request);

      final list =
          Category.fromJson(response.data['data'] as Map<String, dynamic>);

      return Right(list);
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }

  @override
  ResultVoid deleteCategory(String id) async {
    final request = Request(
      method: RequestMethod.delete,
      endpoint: Endpoints.categoryById(id),
    );
    try {
      await _networkService.request(request);

      return Right(null);
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }

  @override
  ResultFuture<Category> updateCategory({
    required String id,
    String? name,
    String? coverImage,
    int? maxPins,
  }) async {
    final request = Request(
      method: RequestMethod.put,
      endpoint: Endpoints.categoryById(id),
      body: {
        if (name != null) 'name': name,
        if (coverImage != null) 'coverImage': coverImage,
        if (maxPins != null) 'maxPins': maxPins,
      },
    );
    try {
      final response = await _networkService.request(request);

      final list =
          Category.fromJson(response.data['data'] as Map<String, dynamic>);

      return Right(list);
    } catch (e, s) {
      return Left(APIException.from(e, s));
    }
  }
}
