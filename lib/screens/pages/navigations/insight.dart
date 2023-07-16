import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insight_app/screens/pages/navigations/screen.dart';
import 'package:insight_app/services/api.dart';
import 'package:insight_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Insight extends StatefulWidget {
  const Insight({super.key});

  @override
  State<Insight> createState() => _InsightState();
}

class _InsightState extends State<Insight> {
  final _postKey = GlobalKey<FormState>();
  final Map<String, dynamic> _postData = {};
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
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
                              Navigator.pushReplacementNamed(
                                  context, '/screen');
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
                        key: _postKey,
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
                                          Container(
                                            child: TextFormField(
                                              focusNode: _focusNode,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'Whats happening...',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w100,
                                                  )),
                                              minLines: 2,
                                              maxLines: null,
                                              keyboardType:
                                                  TextInputType.multiline,
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
                                                _postData['content'] =
                                                    content.toString();
                                              },
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                // selectImage(ImageSource.camera);
                                                selectImage(
                                                    ImageSource.gallery);
                                              },
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 15,
                                              )),
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

  Future submitInsight() async {
    print("_____start submit post");
    if (!_postKey.currentState!.validate()) {
      return;
    }

    _postKey.currentState!.save();
    String? base64Image;
    if (imageFile != null) {
      List<int> imageBytes = await imageFile!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    FormData data = FormData.fromMap({
      "user": _userId,
      "content": _postData['content'].toString(),
      "attachment": imageFile == null
          ? null
          : await MultipartFile.fromFile(imageFile!.path),
    });

    print("______payload submit here____");
    print(data);
    print("_______end print payload here_____");

    final endpoint = '${config['apiBaseUrl']}/create_post';
    print(data);

    var response = await sendPostRequest(context, endpoint, data);
    print("__response, ${response}");

    setState(() {
      Future.delayed(Duration(seconds: 2), () {
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
