import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home-page.dart';
import 'package:payflow/modules/login/login-page.dart';
import 'package:payflow/modules/splash/splash-page.dart';
import 'package:payflow/shared/themes/app-colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NLW PayFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      // home: const LoginPage(),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashPage(),
        "/home": (context) => HomePage(),
        "/login": (context) => LoginPage(),
      },
    );
  }
}
