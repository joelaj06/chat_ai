import 'package:chat_ai/core/presentation/theme/primary_color.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData get lightTheme => ThemeData(
    primarySwatch: PrimaryColor.color,
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
  );
}