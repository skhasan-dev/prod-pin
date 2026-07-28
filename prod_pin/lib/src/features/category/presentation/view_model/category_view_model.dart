import 'package:prod_pin/src/core/index.dart'
    show ViewStateProvider, Failure, ViewState, APIFailure;
import 'package:prod_pin/src/features/category/index.dart'
    show CategoryRepository, Category;

class CategoryViewModel extends ViewStateProvider {
  CategoryViewModel({required CategoryRepository repository})
      : _categoryRepository = repository;

  final CategoryRepository _categoryRepository;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  bool isCategoryFull(Category category) {
    if (category.maxPins == null || category.totalPins == null) return false;
    return category.totalPins! >= category.maxPins!;
  }

  Category? getById(String id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<Failure?> getCategories() async {
    Failure? failure;
    setViewState(ViewState.busy);
    final result = await _categoryRepository.getCategories();
    result.fold(
      (e) => failure = APIFailure.fromException(exception: e),
      (r) => _categories = r,
    );
    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> deleteCategory(String id) async {
    Failure? failure;
    setViewState(ViewState.busy);
    final result = await _categoryRepository.deleteCategory(id);
    result.fold(
      (e) => failure = APIFailure.fromException(exception: e),
      (_) => _categories = _categories.where((c) => c.id != id).toList(),
    );
    setViewState(ViewState.complete);
    return failure;
  }
}
