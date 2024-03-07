import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/isdark.dart';
import 'package:whatsapp/common/utils/coloor.dart';
import 'package:whatsapp/common/widgets/custom_icon_button.dart';
import 'package:whatsapp/feature/auth/login/presentation/common_widgets/custom_text_field.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late TextEditingController codeController;
  @override
  void initState() {
    codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    Color blue = isDark ? Coloors.blueDark : Coloors.blueLight;
    Color grey = isDark ? Coloors.greyDark : Coloors.greyLight;
    return Scaffold(
      appBar: verificationAppBar(
        context: context,
        onTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "You've tried to register +0201024510803 before requesting an SMS or call with your code, ",
                  style: TextStyle(color: grey),
                  children: [
                    TextSpan(
                      text: '\nWrong Number?',
                      style: TextStyle(color: blue),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomTextField(
                  controller: codeController,
                  hintText: " _ _ _  _ _ _",
                  fontSize: 30,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  maxLength: 6,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Enter 6-digit code',
                style: TextStyle(color: grey),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.message, color: grey),
                  const SizedBox(width: 10),
                  Text(
                    'Resend SMS',
                    style: TextStyle(color: grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(color: blue.withOpacity(0.2)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.phone, color: grey),
                  const SizedBox(width: 10),
                  Text(
                    'Call Me',
                    style: TextStyle(color: grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(color: blue.withOpacity(0.2)),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar verificationAppBar({
  required BuildContext context,
  required void Function()? onTap,
}) {
  bool isDark = isDarkMode(context);
  return AppBar(
    title: Text(
      'Verify your Number',
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
