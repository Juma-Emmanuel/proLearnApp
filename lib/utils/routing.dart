import 'package:flutter/material.dart';
import 'package:online_course/screens/LoginScreen.dart';
import 'package:online_course/screens/RegistrationScreen.dart';
import 'package:online_course/screens/root_app.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegistrationScreen(),
    '/rootapp': (context) => const RootApp(),
  };
}
