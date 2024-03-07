import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/widgets/charges_may_apply.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/widgets/country_code_text_field.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/widgets/country_name_text_field.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/widgets/login_appbar.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/widgets/phone_number_text_field.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/widgets/send_code_to_phone.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/widgets/verify_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;
  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Egypt');
    countryCodeController = TextEditingController(text: '20');
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    return Scaffold(
      appBar: loginAppBar(
        context: context,
        onTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            const VerifyText(),
            const SizedBox(height: 10),
            CountryNameTextField(
              countryNameController: countryNameController,
              countryCodeController: countryCodeController,
              isDark: isDark,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  CountryCodeTextField(
                    countryCodeController: countryCodeController,
                    countryNameController: countryNameController,
                  ),
                  const SizedBox(width: 10),
                  PhoneNumberTextField(
                    phoneNumberController: phoneNumberController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const ChargesMayApplyText()
          ],
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        text: 'Next',
        width: 80,
        onPressed: () {
          sendCodeToPhone(
            context: context,
            countryNameController: countryNameController,
            phoneNumberController: phoneNumberController,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
