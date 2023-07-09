import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:insight_app/partials/errorMessage.dart';

Future sendPostRequest(BuildContext context, endpoint, dynamic data) async {
  try {
    final response = await Dio().post(endpoint, data: data);

    if (response.data['status'] != 200 || response.data['status'] != 201) {
      // ignore: use_build_context_synchronously
      ErrorDialog.showErrorDialog(context, response.data['message'].toString());
    }
    return response.data;
  } catch (e) {
    return null;
  }
}
