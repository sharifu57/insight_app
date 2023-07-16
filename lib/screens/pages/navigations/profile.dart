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
  String? _bio;
  int? _passion;
  String? _location;
  String? _dob;
  String? _joined;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? accessToken = prefs.getString("_accessToken");
    String? username = prefs.getString("_username");
    String? firstName = prefs.getString("_first_name");
    String? lastname = prefs.getString("_last_name");
    String? bio = prefs.getString("_bio");
    int? passion = prefs.getInt("_passion");
    String? location = prefs.getString("_location");
    String? dob = prefs.getString("_dob");
    String? joined = prefs.getString("_created");

    // int? userId = prefs.getInt("_userId");

    setState(() {
      _username = username;
      _first_name = firstName;
      _last_name = lastname;
      _bio = bio;
      _passion = passion;
      _location = location;
      _dob = dob;
      _joined = joined;
    });
  }

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
                            child: Text(
                              "Profile Image",
                              style: TextStyle(color: Colors.white),
                            ),
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
                        ],
                      ),
                    ),
                    Container(
                      child: TextButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Colors.white, width: 1),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.secondaryColor),
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
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "@",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Text(
                      "${_username}",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "${_bio}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.badge,
                        color: Colors.grey,
                        size: 12,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: _passion == 1
                          ? Text("Marketing",
                              style: TextStyle(color: Colors.grey))
                          : _passion == 2
                              ? Text(
                                  "Science and Technology",
                                  style: TextStyle(color: Colors.grey),
                                )
                              : _passion == 3
                                  ? Text("Sports",
                                      style: TextStyle(color: Colors.grey))
                                  : _passion == 4
                                      ? Text("Sex and Life",
                                          style: TextStyle(color: Colors.grey))
                                      : Text(" "),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.pin,
                        color: Colors.grey,
                        size: 12,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "${_location}",
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.date_range,
                        color: Colors.grey,
                        size: 12,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Born ${_dob}",
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                        child: Text("Joined:",
                            style: TextStyle(color: Colors.grey))),
                    Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "${_joined}",
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
