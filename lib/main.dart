import 'package:flutter/material.dart';
import 'package:insight_app/screens/pages/routes.dart';
import 'package:insight_app/screens/pages/splashScreen.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter ',
        debugShowCheckedModeBanner: false,
        // routes: route,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
