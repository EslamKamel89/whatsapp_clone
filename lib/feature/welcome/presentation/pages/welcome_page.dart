import 'package:flutter/material.dart';
import 'package:whatsapp/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp/feature/welcome/presentation/widgets/choose_language.dart';
import 'package:whatsapp/feature/welcome/presentation/widgets/privacy_policy.dart';
import 'package:whatsapp/feature/welcome/presentation/widgets/welcome_to_whatsapp.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(child: Image.asset('assets/images/welcome_logo.png')),
            Expanded(
              child: SizedBox(
                // color: Colors.red,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const WelcomeToWhatsApp(),
                    const SizedBox(height: 30),
                    const PrivacyPolicy(),
                    const SizedBox(height: 30),
                    CustomElevatedButton(
                      text: 'Agree And Continue',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    const ChooseLanguage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
