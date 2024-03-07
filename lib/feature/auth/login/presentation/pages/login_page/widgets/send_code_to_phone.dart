import 'package:flutter/material.dart';
import 'package:whatsapp/common/heler/show_alert_dialoge.dart';

sendCodeToPhone({
  required BuildContext context,
  required TextEditingController countryNameController,
  required TextEditingController phoneNumberController,
}) {
  final phone = phoneNumberController.text;
  final name = countryNameController.text;
  if (phone.isEmpty) {
    showCustomAlertDialoge(context: context, message: 'Please enter your phone number');
  } else if (phone.length < 9) {
    showCustomAlertDialoge(
        context: context,
        message:
            "The phone number you entered is too short for the country : $name\n\n Include your area code if you haven't");
  } else if (phone.length > 13) {
    showCustomAlertDialoge(
        context: context, message: 'The phone number you entered is too long for the country: $name');
  }
}
