import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:insight_app/partials/errorMessage.dart';

final Dio dio = Dio();

Future sendPostRequest(BuildContext context, endpoint, dynamic data) async {
  try {
    final response = await dio.post(endpoint, data: data);

    if (response.data['status'] == 200) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ErrorDialog.showErrorDialog(context, response.data['message'].toString());
    }
  } catch (e) {
    print(e);
  }
}
