import 'package:flutter/material.dart';

class WelcomeToWhatsApp extends StatelessWidget {
  const WelcomeToWhatsApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Welcome To WhatsApp',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
