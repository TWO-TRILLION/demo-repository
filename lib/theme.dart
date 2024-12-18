import 'package:flutter/material.dart';
import 'package:flutter_sprinchat_app/constant/colors.dart';

final theme = ThemeData(
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      color: Colors.transparent,
    ),
    fontFamily: 'Pretendard',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueAccent),
    highlightColor: AppColors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    // ElevatedButton
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
        backgroundColor: WidgetStatePropertyAll(AppColors.blueAccent),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
    // TextField InputDecoration
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
