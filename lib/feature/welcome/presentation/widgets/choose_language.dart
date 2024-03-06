import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';
import 'package:whatsapp/common/widgets/custom_icon_button.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({
    super.key,
  });
  void showCustomBottomSheet(BuildContext context) {
    bool isDark = isDarkMode(context);
    Color green = isDark ? Coloors.greenDark : Coloors.greenLight;
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: isDark ? Coloors.backgroundDark : const Color.fromARGB(255, 244, 242, 242),
          // color: Colors.white,
          // height: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: double.infinity, height: 10),
              Row(
                children: [
                  CustomIconButton(
                    icon: Icons.close,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'App Language',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ],
              ),
              // const Divider(color: Coloors.grey),
              RadioListTile(
                value: true,
                groupValue: true,
                onChanged: (value) {},
                fillColor: MaterialStatePropertyAll(green),
                // overlayColor: ,
                title: Text(
                  'English',
                  style: TextStyle(
                    color: green,
                  ),
                ),
                subtitle: Text(
                  "App's Language",
                  style: TextStyle(
                    color: green,
                  ),
                ),
              ),
              RadioListTile(
                value: true,
                groupValue: false,
                onChanged: (value) {},
                activeColor: green,
                selectedTileColor: green,
                fillColor: MaterialStatePropertyAll(green),
                // Color
                title: Text(
                  'اللغة العربية',
                  style: TextStyle(
                    color: green,
                  ),
                ),
                subtitle: Text(
                  "لغة التطبيق",
                  style: TextStyle(
                    color: green,
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF182229) : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: const Color(0xFF09141A),
        onTap: () {
          showCustomBottomSheet(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              color: isDark ? Coloors.greenDark : Colors.green.shade900,
            ),
            const SizedBox(width: 5),
            Text(
              'English',
              style: TextStyle(
                color: isDark ? Coloors.greenDark : Colors.green.shade900,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.arrow_drop_down,
              color: isDark ? Coloors.greenDark : Colors.green.shade900,
            ),
          ],
        ),
      ),
    );
  }
}
