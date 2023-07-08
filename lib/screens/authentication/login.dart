import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insight_app/screens/authentication/register.dart';
import 'package:insight_app/services/api.dart';
import 'package:insight_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      validator: (username) {
                                        if (username!.isEmpty ||
                                            username?.length == 0) {
                                          return "invalid email or name";
                                        }
                                        return null;
                                      },
                                      onSaved: (username) {
                                        _userFormData['username'] = username;
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
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
                                onPressed: () {
                                  _toRegisterPage();
                                },
                                child: Text("Forgot Password")),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: ElevatedButton(
                                onPressed: () {
                                  print("------login");
                                  loginUser();
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
                                  onPressed: () {
                                    _toRegisterPage();
                                  },
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

  Future _toRegisterPage() async {
    setState(() {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = true;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Register()),
        );
      });
    });
  }

  Future loginUser() async {
    print("-----start");
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    var submittedData = {
      "username": _userFormData['username'],
      "password": _userFormData['password']
    };

    print(submittedData);

    final endpoint = '${config['apiBaseUrl']}/login';
    final data = json.encode(submittedData);

    var response = await sendPostRequest(context, endpoint, data);

    // ignore: unnecessary_null_comparison
    if (response != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String responseString = jsonEncode(response);
      await pref.setString('user', responseString);

      Navigator.restorablePushNamed(context, '/screen');
    } else {
      return null;
    }

    setState(() {
      _isLoading = false;
    });
  }
}
