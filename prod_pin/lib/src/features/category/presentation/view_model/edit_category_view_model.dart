import 'package:prod_pin/src/core/index.dart'
    show ViewStateProvider, Failure, ViewState, APIFailure;
import 'package:prod_pin/src/features/category/index.dart'
    show CategoryRepository;

class EditCategoryViewModel extends ViewStateProvider {
  EditCategoryViewModel({required CategoryRepository repository})
      : _categoryRepository = repository;

  final CategoryRepository _categoryRepository;

  Future<Failure?> update({
    required String id,
    String? name,
    String? coverImage,
    int? maxPins,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _categoryRepository.updateCategory(
      id: id,
      name: name,
      coverImage: coverImage,
      maxPins: maxPins,
    );

    result.fold((e) {
      failure = APIFailure.fromException(exception: e);
    }, (r) {});

    setViewState(ViewState.complete);

    return failure;
  }
}
