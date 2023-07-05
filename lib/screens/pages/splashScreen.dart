import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insight_app/screens/authentication/login.dart';

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
      // After 3 seconds, navigate to the next page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
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
          color: Color(0xff141463),
          child: Image.asset(
            'assets/logos/in1.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width / 10,
          ),
        ),
      ),
    );
  }
}
