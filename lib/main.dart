import 'package:flutter/material.dart';
import 'package:online_course/screens/LoginScreen.dart';

import 'package:online_course/utils/routing.dart';
import 'theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Course App',
      theme: ThemeData(
        primaryColor: AppColor.primary,
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
      home: LoginScreen(),
      // home: RootApp(),
    );
  }
}
