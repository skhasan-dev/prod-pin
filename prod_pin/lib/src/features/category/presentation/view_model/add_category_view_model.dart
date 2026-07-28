import 'package:prod_pin/src/core/index.dart'
    show ViewStateProvider, Failure, ViewState, APIFailure;
import 'package:prod_pin/src/features/category/index.dart'
    show CategoryRepository;

class AddCategoryViewModel extends ViewStateProvider {
  AddCategoryViewModel({required CategoryRepository repository})
      : _categoryRepository = repository;

  final CategoryRepository _categoryRepository;

  Future<Failure?> create({
    required String name,
    String? coverImage,
    int? maxPins,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _categoryRepository.createCategory(
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
