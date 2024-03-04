import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coloor.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({
    super.key,
  });
  void showCustomBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          // color: Colors.red,
          height: 500,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: double.infinity, height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'App Language',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ],
              ),
              const Divider(color: Coloors.grey),
              RadioListTile(
                value: true,
                groupValue: true,
                onChanged: (value) {},
                activeColor: Coloors.green,
                title: const Text('English'),
                subtitle: const Text("App's Language"),
              ),
              RadioListTile(
                value: true,
                groupValue: false,
                onChanged: (value) {},
                activeColor: Coloors.green,
                title: const Text('اللغة العربية'),
                subtitle: const Text("لغة التطبيق"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          showCustomBottomSheet(context);
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language),
            SizedBox(width: 5),
            Text('English'),
            SizedBox(width: 5),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
