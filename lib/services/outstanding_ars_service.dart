import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/app_storages.dart';
import 'package:sales_kck/model/post/outstanding_model.dart';

Future<List<OutstandingARS>> getOutstanding(BuildContext context, String accNo) async {
  ProgressDialog pr; // = new ProgressDialog(context);
  pr = new ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(message: "Please wait...");
    await pr.show();

    String user = await Storage.getUser();
    String token = jsonDecode(user)['token'];
    String companyCode = await Storage.getCompany();
    var getSalesAgent = await Storage.getSalesAgent();
    var cmodel = await Storage.getCompanyModel();
    debugPrint("my token = " + token);
    debugPrint("company code = " + companyCode);
    debugPrint("accNo code = " + accNo);
    debugPrint("getSalesAgent: $getSalesAgent");
    debugPrint("******user******:\n$user");
    debugPrint("+++++++++++++company model+++++++++++++:\n${cmodel.toJson()}");

    Map<String, dynamic>? queryParameters = {'token': token, 'companyCode': companyCode, "accNo": accNo};
    var response = await Dio().post(Api.baseUrl + "/api/v1/outstandingARs", queryParameters: queryParameters);
    List<OutstandingARS> outs = [];
    final jsonRes = json.decode(response.toString());
    debugPrint("---------");
    debugPrint(response.toString());

    if (jsonRes['result']) {
      for (var customerJson in jsonRes["outstandingARs"]) {
        OutstandingARS item = OutstandingARS.fromMap(customerJson);
        outs.add(item);
      }

      await pr.hide();
      return outs;
    } else {
      await pr.hide();
      return [];
    }
  } catch (e) {
    debugPrint("error -- " + e.toString());
    print(e);
    await pr.hide();
    return [];
  }
}
