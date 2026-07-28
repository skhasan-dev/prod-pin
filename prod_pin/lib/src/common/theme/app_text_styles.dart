import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStylesData {
  AppTextStylesData(AppColorsData colors)
      : displayLarge = TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
        ),
        headlineMedium = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
        titleMedium = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
        bodyMedium = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colors.textSecondary,
        ),
        bodySmall = TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colors.textMuted,
        ),
        labelMedium = TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colors.textPrimary,
        );

  final TextStyle displayLarge;
  final TextStyle headlineMedium;
  final TextStyle titleMedium;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelMedium;
}
