import 'package:flutter/material.dart';

class PrimaryColor{
  ///Colors Generated from http://mcg.mbitson.com/
  static const MaterialColor color = MaterialColor(_chataiPrimaryValue, <int, Color>{
    50: Color(0xFFE2E4E7),
    100: Color(0xFFB6BAC2),
    200: Color(0xFF858D9A),
    300: Color(0xFF545F72),
    400: Color(0xFF2F3C53),
    500: Color(_chataiPrimaryValue),
    600: Color(0xFF091730),
    700: Color(0xFF071328),
    800: Color(0xFF050F22),
    900: Color(0xFF030816),
  });
  static const int _chataiPrimaryValue = 0xFF0A1A35;

  static const MaterialColor chataiAccent = MaterialColor(_chataiAccentValue, <int, Color>{
    100: Color(0xFF5675FF),
    200: Color(_chataiAccentValue),
    400: Color(0xFF002BEF),
    700: Color(0xFF0027D5),
  });
  static const int _chataiAccentValue = 0xFF234BFF;
}