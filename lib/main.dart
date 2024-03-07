import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/common/theme/dark_theme.dart';
import 'package:whatsapp/common/theme/light_theme.dart';
import 'package:whatsapp/feature/auth/user_info/presentation/user_info/user_info.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whats app',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      // home: const WelcomePage(),
      // home: const LoginPage(),
      // home: const VerificationPage(),
      home: const UserInfo(),
    );
  }
}

/*

Platform  Firebase App Id
android   1:180485618206:android:a6c81a627c79836f2c4c0f
ios       1:180485618206:ios:de462d30a3a870cc2c4c0f


Serial number: 1
Valid from: Mon Nov 06 16:44:41 EET 2023 until: Wed Oct 29 17:44:41 EEST 2053
Certificate fingerprints:
SHA1: FF:75:24:77:7A:0C:BD:92:E9:EF:89:00:16:84:BE:59:A9:50:88:77
SHA256: FD:0D:33:E3:4E:82:76:4A:FF:48:06:B4:64:55:99:8D:A4:45:77:97:40:92:BA:20:E6:69:08:26:3A:B8:BC:95
 */