import 'package:flutter/material.dart';

final theme = ThemeData(
    fontFamily: 'Pretendard',
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
    highlightColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size.fromHeight(50)),
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
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: MaterialStateOutlineInputBorder.resolveWith(
          (states) {
            if (states.contains(WidgetState.focused)) {
              return OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 2));
            } else if (states.contains(WidgetState.error)) {
              return OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red[100]!, width: 2));
            }
            return OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1));
          },
        )));
