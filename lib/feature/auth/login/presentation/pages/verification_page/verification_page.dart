import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';
import 'package:whatsapp/feature/auth/login/controller/auth_controller.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/verification_page/widgets/call_me.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/verification_page/widgets/otp_text_field.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/verification_page/widgets/resend_sms.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/verification_page/widgets/verification_appbar.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/verification_page/widgets/verification_text.dart';

class VerificationPage extends ConsumerWidget {
  const VerificationPage({
    super.key,
    required this.smsCodeId,
    required this.phoneNumber,
  });
  final String smsCodeId;
  final String phoneNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = isDarkMode(context);
    Color blue = isDark ? Coloors.blueDark : Coloors.blueLight;
    Color grey = isDark ? Coloors.greyDark : Coloors.greyLight;
    return Scaffold(
      appBar: verificationAppBar(
        context: context,
        onTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const VerificationText(),
              const SizedBox(height: 20),
              // OtpTextField(codeController: codeController),
              OtpTextField(smsCodeId: smsCodeId),
              const SizedBox(height: 20),
              Text(
                'Enter 6-digit code',
                style: TextStyle(color: grey),
              ),
              const SizedBox(height: 20),
              const ResendSms(),
              const SizedBox(height: 10),
              Divider(color: blue.withOpacity(0.2)),
              const SizedBox(height: 20),
              const CallMe(),
              const SizedBox(height: 10),
              Divider(color: blue.withOpacity(0.2)),
            ],
          ),
        ),
      ),
    );
  }
}

verifySmsCode({
  required BuildContext context,
  required WidgetRef ref,
  required String smsCode,
  required String smsCodeId,
}) async {
  ref.read(authControllerProvider).verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true,
      );
}
