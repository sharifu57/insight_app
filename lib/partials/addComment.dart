import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:insight_app/screens/pages/navigations/screen.dart';
import 'package:insight_app/services/api.dart';
import 'package:insight_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddComment extends StatefulWidget {

  final String postUsername;
  final String postFirstName;
  final String postLastName;
  final String postImage;
  final String postID;
  AddComment(
      {
      required this.postUsername,
      required this.postFirstName,
      required this.postLastName,
      required this.postImage, required this.postID});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final _commentKey = GlobalKey<FormState>();
  final Map<String, dynamic> _postData = {};
  FocusNode _focusNode = FocusNode();
  get postID => null;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    getUser();
    print("______________post id");
    print(postID);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidht = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 1, 48),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/screen');
            },
            icon: Icon(
              Icons.cancel,
              color: Colors.white,
            )),
        actions: [
          TextButton(
              onPressed: () {
                addComment();
              },
              child: Text("Reply"))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          color: Color.fromARGB(255, 1, 1, 48),
          height: fullHeight,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const SizedBox(
                          height: 35,
                          width: 35,
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(70),
                          //   child: Container(
                          //     // ignore: unnecessary_null_comparison
                          //     child: widget.postImage == null
                          //         ? Container(
                          //             color: Colors.red,
                          //             child: Center(
                          //               child: Text("N"),
                          //             ),
                          //           )
                          //         : Image.network(
                          //             '${widget.postImage}',
                          //             fit: BoxFit.cover,
                          //             height:
                          //                 MediaQuery.of(context).size.height,
                          //           ),
                          //   ),
                          // ),
                        ),
                      )),
                  Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Replying to ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text("@", style: TextStyle(color: Colors.grey)),
                            Text(
                              widget.postFirstName,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.postLastName,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Form(
                          key: _commentKey,
                          child: Container(
                            child: TextFormField(
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'add your comment',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w100,
                                  )),
                              minLines: 2,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 250, 250, 250),
                                  fontSize: 12),
                              validator: (content) {
                                if (content!.isEmpty) {
                                  return "can not be blank";
                                }
                                return null;
                              },
                              onSaved: (content) {
                                _postData['content'] = content;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int? _userId;
  String? _postId;

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _user = prefs.getString('user');
    final String? accessToken = prefs.getString("_accessToken");
    int? userId = prefs.getInt("_userId");

    setState(() {
      _userId = userId;
      _postId = postID;
    });
  }

  Future addComment() async {
    if (!_commentKey.currentState!.validate()) {
      return;
    }

    _commentKey.currentState!.save();

    var commentPayload = {
      "user": _userId,
      "post": widget.postID,
      "content": _postData['content'],
    };

    final endpoint = '${config['apiBaseUrl']}/add_comment';
    final data = json.encode(commentPayload);

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
