import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';

class ResendSms extends StatelessWidget {
  const ResendSms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    Color grey = isDark ? Coloors.greyDark : Coloors.greyLight;
    return Row(
      children: [
        Icon(Icons.message, color: grey),
        const SizedBox(width: 10),
        Text(
          'Resend SMS',
          style: TextStyle(color: grey),
        ),
      ],
    );
  }
}
