import 'package:flutter/material.dart';
import 'package:insight_app/screens/authentication/login.dart';
import 'package:insight_app/screens/pages/navigations/home.dart';
import 'package:insight_app/screens/pages/navigations/screen.dart';
import 'package:insight_app/screens/pages/splashScreen.dart';

final route = {
  '/splash': (BuildContext context) => SplashScreen(),
  '/home': (context) => HomePage(),
  '/screen': (context) => Screen(),
  '/login': (context) => Login()
};
