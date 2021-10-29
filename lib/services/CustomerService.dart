
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:dio/dio.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';

Future<List<CustomerModel>> getCustomers(BuildContext context) async {

  ProgressDialog pr;// = new ProgressDialog(context);
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(
        message: "Please wait..."
    );
    await pr.show();

    String user = await Storage.getUser();
    String token = jsonDecode(user)['token'];

    debugPrint("my token"+  token);

    Map<String, dynamic>? queryParameters = { 'token': token };
    var response = await Dio().post(Api.baseUrl + "/api/v1/customers", queryParameters: queryParameters );
    List<CustomerModel> customers = [];

    debugPrint(response.toString());

    final jsonRes = json.decode(response.toString());
    if(jsonRes['result']){

      debugPrint("called");
      for(var customerJson in jsonRes["customers"]) {
        CustomerModel customer = CustomerModel.fromMap(customerJson);
        customers.add(customer);
      }
      await pr.hide();
      debugPrint(customers.length.toString());
      return customers;
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


