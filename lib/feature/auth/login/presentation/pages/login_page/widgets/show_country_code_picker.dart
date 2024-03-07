import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';

showCountryCodePicker({
  required BuildContext context,
  required TextEditingController countryCodeController,
  required TextEditingController countryNameController,
}) {
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
