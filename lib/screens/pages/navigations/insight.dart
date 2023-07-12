import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insight_app/screens/pages/navigations/screen.dart';
import 'package:insight_app/services/api.dart';
import 'package:insight_app/services/config.dart';
import 'package:insight_app/services/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Insight extends StatefulWidget {
  const Insight({super.key});

  @override
  State<Insight> createState() => _InsightState();
}

class _InsightState extends State<Insight> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _userFormData = {};
  String? _username;
  int? _userId;
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    getUser();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _user = prefs.getString('user');
    final String? accessToken = prefs.getString("_accessToken");
    String? username = prefs.getString("_username");
    int? userId = prefs.getInt("_userId");

    setState(() {
      _username = username;
      _userId = userId;
      print("_____username");
      print(_username);
    });
  }

  File? imageFile;
  XFile? image;

  final ImagePicker _picker = ImagePicker();

  selectImage(imageSource) async {
    image = await _picker.pickImage(source: imageSource);
    setState(() {
      imageFile = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    // String? content;
    return Container(
        child: SingleChildScrollView(
      child: Container(
        color: Color.fromARGB(255, 1, 1, 48),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/screen');
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )),
                    TextButton(
                        onPressed: () {
                          submitInsight();
                        },
                        child: Text("Post"))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Form(
                    key: _formKey,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                              flex: 9,
                              child: SingleChildScrollView(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${_username}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      TextFormField(
                                        focusNode: _focusNode,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Whats happening...',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w100,
                                            )),
                                        minLines: 2,
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 250, 250, 250),
                                            fontSize: 12),
                                        validator: (content) {
                                          if (content!.isEmpty) {
                                            return "write something";
                                          }
                                          return null;
                                        },
                                        onSaved: (content) {
                                          _userFormData['content'] = content;
                                        },
                                      ),
                                      SizedBox(),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                            onPressed: () {
                                              selectImage(ImageSource.gallery);
                                            },
                                            icon: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 15,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    ));
  }

  submitInsight() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    print("___post insight");

    var submittedData = {
      "user": _userId,
      "content": _userFormData['content'],
      "attachment": imageFile == null
          ? null
          : await MultipartFile.fromFile(imageFile!.path),
    };

    print(submittedData);

    final endpoint = '${config['apiBaseUrl']}/create_post';
    final data = json.encode(submittedData);

    var response = await sendPostRequest(context, endpoint, data);

    setState(() {
      Future.delayed(Duration(seconds: 1), () {
        final snackBar = SnackBar(
          content: Text('${response['message']}'),
          backgroundColor: Colors.blue,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Screen()),
        );
      });
    });
  }
}
