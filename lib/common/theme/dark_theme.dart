import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coloor.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      scaffoldBackgroundColor: Coloors.backgroundDark,
      colorScheme: const ColorScheme.dark().copyWith(
        background: Coloors.backgroundDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Coloors.greenDark,
          foregroundColor: Coloors.backgroundDark,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: const BeveledRectangleBorder(),
        ),
      ));
}
