import 'package:chat_ai/core/presentation/theme/primary_color.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData get lightTheme => ThemeData(
    primaryColor: PrimaryColor.color.shade500,
    primaryTextTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
      ) ,
        bodyText2: TextStyle(
        color: Colors.black,
      )
    ),
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: PrimaryColor.color.shade400,
    primaryTextTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ) ,
        bodyText2: TextStyle(
          color: Colors.white,
        )
    ),
  );
}