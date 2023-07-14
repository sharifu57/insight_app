import 'package:flutter/material.dart';
import 'package:insight_app/services/api.dart';
import 'package:insight_app/services/config.dart';

class ViewPost extends StatefulWidget {
  final String? postId;
  final Post post;
  const ViewPost({super.key, required this.postId, required this.post});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  Future viewOnePost(int? postId) async {
    final api = '${config['apiBaseUrl']}/post/$postId';
    final response = await getRequest(api);
    print("_______this post");
    print(response);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 1, 48),
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
          color: Color(0xFF010130),
          // child: Center(
          //   child: Text("${widget.post}")
          // ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(flex: 9, child: Container())
                  ],
                ),
              ),
              Expanded(child: Container(
                child: Text("${widget.post}", style: TextStyle(color: Colors.white),),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
