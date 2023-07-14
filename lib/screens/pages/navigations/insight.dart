import 'package:flutter/material.dart';
import 'package:insight_app/services/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Insight extends StatefulWidget {
  const Insight({super.key});

  @override
  State<Insight> createState() => _InsightState();
}

class _InsightState extends State<Insight> {
  @override
  void initState() {
    // TODO: implement
    super.initState();
    getUser();
    print("____get user");
    print(getUser());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )),
                    TextButton(onPressed: () {}, child: Text("Post"))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: FutureBuilder<String?>(
                  future: checkUser(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        String? user = snapshot.data ?? '';
                        return Text(
                          user,
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _user = prefs.getString('user');
  }
}
