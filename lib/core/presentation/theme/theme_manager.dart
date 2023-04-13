import 'package:chat_ai/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeManagerController extends GetxController{

  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  Rx<ThemeMode> get themeMode => _themeMode;

  void toggleTheme(bool isDark){
     _themeMode(isDark ? ThemeMode.dark : ThemeMode.light);
     Get.changeTheme(isDark ? AppTheme.darkTheme : AppTheme.lightTheme);
  }
}