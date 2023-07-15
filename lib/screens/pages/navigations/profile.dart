import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insight_app/includes/colors.dart';
import 'package:insight_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _username;
  String? _first_name;
  String? _last_name;

  @override
  void initState() {
    super.initState();
    getUser();
    // getUserFromLocalStorage();
  }

  // User user =  getUserFromLocalStorage();

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? accessToken = prefs.getString("_accessToken");
    String? username = prefs.getString("_username");
    String? firstName = prefs.getString("_first_name");
    String? lastname = prefs.getString("_last_name");
    // int? userId = prefs.getInt("_userId");

    setState(() {
      _username = username;
      _first_name = firstName;
      _last_name = lastname;
    });
  }

  // Future<User> getUserFromLocalStorage() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userJson = prefs.getString('user');

  //   if (userJson != null){
  //     Map<String, dynamic>userMap = json.decode(userJson);
  //     User user = User.fromJson(userMap);
  //     return user;
  //   }
  //   else{
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 5,
        leading: IconButton(
            onPressed: () async {
              const url = 'https://www.example.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            icon: Icon(
              Icons.link,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: AppColors.secondaryColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: fullHeight,
          width: fullHeight,
          color: AppColors.backgroundColor,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Profile Image", style: TextStyle(color: Colors.white),),
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  "${_first_name}".toUpperCase(),
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${_last_name}".toUpperCase(),
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "@",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                                Text(
                                  "${_username}",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: TextButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Colors.white, width: 1),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppColors.primaryColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(AppColors.secondaryColor),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Edit Profile'),
                      ),
                    )
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.only(top: 20),
              //   child: Text("${userId}"),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
