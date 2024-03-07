import 'package:flutter/material.dart';
import 'package:whatsapp/feature/auth/login/presentation/common_widgets/custom_text_field.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/widgets/show_country_code_picker.dart';

class CountryCodeTextField extends StatelessWidget {
  const CountryCodeTextField({
    super.key,
    required this.countryCodeController,
    required this.countryNameController,
  });

  final TextEditingController countryCodeController;
  final TextEditingController countryNameController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: CustomTextField(
        controller: countryCodeController,
        onTap: () {
          showCountryCodePicker(
            context: context,
            countryCodeController: countryCodeController,
            countryNameController: countryNameController,
          );
        },
        readOnly: true,
        prefixText: '+',
      ),
    );
  }
}
