import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coloor.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      scaffoldBackgroundColor: Coloors.backgroundLight,
      colorScheme: const ColorScheme.dark().copyWith(
        background: Coloors.backgroundLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Coloors.greenLight,
          foregroundColor: Coloors.backgroundLight,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: const BeveledRectangleBorder(),
        ),
      ));
}
