import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/helper/show_alert_dialoge.dart';
import 'package:whatsapp/feature/auth/login/controller/auth_controller.dart';

sendCodeToPhone({
  required BuildContext context,
  required TextEditingController countryNameController,
  required TextEditingController phoneNumberController,
  required TextEditingController countryCodeController,
  required WidgetRef ref,
}) {
  final phoneNumber = phoneNumberController.text;
  final countryName = countryNameController.text;
  final countryCode = countryCodeController.text;
  if (phoneNumber.isEmpty) {
    return showCustomAlertDialoge(context: context, message: 'Please enter your phone number');
  } else if (phoneNumber.length < 9) {
    return showCustomAlertDialoge(
        context: context,
        message:
            "The phone number you entered is too short for the country : $countryName\n\n Include your area code if you haven't");
  } else if (phoneNumber.length > 13) {
    return showCustomAlertDialoge(
        context: context, message: 'The phone number you entered is too long for the country: $countryName');
  }
  // request a verfication code
  ref.read(authControllerProvider).sendSmsCode(
        context: context,
        phoneNumber: '+$countryCode$phoneNumber',
      );
}
