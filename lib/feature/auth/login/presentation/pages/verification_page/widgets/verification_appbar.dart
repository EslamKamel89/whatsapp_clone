import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';
import 'package:whatsapp/common/widgets/custom_icon_button.dart';

AppBar verificationAppBar({
  required BuildContext context,
  required void Function()? onTap,
}) {
  bool isDark = isDarkMode(context);
  return AppBar(
    title: Text(
      'Verify your Number',
      style: TextStyle(
        color: !isDark ? Coloors.greenLight : null,
        fontSize: 17,
      ),
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: [
      CustomIconButton(
        icon: Icons.more_vert,
        onPressed: onTap,
      ),
    ],
  );
}
