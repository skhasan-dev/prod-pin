import 'package:flutter/material.dart' show BuildContext;
import 'package:prod_pin/src/core/index.dart' show Failure, Toasts;

extension FailureExt on Failure {
  bool get isExists => message != null && statusCode != null;

  void showError(BuildContext context) {
    if (statusCode != 500) {
      // Toasts.showErrorToast(
      //   context,
      //   message: message ?? 'Something Went Wrong',
      // );
    } else {
      print('Issue found: $message with $statusCode');
    }
  }
}
