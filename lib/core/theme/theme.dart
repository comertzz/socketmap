import 'package:flutter/material.dart';
import 'package:socket_map/core/flavor/flavor_config.dart';

class AppTheme {
  static const Color _backgroundColor = Color(0xFFF5F7FA);
  static const Color _cardColor = Colors.white;

static ThemeData buildTheme(FlavorConfig flavor) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: flavor.primaryColor,
        primary: flavor.primaryColor,
        secondary: flavor.secondaryColor,
        surface: _backgroundColor,
        error: Colors.redAccent,
      ),
      scaffoldBackgroundColor: _backgroundColor,
      cardColor: _cardColor,
      appBarTheme: AppBarTheme(
        backgroundColor: flavor.primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: flavor.secondaryColor,
        foregroundColor: Colors.white,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: flavor.secondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          color: flavor.secondaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        bodyLarge: const TextStyle(color: Colors.black87, fontSize: 16),
        bodySmall:
            TextStyle(color: flavor.secondaryColor.withValues(alpha: 0.7), fontSize: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: flavor.primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: flavor.primaryColor,
      ),
      dividerTheme: DividerThemeData(
        color: flavor.accentColor.withValues(alpha: 0.35),
      ),
     );
     
  }

  static ThemeData buildLightTheme(FlavorConfig flavor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: flavor.primaryColor,
      primary: flavor.primaryColor,
      secondary: flavor.secondaryColor,
      surface: _backgroundColor,
      error: Colors.redAccent,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _backgroundColor,
      cardColor: _cardColor,
      appBarTheme: AppBarTheme(
        backgroundColor: flavor.primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: flavor.secondaryColor,
        foregroundColor: Colors.white,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: flavor.secondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          color: flavor.secondaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        bodyLarge: const TextStyle(color: Colors.black87, fontSize: 16),
        bodySmall: TextStyle(color: flavor.secondaryColor, fontSize: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: flavor.primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: flavor.primaryColor,
      ),
      dividerTheme: DividerThemeData(
        color: flavor.accentColor.withValues(alpha: 0.35),
      ),
    );
  }

  static ThemeData buildDarkTheme(FlavorConfig flavor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: flavor.primaryColor,
      primary: flavor.primaryColor,
      secondary: flavor.secondaryColor,
      surface: const Color(0xFF121212),
      error: Colors.redAccent,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      appBarTheme: AppBarTheme(
        backgroundColor: flavor.primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: flavor.secondaryColor,
        foregroundColor: Colors.white,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: flavor.secondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          color: flavor.secondaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        bodyLarge: const TextStyle(color: Colors.white70, fontSize: 16),
        bodySmall:
            TextStyle(color: flavor.secondaryColor.withValues(alpha: 0.7), fontSize: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: flavor.primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: flavor.primaryColor,
      ),
      dividerTheme: DividerThemeData(
        color: flavor.accentColor.withValues(alpha: 0.35),
      ),
    );
  }
}
