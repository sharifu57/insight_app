import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insight_app/services/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            elevation: 0,
            leading: Container()),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 1, 1, 48),
            child: FutureBuilder<String?>(
              future: checkUser(),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    String? user = snapshot.data ?? '';
                    return Text(user);
                  }
                }
              },
            ),
          ),
        ));
  }
}
