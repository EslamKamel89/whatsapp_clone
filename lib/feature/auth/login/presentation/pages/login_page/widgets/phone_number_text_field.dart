import 'package:flutter/material.dart';
import 'package:whatsapp/feature/auth/login/presentation/common_widgets/custom_text_field.dart';

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    super.key,
    required this.phoneNumberController,
  });

  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        controller: phoneNumberController,
        hintText: 'Phone Number',
        textAlign: TextAlign.left,
        keyboardType: TextInputType.phone,
      ),
    );
  }
}
