import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insight_app/models/postModel.dart';
import 'package:insight_app/partials/addComment.dart';
import 'package:insight_app/partials/viewPost.dart';
import 'package:insight_app/services/api.dart';
import 'package:insight_app/services/config.dart';
import 'package:insight_app/services/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final endpoint = '${config['apiBaseUrl']}/posts';
  final url = '${config['apiBaseUrl']}/commets_by_post';
  List posts = [];

  Future getPosts() async {
    final response = await getRequest(endpoint);

    if (response != null) {
      setState(() {
        posts = response.data?['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: Center(
                child: Image.asset(
              'assets/logos/in1.png',
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width / 10,
            )),
            actions: <Widget>[
              TextButton(onPressed: () {}, child: Text(''))
            ], //<Widget>[]
            backgroundColor: Color.fromARGB(255, 1, 1, 48),
            elevation: 4,
            leading: Container()),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 1, 1, 48),
            // child: FutureBuilder<String?>(
            //   future: checkUser(),
            //   builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else {
            //       if (snapshot.hasError) {
            //         return Text('Error: ${snapshot.error}');
            //       } else {
            //         String? user = snapshot.data ?? '';
            //         return Text(
            //           user,
            //           style: TextStyle(color: Colors.white),
            //         );
            //       }
            //     }
            //   },
            // ),
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: posts.isEmpty
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: posts.isEmpty ? 0 : posts.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                          child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          child: Container(
                                            child: posts[index]['user']
                                                            ?['profile']
                                                        ?['image'] ==
                                                    null
                                                ? Container(
                                                    color: Colors.red,
                                                    child: Center(
                                                      child: Text("N"),
                                                    ),
                                                  )
                                                : Image.network(
                                                    '$path${posts[index]['user']?['profile']['image']}',
                                                    fit: BoxFit.cover,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 9,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${posts[index]['user']?['username']}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Container(
                                                      child: Text(' @',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      68,
                                                                      68,
                                                                      68))),
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${posts[index]['user']?['first_name']}",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF444444),
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                              "${posts[index]['user']?['last_name']}",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          68,
                                                                          68,
                                                                          68),
                                                                  fontSize:
                                                                      12)),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          Icons
                                                              .keyboard_control_rounded,
                                                          color: Colors.white,
                                                          size: 13,
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: InkWell(
                                              onTap: () {
                                                // viewOnePost(
                                                //     posts[index]?['id']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ViewPost(
                                                            post:
                                                                '${posts[index]}',
                                                            postId:
                                                                '${posts[index]?['id']}')));
                                              },
                                              child: posts[index]
                                                          ['attachment'] ==
                                                      null
                                                  ? Text(
                                                      "${posts[index]['content']}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 12),
                                                    )
                                                  : Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 10),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "${posts[index]['content']}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Image.network(
                                                            '$path${posts[index]['attachment']}',
                                                            fit: BoxFit.cover,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                3,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: fullWidth,
                                            child: SingleChildScrollView(
                                              child: Row(
                                                
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      AddComment(
                                                                        postImage:
                                                                            '${posts[index]['user']['profile']['image']}',
                                                                        postID:
                                                                            '${posts[index]['id']}',
                                                                        postUsername:
                                                                            '${posts[index]['user']['username']}',
                                                                        postFirstName:
                                                                            '${posts[index]['user']['first_name']}',
                                                                        postLastName:
                                                                            '${posts[index]['user']['last_name']}',
                                                                      )));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.chat,
                                                          size: 17,
                                                          color: Colors.grey,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  "${posts[index]['comment']?.length}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                              Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5),
                                                                  child: Text(
                                                                    "Comments",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                                Icons
                                                                    .heart_broken,
                                                                size: 17)),
                                                        Text(
                                                          " 20 likes",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.share,
                                                              size: 17,
                                                            )),
                                                        Text(
                                                          " 20 likes",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Divider(
                            color: Color(0xFF444444),
                          )
                        ],
                      ));
                    }),
          ),
        ));
  }
}
