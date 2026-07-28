import 'package:prod_pin/src/core/index.dart' show ResultFuture, ResultVoid;
import 'package:prod_pin/src/features/category/index.dart'
    show CategoryDataSource, CategoryRepository, Category;

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required CategoryDataSource dataSource})
      : _dataSource = dataSource;

  final CategoryDataSource _dataSource;

  @override
  ResultFuture<List<Category>> getCategories() => _dataSource.getCategories();

  @override
  ResultFuture<Category> createCategory({
    required String name,
    String? coverImage,
    int? maxPins,
  }) =>
      _dataSource.createCategory(
        name: name,
        coverImage: coverImage,
        maxPins: maxPins,
      );

  @override
  ResultVoid deleteCategory(String id) => _dataSource.deleteCategory(id);

  @override
  ResultFuture<Category> updateCategory({
    required String id,
    String? name,
    String? coverImage,
    int? maxPins,
  }) =>
      _dataSource.updateCategory(
        id: id,
        name: name,
        coverImage: coverImage,
        maxPins: maxPins,
      );
}
