import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[900],
  colorSchemeSeed: Colors.yellow,
  dividerColor: Colors.white24,
  appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900], elevation: 0),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: TextTheme(
      bodyMedium: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      labelSmall: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.w700,
          fontSize: 14
      )
  ),
  useMaterial3: true,
);