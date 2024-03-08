import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';
import 'package:whatsapp/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp/common/widgets/custom_icon_button.dart';
import 'package:whatsapp/feature/auth/login/presentation/common_widgets/custom_text_field.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    Color blue = isDark ? Coloors.blueDark : Coloors.blueLight;
    Color grey = isDark ? Coloors.greyDark : Coloors.greyLight;
    Color green = isDark ? Coloors.greenDark : Coloors.greenLight;
    return Scaffold(
      appBar: userInfoAppBar(context: context, onTap: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Please provide your name and optional profile phote',
                style: TextStyle(color: grey),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                padding: const EdgeInsets.all(25),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  const Expanded(
                    child: CustomTextField(
                      autoFocus: true,
                      hintText: 'Type your name here',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.emoji_emotions_outlined, color: green),
                  const SizedBox(width: 20),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        text: 'NEXT',
        onPressed: () {},
        width: 90,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

AppBar userInfoAppBar({
  required BuildContext context,
  required void Function()? onTap,
}) {
  bool isDark = isDarkMode(context);
  return AppBar(
    title: Text(
      'Profile Info',
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
        onPressed: onTap,
      ),
    ],
  );
}
