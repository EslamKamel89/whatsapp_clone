import 'package:flutter/material.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/login_page/login_page.dart';
import 'package:whatsapp/feature/auth/login/presentation/pages/verification_page/verification_page.dart';
import 'package:whatsapp/feature/auth/user_info/presentation/user_info/user_info_page.dart';
import 'package:whatsapp/feature/welcome/presentation/pages/welcome_page.dart';

class Routes {
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String verification = 'verification';
  static const String userInfo = 'userInfo';
  // static const String welcome = 'welcome';
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    final Map args = (routeSettings.arguments ?? {}) as Map;
    switch (routeSettings.name) {
      case welcome:
        return MaterialPageRoute(builder: (context) => const WelcomePage());
      case verification:
        return MaterialPageRoute(
          builder: (context) => VerificationPage(
            verificationId: args['verificationId'],
            phoneNumber: args['phoneNumber'],
          ),
        );
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case userInfo:
        return MaterialPageRoute(builder: (context) => const UserInfoPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No page route provided'),
            ),
          ),
        );
    }
  }
}
