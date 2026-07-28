import 'package:prod_pin/src/core/index.dart'
    show ViewStateProvider, Failure, ViewState, APIFailure;
import 'package:prod_pin/src/features/pin/index.dart' show PinRepository, Post;

class AddPinViewModel extends ViewStateProvider {
  AddPinViewModel({required PinRepository repository})
      : _pinRepository = repository;

  final PinRepository _pinRepository;

  Post? _post;
  Post? get post => _post;

  Future<Failure?> createPost(Map<String, dynamic> body) async {
    Failure? failure;
    setViewState(ViewState.busy);
    final result = await _pinRepository.createPost(body);
    result.fold(
      (e) => failure = APIFailure.fromException(exception: e),
      (r) => _post = r,
    );
    setViewState(ViewState.complete);
    return failure;
  }
}
