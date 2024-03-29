import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixText,
    this.readOnly,
    this.textAlign,
    this.keyboardType,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
    this.fontSize,
    this.autoFocus,
    this.maxLength,
  });
  final TextEditingController? controller;
  final String? hintText;
  final String? prefixText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool? autoFocus;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    Color green = isDark ? Coloors.greenDark : Coloors.greenLight;
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: fontSize == null ? null : TextStyle(fontSize: fontSize),
      autofocus: autoFocus ?? false,
      textAlign: textAlign ?? TextAlign.center,
      maxLength: maxLength,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(color: green),
        suffix: suffixIcon,
        prefixText: prefixText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: green),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: green, width: 2),
        ),
      ),
    );
  }
}
