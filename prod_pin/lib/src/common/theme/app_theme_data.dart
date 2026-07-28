import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemeData {
  const AppThemeData({
    required this.colors,
    required this.textStyles,
    required this.themeMode,
  });

  final AppColorsData colors;
  final AppTextStylesData textStyles;
  final ThemeMode themeMode;
}
