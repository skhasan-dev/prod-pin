import 'package:flutter/material.dart';

class AppColorsData {
  const AppColorsData({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.accent,
    required this.accentMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.draft,
    required this.ready,
    required this.published,
    required this.yetToGenerate,
    required this.partiallyGenerated,
    required this.generated,
    required this.divider,
    required this.error,
  });

  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color accent;
  final Color accentMuted;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color draft;
  final Color ready;
  final Color published;
  final Color yetToGenerate;
  final Color partiallyGenerated;
  final Color generated;
  final Color divider;
  final Color error;
}

class AppColors {
  AppColors._();

  static const dark = AppColorsData(
    background: Color(0xFF0F0F0F),
    surface: Color(0xFF1A1A1A),
    surfaceElevated: Color(0xFF242424),
    accent: Color(0xFFE60023),
    accentMuted: Color(0xFF8B0000),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF9E9E9E),
    textMuted: Color(0xFF5E5E5E),
    draft: Color(0xFF9E9E9E),
    ready: Color(0xFF2196F3),
    published: Color(0xFF4CAF50),
    yetToGenerate: Color(0xFFFF9800),
    partiallyGenerated: Color(0xFF03A9F4),
    generated: Color(0xFF4CAF50),
    divider: Color(0xFF2A2A2A),
    error: Color(0xFFCF6679),
  );

  static const light = AppColorsData(
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF5F5F5),
    surfaceElevated: Color(0xFFEEEEEE),
    accent: Color(0xFFE60023),
    accentMuted: Color(0xFFFF4D6D),
    textPrimary: Color(0xFF0F0F0F),
    textSecondary: Color(0xFF5E5E5E),
    textMuted: Color(0xFF9E9E9E),
    draft: Color(0xFF757575),
    ready: Color(0xFF1976D2),
    published: Color(0xFF388E3C),
    yetToGenerate: Color(0xFFF57C00),
    partiallyGenerated: Color(0xFF0288D1),
    generated: Color(0xFF388E3C),
    divider: Color(0xFFE0E0E0),
    error: Color(0xFFB00020),
  );
}
