import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 1, 1, 48),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 1, 1, 48),
          child: Column(children: [
            Container(
              child: SizedBox(
                height: 30,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/logos/in1.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width / 4,
              ),
            ),
            Container(
              child: Text(
                'Register Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Form(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Full Name",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "please enter your name",
                                  hintStyle: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  hintStyle: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "password",
                                  hintStyle: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Register Account")),
                    )
                  ],
                ),
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
