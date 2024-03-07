import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coloor.dart';
import 'package:whatsapp/feature/auth/login/presentation/common_widgets/custom_text_field.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/widgets/show_country_code_picker.dart';

class CountryNameTextField extends StatelessWidget {
  const CountryNameTextField({
    super.key,
    required this.countryNameController,
    required this.countryCodeController,
    required this.isDark,
  });

  final TextEditingController countryNameController;
  final TextEditingController countryCodeController;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: CustomTextField(
        readOnly: true,
        controller: countryNameController,
        onTap: () {
          showCountryCodePicker(
            context: context,
            countryCodeController: countryCodeController,
            countryNameController: countryNameController,
          );
        },
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: isDark ? Coloors.greenDark : Coloors.greenLight,
        ),
      ),
    );
  }
}
