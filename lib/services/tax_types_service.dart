
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/app_storages.dart';
import 'package:dio/dio.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/tax_types_model.dart';

Future<List<TaxTypes>> getTaxTypes(BuildContext context) async {

  ProgressDialog pr;// = new ProgressDialog(context);
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(
        message: "Please wait..."
    );
    await pr.show();

    String user = await Storage.getUser();
    String token = jsonDecode(user)['token'];
    String companyCode = await Storage.getCompany();
    debugPrint("my token"+  token);

    Map<String, dynamic>? queryParameters = { 'token': token , 'companyCode' : companyCode };
    var response = await Dio().post(Api.baseUrl + "/api/v1/taxTypes", queryParameters: queryParameters );
    List<TaxTypes> taxTypes = [];

    final jsonRes = json.decode(response.toString());
    debugPrint( response.toString());

    if(jsonRes['result']){

      await pr.hide();

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

  return [];
  //await pr.hide();

}


