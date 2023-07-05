import 'dart:convert';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _userFormData = {};
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
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
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "name@youremail.com",
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                      keyboardType: TextInputType.text,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      validator: (email) {
                                        if (email!.isEmpty ||
                                            email?.length == 0) {
                                          return "invalid email or name";
                                        }
                                        return null;
                                      },
                                      onSaved: (email) {
                                        _userFormData['email'] = email;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 40),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Password",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      validator: (password) {
                                        if (password!.isEmpty) {
                                          return "password is required";
                                        }
                                        return null;
                                      },
                                      onSaved: (password) {
                                        _userFormData['password'] = password;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                                onPressed: () {},
                                child: Text("Forgot Password")),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: ElevatedButton(
                                onPressed: () {
                                  loginUSer();
                                },
                                child: Container(
                                  child: Center(
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            strokeWidth: 1,
                                          )
                                        : Text("LOGIN"),
                                  ),
                                )),
                          ),
                          Container(
                            child: Center(
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text("CREATE ACCOUNT")),
                            ),
                          )
                        ],
                      ),
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future loginUSer() async {
    if (_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
      });
    });

    var submittedData = json.encode({
      "email": _userFormData['email'],
      "password": _userFormData['password']
    });

    print(submittedData);
  }
}
