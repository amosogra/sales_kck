
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:dio/dio.dart';
import 'package:sales_kck/model/post/ItemModel.dart';

Future<List<ItemModel>> getItems(BuildContext context) async {

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
    var response = await Dio().post(Api.baseUrl + "/api/v1/items", queryParameters: queryParameters );

    debugPrint(response.toString());

    List<ItemModel> items = [];
    final jsonRes = json.decode(response.toString());
    if(jsonRes['status']){
      debugPrint("called");
      for(var customerJson in jsonRes["items"]) {
        ItemModel customer = ItemModel.fromMap(customerJson);
        items.add(customer);
      }
      await pr.hide();
      debugPrint(items.length.toString());
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


