import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coloor.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'Read Out ',
        style: TextStyle(color: Coloors.black, height: 1.5),
        children: [
          TextSpan(
            text: 'Privacy Polcy ',
            style: TextStyle(color: Coloors.grey, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Tap "Agree And Continue" to accept the ',
            style: TextStyle(color: Coloors.black),
          ),
          TextSpan(
            text: 'Terms Of Services.',
            style: TextStyle(color: Coloors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
