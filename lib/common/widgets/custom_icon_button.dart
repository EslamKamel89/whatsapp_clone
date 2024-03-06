import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.color,
    this.iconSize,
    this.minWidth,
  });
  final void Function()? onPressed;
  final IconData icon;
  final Color? color;
  final double? iconSize;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    return IconButton(
      icon: Icon(
        icon,
        color: color ?? (!isDark ? Coloors.greenLight : null),
      ),
      iconSize: iconSize ?? 20,
      constraints: BoxConstraints(minWidth: minWidth ?? 40),
      onPressed: onPressed,
    );
  }
}
