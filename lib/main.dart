import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login-page.dart';
import 'package:payflow/modules/splash/splash-page.dart';
import 'package:payflow/shared/themes/app-colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NLW PayFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      home: const LoginPage(),
    );
  }
}
