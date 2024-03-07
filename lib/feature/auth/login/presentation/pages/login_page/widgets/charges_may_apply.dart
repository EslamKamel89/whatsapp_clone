import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';

class ChargesMayApplyText extends StatelessWidget {
  const ChargesMayApplyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    return Text(
      'Carrier charges may apply',
      style: TextStyle(color: isDark ? Coloors.greyDark : Coloors.greyLight),
    );
  }
}
