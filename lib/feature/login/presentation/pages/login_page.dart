import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/common/heler/show_alert_dialoge.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';
import 'package:whatsapp/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp/common/widgets/custom_icon_button.dart';
import 'package:whatsapp/feature/login/presentation/widgets/custom_text_field.dart';

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

  showCountryCodePicker(BuildContext context) {
    bool isDark = isDarkMode(context);
    Color grey = isDark ? Coloors.greyDark : Coloors.greyLight;
    Color green = isDark ? Coloors.greenDark : Coloors.greenLight;

    showCountryPicker(
      context: context,
      onSelect: (country) {
        countryCodeController.text = country.phoneCode;
        countryNameController.text = country.name;
      },
      showPhoneCode: true,
      favorite: ['EG'],
      countryListTheme: CountryListThemeData(
        flagSize: 22,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: grey),
        inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: grey),
            suffixIcon: Icon(Icons.language, color: green),
            hintText: 'Search Country Code Or Name',
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: grey.withOpacity(0.3))),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: green))),
      ),
    );
  }

  sendCodeToPhone() {
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

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Please Enter Your Phone Number',
          style: TextStyle(
            color: !isDark ? Coloors.greenLight : null,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          CustomIconButton(
            icon: Icons.more_vert,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'WhatsApp will need to verify your phone number',
                  style: TextStyle(
                    color: !isDark ? Coloors.greyLight : Coloors.greyDark,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: " What's my number",
                      style: TextStyle(
                        color: !isDark ? Coloors.blueLight : Coloors.blueDark,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomTextField(
                readOnly: true,
                controller: countryNameController,
                onTap: () {
                  showCountryCodePicker(context);
                },
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: isDark ? Coloors.greenDark : Coloors.greenLight,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: CustomTextField(
                      controller: countryCodeController,
                      onTap: () {
                        showCountryCodePicker(context);
                      },
                      readOnly: true,
                      prefixText: '+',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      controller: phoneNumberController,
                      hintText: 'Phone Number',
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Carrier charges may apply',
              style: TextStyle(color: isDark ? Coloors.greyDark : Coloors.greyLight),
            )
          ],
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        text: 'Next',
        width: 80,
        onPressed: sendCodeToPhone,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
