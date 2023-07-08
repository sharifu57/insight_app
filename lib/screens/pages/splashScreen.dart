import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insight_app/screens/authentication/login.dart';
import 'package:insight_app/screens/pages/navigations/screen.dart';
import 'package:insight_app/services/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkUser().then((hasUser) {
        if (hasUser != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Screen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = height;

    return Scaffold(
      body: Center(
        child: Container(
          height: fullHeight,
          width: fullWidth,
          color: Color.fromARGB(255, 1, 1, 48),
          child: Container(
            child: Image.asset(
              'assets/logos/in1.png',
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width / 4,
            ),
          ),
        ),
      ),
    );
  }
}
