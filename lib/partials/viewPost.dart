import 'package:flutter/material.dart';
import 'package:insight_app/includes/colors.dart';
import 'package:insight_app/services/api.dart';
import 'package:insight_app/services/config.dart';

class ViewPost extends StatelessWidget {
  final dynamic post;
  const ViewPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    final int? postId = post['id'];
    final String? content = post['content'];
    final String? attachment = post['attachment'];
    final String? created = post['created'];
    final String? author_first_name = post['user']?['first_name'];
    final String? author_last_name = post['user']?['last_name'];
    final String? author_username = post['user']?['username'];
    final String? author_profile_picture = post['user']?['profile']?['image'];
    final List<dynamic> comments = post['comment'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          "Insight",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/screen');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: fullHeight,
          width: fullWidth,
          padding: EdgeInsets.all(20),
          color: AppColors.primaryColor,
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: SizedBox(
                            height: 35,
                            width: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Container(
                                child: author_profile_picture == null
                                    ? Container(
                                        color: Colors.yellow,
                                        child: Center(
                                          child: Text("M"),
                                        ),
                                      )
                                    : Image.network(
                                        '$path${author_profile_picture}',
                                        fit: BoxFit.cover,
                                        height: fullHeight,
                                      ),
                              ),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 9,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "${author_first_name}",
                                        style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${author_last_name}",
                                        style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "@ ${author_username}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 15),
                child: attachment == null
                    ? Text(
                        '${content}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 0, bottom: 10),
                              child: Text(
                                '${content}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ),
                            Container(
                              child: Image.network(
                                "$path$attachment",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                              ),
                            )
                          ],
                        ),
                      ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "${created}",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Divider(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: comments.isEmpty ? 0 : comments.length,
                      itemBuilder: (BuildContext context, index) {
                        final comment = comments[index];
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(70),
                                              child: Container(
                                                color: Colors.yellow,
                                                child: Center(
                                                  child: Text(
                                                      "${comments[index]['user']['first_name'][0]}"
                                                          .toUpperCase()),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "${comments[index]['user']['first_name']}",
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .secondaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  " ${comments[index]['user']['last_name']}",
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .secondaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              "@${comments[index]['user']['username']}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 2, bottom: 10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      "${comments[index]['content']}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12)),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    '${comments[index]['created']}',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider()
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
