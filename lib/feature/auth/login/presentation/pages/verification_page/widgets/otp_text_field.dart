import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/feature/auth/login/presentation/common_widgets/custom_text_field.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/verification_page/verification_page.dart';

class OtpTextField extends ConsumerWidget {
  const OtpTextField({
    super.key,
    this.codeController,
    required this.smsCodeId,
  });

  final TextEditingController? codeController;
  final String smsCodeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: CustomTextField(
        controller: codeController,
        hintText: " _ _ _  _ _ _",
        fontSize: 30,
        autoFocus: true,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 6) {
            return verifySmsCode(
              context: context,
              ref: ref,
              smsCode: value,
              smsCodeId: smsCodeId,
            );
          }
        },
        maxLength: 6,
      ),
    );
  }
}
