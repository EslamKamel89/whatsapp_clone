import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';

class CallMe extends StatelessWidget {
  const CallMe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    Color grey = isDark ? Coloors.greyDark : Coloors.greyLight;
    return Row(
      children: [
        Icon(Icons.phone, color: grey),
        const SizedBox(width: 10),
        Text(
          'Call Me',
          style: TextStyle(color: grey),
        ),
      ],
    );
  }
}
