import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:insight_app/services/api.dart';
import 'package:insight_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _userFormData = {};
  bool _isLoading = false;
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
                height: 0,
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
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 2),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "First Name",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "please enter your name",
                                        hintStyle: TextStyle(
                                            fontSize: 10, color: Colors.grey)),
                                    keyboardType: TextInputType.text,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    validator: (firstName) {
                                      if (firstName!.isEmpty) {
                                        return "invalid first name";
                                      }
                                      return null;
                                    },
                                    onSaved: (firstName) {
                                      _userFormData['first_name'] = firstName;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Last Name",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "please enter your name",
                                        hintStyle: TextStyle(
                                            fontSize: 10, color: Colors.grey)),
                                    keyboardType: TextInputType.text,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    validator: (lastName) {
                                      if (lastName!.isEmpty) {
                                        return "invalid last name";
                                      }
                                      return null;
                                    },
                                    onSaved: (lastName) {
                                      _userFormData['last_name'] = lastName;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Username",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Enter your username",
                                  hintStyle: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                              keyboardType: TextInputType.text,
                              enableSuggestions: false,
                              autocorrect: false,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              validator: (username) {
                                if (username!.isEmpty) {
                                  return "invalid user name";
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
                              keyboardType: TextInputType.text,
                              enableSuggestions: false,
                              autocorrect: false,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return "Email is required.";
                                } else if (!EmailValidator.validate(email)) {
                                  return "Invalid email address.";
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              obscureText: true,
                              validator: (password) {
                                if (password!.isEmpty) {
                                  return "Password is required.";
                                } else if (password.length < 8) {
                                  return "Password must be at least 8 characters long.";
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
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            _register();
                          },
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  strokeWidth: 1,
                                )
                              : Text("Register Account")),
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

  Future _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    var userData = {
      "first_name": _userFormData['first_name'],
      "last_name": _userFormData['last_name'],
      "email": _userFormData['email'],
      "username": _userFormData['username'],
      "password": _userFormData['password']
    };

    print(userData);

    final endpoint = '${config['apiBaseUrl']}/register';
    final data = json.encode(userData);

    var response = await sendPostRequest(context, endpoint, data);

    if (response != null) {
      if (response['status'] == 201) {
        Navigator.restorablePushNamed(context, '/login');
      } else {}
    } else {
      return null;
    }

    setState(() {
      _isLoading = false;
    });
  }
}
