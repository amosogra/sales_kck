
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:dio/dio.dart';

Future<bool> login( String username, String password) async {
  try {
    Map<String, dynamic>? queryParameters = { 'username': username, 'password': password};
    var response = await Dio().post(Api.baseUrl + "/api/v1/login", queryParameters: queryParameters );
    if(jsonDecode(response.toString())['error'] != null){
      print("error");
    }else{
      print(response);
      Storage.saveUser(response.toString());
      return true;
    }
  } catch (e) {
    print(e);
  }
  return false;
}

Future<bool> loginUser(BuildContext context, String email, String password) async {

  ProgressDialog pr;// = new ProgressDialog(context);
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try{
    pr.style(
        message: "Please wait..."
    );
    await pr.show();

    int userId = await Storage.getUserId();
    final response = await http.post(
      Uri.http(Api.baseUrl , '/api/v1/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:  jsonEncode(<String, String>{
        'username': email,
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      await pr.hide();
      if(jsonDecode(response.body)["results"] == 200){
        return true;
      }else if(jsonDecode(response.body)["results"] == 300){
      }else{
        return false;
      }
    } else {
      await pr.hide();
      //throw Exception('Failed to create album.');
      return false;
    }
  }on TimeoutException catch(_){
    debugPrint("log 1");
    await pr.hide();
    return false;
  }on Exception catch(_e){
    debugPrint(_e.toString());
    await pr.hide();
    return false;
  }
  return false;

}



Future<bool> forgotPassword(String email) async {

  var queryParameters = {
    'email': email.toString()
  };

  try{

    var uri =
    Uri.https(Api.baseUrl, '/uat/backoffice/api/resetPassword', queryParameters);

    final response = await http.get(
        uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    }
    );
    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      if(jsonRes["results"] == 200){
        return true;
      }
      return false;
    } else {
      //throw Exception('Failed to create album.');
      return false;
    }
  }on TimeoutException catch(_){
    return false;
  }on Exception catch(_){
    return false;
  }


}

