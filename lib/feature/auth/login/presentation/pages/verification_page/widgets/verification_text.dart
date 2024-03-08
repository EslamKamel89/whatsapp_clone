import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';

class VerificationText extends StatelessWidget {
  const VerificationText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    Color blue = isDark ? Coloors.blueDark : Coloors.blueLight;
    Color grey = isDark ? Coloors.greyDark : Coloors.greyLight;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "You've tried to register +0201024510803 before requesting an SMS or call with your code, ",
        style: TextStyle(color: grey),
        children: [
          TextSpan(
            text: '\nWrong Number?',
            style: TextStyle(color: blue),
          )
        ],
      ),
    );
  }
}
