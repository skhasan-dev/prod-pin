import 'package:prod_pin/src/core/index.dart'
    show ViewStateProvider, Failure, ViewState, APIFailure;
import 'package:prod_pin/src/features/pin/index.dart' show PinRepository, Post;

class EditPinViewModel extends ViewStateProvider {
  EditPinViewModel({required PinRepository repository})
      : _pinRepository = repository;

  final PinRepository _pinRepository;

  Post? _post;
  Post? get post => _post;

  Future<Failure?> getPost(String id) async {
    Failure? failure;
    setViewState(ViewState.busy);
    final result = await _pinRepository.getPost(id);
    result.fold(
      (e) => failure = APIFailure.fromException(exception: e),
      (r) => _post = r,
    );
    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> updatePost(String id, Map<String, dynamic> body) async {
    Failure? failure;
    setViewState(ViewState.busy);
    final result = await _pinRepository.updatePost(id, body);
    result.fold(
      (e) => failure = APIFailure.fromException(exception: e),
      (updated) => _post = updated,
    );
    setViewState(ViewState.complete);
    return failure;
  }
}
