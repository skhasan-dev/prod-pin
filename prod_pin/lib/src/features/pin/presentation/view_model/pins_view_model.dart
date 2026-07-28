import 'package:prod_pin/src/core/index.dart'
    show ViewStateProvider, Failure, ViewState, APIFailure;
import 'package:prod_pin/src/features/pin/index.dart' show PinRepository, Post;

class PinsViewModel extends ViewStateProvider {
  PinsViewModel({required PinRepository repository})
      : _pinRepository = repository;

  final PinRepository _pinRepository;

  List<Post> _posts = [];
  List<Post> get posts => _posts;
  set posts(List<Post> posts) {
    if (_posts.isEmpty) {
      _posts = posts;
    } else {
      _posts = [..._posts, ...posts];
    }
    notifyListeners();
  }

  List<String> _statusFilter = [];
  List<String> _imageGeneratedFilter = [];
  DateTime? _dateFrom;
  DateTime? _dateTo;

  List<String> get statusFilter => _statusFilter;
  List<String> get imageGeneratedFilter => _imageGeneratedFilter;
  DateTime? get dateFrom => _dateFrom;
  DateTime? get dateTo => _dateTo;
  bool get hasActiveFilters =>
      _statusFilter.isNotEmpty ||
      _imageGeneratedFilter.isNotEmpty ||
      _dateFrom != null ||
      _dateTo != null;

  Future<Failure?> getPosts({required String categoryId}) async {
    Failure? failure;
    setViewState(ViewState.busy);
    final result = await _pinRepository.getPosts(
      category: [categoryId],
      status: _statusFilter.isEmpty ? null : _statusFilter,
      imageGenerated:
          _imageGeneratedFilter.isEmpty ? null : _imageGeneratedFilter,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
    );
    result.fold(
      (e) => failure = APIFailure.fromException(exception: e),
      (r) => posts = r,
    );
    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> deletePost(String id) async {
    Failure? failure;
    setViewState(ViewState.busy);
    final result = await _pinRepository.deletePost(id);
    result.fold(
      (e) => failure = APIFailure.fromException(exception: e),
      (_) => _posts = _posts.where((p) => p.id != id).toList(),
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
      (updated) =>
          _posts = _posts.map((p) => p.id == id ? updated : p).toList(),
    );
    setViewState(ViewState.complete);
    return failure;
  }

  void updateFilters({
    List<String>? status,
    List<String>? imageGenerated,
    DateTime? from,
    DateTime? to,
    bool clearFrom = false,
    bool clearTo = false,
  }) {
    if (status != null) _statusFilter = status;
    if (imageGenerated != null) _imageGeneratedFilter = imageGenerated;
    if (clearFrom) {
      _dateFrom = null;
    } else if (from != null) {
      _dateFrom = from;
    }
    if (clearTo) {
      _dateTo = null;
    } else if (to != null) {
      _dateTo = to;
    }
    notifyListeners();
  }

  void clearFilters() {
    _statusFilter = [];
    _imageGeneratedFilter = [];
    _dateFrom = null;
    _dateTo = null;
    notifyListeners();
  }
}
