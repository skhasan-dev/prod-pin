import 'package:prod_pin/src/core/index.dart' show ResultFuture, ResultVoid;
import 'package:prod_pin/src/features/category/index.dart' show Category;

abstract class CategoryDataSource {
  ResultFuture<List<Category>> getCategories();

  ResultFuture<Category> createCategory({
    required String name,
    String? coverImage,
    int? maxPins,
  });

  ResultFuture<Category> updateCategory({
    required String id,
    String? name,
    String? coverImage,
    int? maxPins,
  });

  ResultVoid deleteCategory(String id);
}
