import 'package:flutter/material.dart';

import '../../common/theme/app_colors.dart';
import '../../common/theme/app_text_styles.dart';
import '../../common/theme/app_theme.dart';
import '../../common/theme/app_theme_data.dart';

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  bool get isMobile => screenSize.width < 600;
  bool get isTablet => screenSize.width >= 600 && screenSize.width < 1024;
  bool get isDesktop => screenSize.width >= 1024;

  int get categoryGridColumns {
    if (isDesktop) return 3;
    if (isTablet) return 2;
    return 1;
  }

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppThemeData get appTheme => AppTheme.of(this);
  AppColorsData get appColors => AppTheme.of(this).colors;
  AppTextStylesData get appTextStyles => AppTheme.of(this).textStyles;

  void showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? const Color(0xFFCF6679) : null,
      ),
    );
  }
}
