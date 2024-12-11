import 'package:flutter/material.dart';

final theme = ThemeData(
  fontFamily: 'Pretendard',
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),
);
