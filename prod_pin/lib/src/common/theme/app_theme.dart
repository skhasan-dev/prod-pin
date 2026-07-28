import 'package:flutter/widgets.dart';

import 'app_theme_data.dart';

class AppTheme extends InheritedWidget {
  const AppTheme({super.key, required this.data, required super.child});

  final AppThemeData data;

  static AppThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!.data;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) =>
      !identical(data.colors, oldWidget.data.colors);
}
