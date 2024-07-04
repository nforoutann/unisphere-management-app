import 'package:flutter/material.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:delightful_toast/delight_toast.dart';

class Messages {
  static void error(BuildContext context, Color color, String myText) {
    DelightToastBar(
      builder: (context) {
        return Align(
          alignment: Alignment.center,
          child: ToastCard(
            shadowColor: Colors.black45,
            leading: const Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
            color: color,
            title: Text(
              myText,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
    ).show(context);
  }
}
