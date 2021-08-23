
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:dio/dio.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/TermModel.dart';

Future<List<ItemModel>> saveOrder(BuildContext context
    ,  CustomerModel customerModel
    ,  TermModel termModel
    ,  String remark1, String remark2, String remark3, String remark4
    ,  List<ItemModel> items
    ) async {

  ProgressDialog pr;// = new ProgressDialog(context);
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(
        message: "Please wait..."
    );
    await pr.show();

    String user = await Storage.getUser();
    String token = jsonDecode(user)['token'];

    Map<String, dynamic>? queryParameters = {
      'token': token,
      'companyCode': customerModel.companyCode,
      'custId' : customerModel.custId,
      'custAccNo' : customerModel.accNo,
      'custName' : customerModel.name,
      'docNo' : customerModel.docNumber,
      'docDate' : customerModel.docDate,
      'invAddr1': customerModel.addr1,
      'invAddr2': customerModel.addr2,
      'invAddr3': customerModel.addr3,
      'invAddr4': customerModel.addr4,
      'attention': customerModel.attention,
      'displayTerm': customerModel.defDisplayTerm,
      'inclusiveTax': customerModel.taxType,
      'remark1': remark1,
      'remark2': remark2,
      'remark3': remark3,
      'remark4': remark4,
      //'items':items.toString()
    };

    debugPrint(queryParameters.toString());

    var response = await Dio().post(Api.baseUrl + "/api/v1/createSalesOrder", queryParameters: queryParameters );

    List<ItemModel> items = [];
    final jsonRes = json.decode(response.toString());
    debugPrint(jsonRes);
    if(jsonRes['status']){
      for(var customerJson in jsonRes["items"]) {
        ItemModel customer = ItemModel.fromMap(customerJson);
        items.add(customer);
      }
      await pr.hide();
      return items;
    }else{
      await pr.hide();
      return [];
    }
  } catch (e) {
    print(e);
    await pr.hide();
    return [];
  }

  //await pr.hide();

}


