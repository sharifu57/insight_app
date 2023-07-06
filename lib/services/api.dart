import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:insight_app/partials/errorMessage.dart';

final Dio dio = Dio();

Future<void> sendRequest(
    BuildContext context, String endpoint, String method, dynamic data) async {
  try {
    final response = await dio.request(endpoint,
        options: Options(method: method), data: data);
    print("------print response");
    print(response);
    if (response.statusCode != 201) {
      ErrorDialog.showErrorDialog(context, response);
    }
  } catch (e) {
    print(e);
  }
}
