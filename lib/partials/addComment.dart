import 'package:flutter/material.dart';
import 'package:insight_app/services/config.dart';

class AddComment extends StatefulWidget {
  final String postID;
  final String postUsername;
  final String postFirstName;
  final String postLastName;
  final String postImage;
  AddComment(
      {required this.postID,
      required this.postUsername,
      required this.postFirstName,
      required this.postLastName,
      required this.postImage});

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
    // return Container(
    //   child: Text(widget.postID),
    // );
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
        actions: [TextButton(onPressed: () {}, child: Text("Reply"))],
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
                        Container(
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
                                color: const Color.fromARGB(255, 250, 250, 250),
                                fontSize: 12),
                            validator: (content) {
                              if (content!.isEmpty) {
                                return "write something";
                              }
                              return null;
                            },
                            onSaved: (content) {
                              _postData['content'] = content.toString();
                            },
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
}
