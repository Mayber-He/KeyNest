import 'package:flutter/material.dart';

abstract final class KeyNestTheme {
  static const ink = Color(0xFF172033);
  static const mutedInk = Color(0xFF667085);
  static const surface = Color(0xFFF8FAFC);
  static const border = Color(0xFFE4E7EC);
  static const radius = 16.0;

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF5B5BD6),
      brightness: Brightness.light,
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: surface,
      useMaterial3: true,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: ink),
        bodySmall: TextStyle(color: mutedInk),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: border),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );
  }
}
