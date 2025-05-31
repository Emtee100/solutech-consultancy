import 'package:flutter/material.dart';

class AppTheme {
  final double _pagePadding = 20.0;
  double get pagePadding => _pagePadding;
  final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 20),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 14),
    ),
    
  );

  final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 20),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 14),
    ),
  );

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;
}
