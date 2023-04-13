import 'package:chat_ai/core/presentation/theme/primary_color.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppAlerts {

  final AlertStyle _alertStyle = const AlertStyle(
    animationType: AnimationType.fromTop,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(
      fontSize: 18,
      color: PrimaryColor.color,
      fontWeight: FontWeight.w300,
    ) ,
    animationDuration: Duration(milliseconds: 300),
  );

  Future<bool?> alertWithButtons({required BuildContext context,
    required String title,
    required String desc,
    String leftButtonText = 'Cancel',
    String rightButtonText = 'Yes',
    required VoidCallback onLeftButtonPressed,
    required VoidCallback onRightButtonPressed,
    Color? leftButtonColor,
    Color? rightButtonColor,
    required AlertType alertType,

  }) {
    return
    Alert(

      context: context,
      type: alertType,
      title: title,
      desc: desc,
      style: _alertStyle,
      buttons: <DialogButton>[
        DialogButton(
          onPressed: onLeftButtonPressed,
          color: leftButtonColor ?? Colors.red,
          child: Text(
            leftButtonText,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        DialogButton(
          onPressed: onRightButtonPressed,
          color: rightButtonColor ?? Colors.green,
          child: Text(
            rightButtonText,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),

        )
      ],
    ).show();
  }

  void alertWithSingleButton({required BuildContext context,
    required String title,
    required String desc,
    required AlertType alertType }) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: desc,
      style: _alertStyle,

      buttons: <DialogButton>[
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ],
    ).show();
  }




}