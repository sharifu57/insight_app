import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:insight_app/partials/errorMessage.dart';

Future sendPostRequest(BuildContext context, endpoint, dynamic data) async {
  try {
    final response = await Dio().post(endpoint, data: data);

    if (response.data['status'] != 200 || response.data['status'] != 201) {
      ErrorDialog.showErrorDialog(context, response.data['message'].toString());
    }
    return response.data;
  } catch (e) {
    return null;
  }
}

Future getRequest(BuildContext context, endpoint) async {
  try {
    final response = await Dio().get(endpoint);
    print("_____start print");
    print(response);
    print("______end print");
    return response.data;
  } catch (e) {
    print(e);
  }
}
