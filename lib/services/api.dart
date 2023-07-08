import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:insight_app/partials/errorMessage.dart';

Future sendPostRequest(BuildContext context, endpoint, dynamic data) async {
  try {
    final response = await Dio().post(endpoint, data: data);
    print(response);
    if (response != null) {
      if (response.data['status'] != 200) {
        ErrorDialog.showErrorDialog(
            context, response.data['message'].toString());
      }
      return response.data;
    }
  } catch (e) {
    print(e);
    return null;
  }
}
