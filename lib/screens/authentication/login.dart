import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 1, 1, 48),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              child: Image.asset(
                'assets/logos/in1.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width / 4,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Form(
                  child: Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email or Useraname",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      child: TextFormField(),
                    )
                  ],
                ),
              )),
            ))
          ],
        ),
      ),
    );
  }
}
