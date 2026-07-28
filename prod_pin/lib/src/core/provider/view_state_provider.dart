import 'package:flutter/material.dart';

enum ViewState { idle, busy, complete }

class ViewStateProvider extends ChangeNotifier {
  ViewState _viewState = ViewState.complete;
  ViewState get viewState => _viewState;

  bool get isLoading => _viewState == ViewState.busy;
  void setViewState(ViewState state, {bool notify = true}) {
    _viewState = state;

    if (notify) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
