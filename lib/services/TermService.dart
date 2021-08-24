
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:dio/dio.dart';
import 'package:sales_kck/model/post/TermModel.dart';

Future<List<TermModel>> getTerms(BuildContext context, String companyCode, ) async {

  ProgressDialog pr;// = new ProgressDialog(context);
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(
        message: "Please wait..."
    );
    await pr.show();

    String user = await Storage.getUser();
    String token = jsonDecode(user)['token'];
    Map<String, dynamic>? queryParameters = { 'token': token }; //'companyCode' : companyCode, 'fromTS' : 'fromTS'

    debugPrint(queryParameters.toString());
    var response = await Dio().post(Api.baseUrl + "/api/v1/terms", queryParameters: queryParameters );
    debugPrint(response.toString());
    List<TermModel> items = [];
    final jsonRes = json.decode(response.toString());
    if(jsonRes['status']){
      for(var termsJson in jsonRes["terms"]) {
        TermModel termModel = TermModel.fromMap(termsJson);
        items.add(termModel);
      }
      await pr.hide();
      return items;

    }else{
      await pr.hide();
      return [];
    }
  } catch (e) {
    debugPrint("error -- " + e.toString());
    print(e);
    await pr.hide();
    return [];
  }

  //await pr.hide();

}


