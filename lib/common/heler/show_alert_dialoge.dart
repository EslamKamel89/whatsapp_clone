import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';

showCustomAlertDialoge({
  required BuildContext context,
  required String message,
  String? btnTxt,
}) {
  bool isDark = isDarkMode(context);
  Color grey = isDark ? Coloors.greyDark : Coloors.greyLight;
  Color green = isDark ? Coloors.greenDark : Coloors.greenLight;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          message,
          style: TextStyle(
            color: grey,
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              btnTxt ?? 'Ok',
              style: TextStyle(color: green),
            ),
          ),
        ],
      );
    },
  );
}
