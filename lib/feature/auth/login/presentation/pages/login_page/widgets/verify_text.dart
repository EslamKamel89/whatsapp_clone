import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';

class VerifyText extends StatelessWidget {
  const VerifyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'WhatsApp will need to verify your phone number',
          style: TextStyle(
            color: !isDark ? Coloors.greyLight : Coloors.greyDark,
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: " What's my number",
              style: TextStyle(
                color: !isDark ? Coloors.blueLight : Coloors.blueDark,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
