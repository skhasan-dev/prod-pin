import 'package:flutter/material.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:prod_pin/src/config/index.dart' show AppConstants;
import 'package:prod_pin/src/core/index.dart' show appRouter, getIt;
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  ThemeData _buildMaterialTheme(AppColorsData colors, Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colors.accent,
        onPrimary: Colors.white,
        secondary: colors.accent,
        onSecondary: Colors.white,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        error: colors.error,
        onError: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      dividerColor: colors.divider,
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => getIt<ThemeProvider>(),
      child: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) {
          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            themeMode: themeProvider.themeMode,
            theme: _buildMaterialTheme(AppColors.light, Brightness.light),
            darkTheme: _buildMaterialTheme(AppColors.dark, Brightness.dark),
            builder: (context, child) {
              final isDark =
                  Theme.of(context).brightness == Brightness.dark;
              final colors = isDark ? AppColors.dark : AppColors.light;
              return AppTheme(
                data: AppThemeData(
                  colors: colors,
                  textStyles: AppTextStylesData(colors),
                  themeMode: themeProvider.themeMode,
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
