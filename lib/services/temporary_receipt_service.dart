
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/app_storages.dart';
import 'package:dio/dio.dart';
import 'package:sales_kck/model/post/CreateTempModel.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/PDCKnockModel.dart';
import 'package:sales_kck/model/post/PDCModel.dart';
import 'package:sales_kck/model/post/TemporaryReceiptModel.dart';
import 'package:uuid/uuid.dart';

Future<bool> saveTemporaryReceipt(BuildContext context
    ,  CustomerModel customerModel
    ,  String receiveDate, String chequeDate , String type) async {

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
      //'items':items.toString()
    };

//    List<SoList> dataList = solists.map((i) => SoList.fromJson(i)).toList();
    var uuid = Uuid();
    var doc_number = customerModel.docNumber;

    List<PDCModel> flexpdclist = [];
    List<PDCKnockModel> flexpdcknockofflist = [];

  CreateTempModel model = CreateTempModel(
        docno: doc_number,
        debtorcode: "300L/001",
        projectcode: "",
        departmentcode: "",
        currencycode: "MYR",
        description: "Test",
        secondreceiptno: "",
        salesagent: "SOON (F)",
        receiveddate: receiveDate,
        chequedate: chequeDate,
        flexpdclist: flexpdclist,
        flexpdcknockofflist: flexpdcknockofflist
    );

    if(type.endsWith("draft")){

      await pr.hide();
      return false;

    }else{
      var response = await Dio().post(Api.baseUrl + "/api/v1/createTemporaryReceipt",
          queryParameters: queryParameters,
          data: model.toMap(),
          options: Options(headers: {"Content-Type":"application/json"})
      );

      List<ItemModel> items = [];
      final jsonRes = json.decode(response.toString());
      debugPrint(jsonRes);
      if(jsonRes['result']){
        await pr.hide();
        return true;
      }else{
        await pr.hide();
        return false;
      }
    }

  } catch (e) {
    print(e);
    await pr.hide();
    return false;
  }
}

Future<List<TemporaryReceiptModel>> getTemporaryReceipt(BuildContext context) async {

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
    var response = await Dio().post(Api.baseUrl + "/api/v1/temporaryReceipts", queryParameters: queryParameters );
    debugPrint(response.toString());
    List<TemporaryReceiptModel> lists = [];
    final jsonRes = json.decode(response.toString());

    if(jsonRes['result']){
      for(var saleOrder in jsonRes["tempReceipts"]) {
        TemporaryReceiptModel model = TemporaryReceiptModel.fromMap(saleOrder);
        lists.add(model);
      }
      await pr.hide();
      return lists;

    }else{
      await pr.hide();
      return [];
    }
  //
  } catch (e) {
    debugPrint("error -- " + e.toString());
    print(e);
    await pr.hide();
    return [];
  }

  //await pr.hide();

}





