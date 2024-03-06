// import 'package:flutter/material.dart';
// import 'package:whatsapp/common/utils/coloor.dart';

// class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
//   final Color? circleImageColor;
//   final Color? greyColor;
//   final Color? blueColor;
//   final Color? langBtnBgColor;
//   final Color? langBtnHighLightColor;

//   CustomThemeExtension({
//     this.circleImageColor,
//     this.greyColor,
//     this.blueColor,
//     this.langBtnBgColor,
//     this.langBtnHighLightColor,
//   });

//   static final CustomThemeExtension lightMode = CustomThemeExtension(
//     circleImageColor: const Color(0xFF25D366),
//     greyColor: Coloors.greyLight,
//     blueColor: Coloors.blueLight,
//     langBtnBgColor: const Color(0xFFF7F8FA),
//     langBtnHighLightColor: const Color(0xFFE8E8ED),
//   );
//   static final CustomThemeExtension darkMode = CustomThemeExtension(
//     circleImageColor: Coloors.greenDark,
//     greyColor: Coloors.greyLight,
//     blueColor: Coloors.blueLight,
//     langBtnBgColor: const Color(0xFF182229),
//     langBtnHighLightColor: const Color(0xFF09141A),
//   );
//   @override
//   ThemeExtension<CustomThemeExtension> copyWith(
//     Color? circleImageColor,
//     Color? greyColor,
//     Color? blueColor,
//     Color? langBtnBgColor,
//     Color? langBtnHighLightColor,
//   ) {
//     return CustomThemeExtension(
//       circleImageColor: circleImageColor ?? this.circleImageColor,
//       greyColor: greyColor ?? this.greyColor,
//       blueColor: blueColor ?? this.blueColor,
//       langBtnBgColor: langBtnBgColor ?? this.langBtnBgColor,
//       langBtnHighLightColor: langBtnHighLightColor ?? this.langBtnHighLightColor,
//     );
//   }

//   @override
//   ThemeExtension<CustomThemeExtension> lerp(covariant ThemeExtension<CustomThemeExtension>? other, double t) {
//     if (other is CustomThemeExtension) {
//       return this;
//     }
//     return CustomThemeExtension(
//       circleImageColor: Color.lerp(circleImageColor, ),
//       greyColor: Color.lerp(circleImageColor, other.c),
//       blueColor: Color.lerp(circleImageColor, other.c),
//       langBtnBgColor: Color.lerp(circleImageColor, other.c),
//       langBtnHighLightColor: Color.lerp(circleImageColor, other.c),
//     );
//   }
// }
