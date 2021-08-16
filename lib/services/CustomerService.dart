
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:dio/dio.dart';

Future<bool> getCustomers(BuildContext context,  String username, String password) async {

  ProgressDialog pr;// = new ProgressDialog(context);
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(
        message: "Please wait..."
    );
    await pr.show();

    Map<String, dynamic>? queryParameters = { 'username': username, 'password': password};
    var response = await Dio().post(Api.baseUrl + "/api/v1/login", queryParameters: queryParameters );
    if(jsonDecode(response.toString())['error'] != null){
       print(response);
      Storage.saveUser(response.toString());
      await pr.hide();
      return true;
    }
  } catch (e) {
    debugPrint("error -- " + e.toString());
    print(e);
  }
  await pr.hide();
  return false;
}


