import 'package:flutter/material.dart';
import 'package:whatsapp/feature/auth/login/presentation/common_widgets/custom_text_field.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
    required this.codeController,
  });

  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: CustomTextField(
        controller: codeController,
        hintText: " _ _ _  _ _ _",
        fontSize: 30,
        autoFocus: true,
        keyboardType: TextInputType.number,
        onChanged: (value) {},
        maxLength: 6,
      ),
    );
  }
}
