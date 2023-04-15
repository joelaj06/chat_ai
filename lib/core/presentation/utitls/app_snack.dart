import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppSnack{
  static const int seconds = 2000;
  void showSuccess(String title, String message,  {Duration? duration}){
    Get.snackbar(title, message,
      backgroundColor: Colors.green,
      /*barBlur: 20,
      boxShadows: <BoxShadow>[
        const BoxShadow(blurRadius: 20,
            color: Colors.green),
      ],*/
      duration: duration ??  const Duration(milliseconds: seconds),
      colorText: Colors.white,);
  }
  void showError(String title, String message,  {Duration? duration}){
    Get.snackbar(title, message,
      duration: duration??   Duration(milliseconds: seconds),
      backgroundColor: Colors.red,
      /* barBlur: 50,
      boxShadows: <BoxShadow>[
        const BoxShadow(blurRadius: 20,
        color: Colors.red),
      ],*/
      colorText: Colors.white,
    );
  }
  void showInfo(String title, String message, {Duration? duration}){
    Get.snackbar(title, message,
      backgroundColor: Colors.blue,
      /* barBlur: 50,
      boxShadows: <BoxShadow>[
        const BoxShadow(blurRadius: 20,
            color: Colors.blue,),
      ],*/
      duration: duration ??   Duration(milliseconds: seconds),
      colorText: Colors.white,);
  }

}