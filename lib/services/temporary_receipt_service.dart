
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftInvoiceDBHelper.dart';
import 'package:sales_kck/constants/app_storages.dart';
import 'package:dio/dio.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/model/post/CreateTempModel.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/PDCKnockModel.dart';
import 'package:sales_kck/model/post/PDCModel.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';
import 'package:sales_kck/model/post/TemporaryReceiptModel.dart';
import 'package:sales_kck/model/post/outstanding_model.dart';
import 'package:uuid/uuid.dart';

Future<String> saveTemporaryReceipt(BuildContext context
    ,  TempDraftModel tempDraftModel
    ,  String type) async {

  ProgressDialog pr;// = new ProgressDialog(context);
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(
        message: "Please wait..."
    );
    await pr.show();

    String user = await Storage.getUser();
    String token = jsonDecode(user)['token'];
    debugPrint("com code" + tempDraftModel.companyCode);
    Map<String, dynamic>? queryParameters = {
      'token': token,
      'companyCode': tempDraftModel.companyCode,
      //'items':items.toString()
    };

//    List<SoList> dataList = solists.map((i) => SoList.fromJson(i)).toList();
    var uuid = Uuid();

    TempDraftInvoiceDBHelper helper = new TempDraftInvoiceDBHelper();
    List<OutstandingARS> lists = await helper.retrieveTRInvoicesBySaved(tempDraftModel.id) as List<OutstandingARS>;


    var doc_number = tempDraftModel.receiptNo;

    List<PDCModel> flexpdclist = [];
    PDCModel pdcModel = new PDCModel(
        paymentmethod: tempDraftModel.paymentMethod, chequeno: tempDraftModel.chequeNo,
        paymentamount: tempDraftModel.paymentAmount, isrchq: "0",
        rchqdate: "",
        bankcharge: "0.00", tobankrate: "1.00", bankchargetaxcode: "", bankchargetax: "1.00",
        bankchargebillnogst: "", paymentby: "",
        bankchargetaxrate: "0.00", bankchargeprojno: "", tempid: "0");
    flexpdclist.add(pdcModel);

    List<PDCKnockModel> flexpdcknockofflist = [];
    for(var i = 0; i < lists.length; i++){
      PDCKnockModel pdcKnockModel = new PDCKnockModel(doctype: lists[i].docType,
          dockey: lists[i].docKey.toString(), paidamount: lists[i].outstandingAmount.toString(), discountamount: "0.00", tempid: "0");
      flexpdcknockofflist.add(pdcKnockModel);
    }
    String salesAgent = await Storage.getSalesAgent();

    CreateTempModel model = CreateTempModel(
        docno: doc_number.toString(),
        debtorcode: tempDraftModel.accNo,
        projectcode: "",
        departmentcode: "",
        currencycode: "MYR",
        description: "Test",
        secondreceiptno: "",
        salesagent: salesAgent,
        receiveddate: tempDraftModel.receiptDate,
        chequedate: tempDraftModel.paymentDate,
        flexpdclist: flexpdclist,
        flexpdcknockofflist: flexpdcknockofflist
    );

    Map<String, dynamic>? data =  {
      "docno": model.docno.toString(),
      "debtorcode": model.debtorcode.toString(),
      "projectcode" : model.projectcode.toString(),
      "departmentcode" : model.departmentcode.toString(),
      "currencycode" : model.currencycode.toString(),
      "description": model.description.toString(),
      "secondreceiptno" : model.secondreceiptno.toString(),
      "salesagent" : model.salesagent.toString(),
      "receiveddate" : model.receiveddate.toString(),
      "chequedate" : model.chequedate.toString(),
      "flexpdclist" : List<dynamic>.from(flexpdclist.map((x) => x.toMap() )),
      "flexpdcknockofflist" : List<dynamic>.from(flexpdcknockofflist.map((x) => x.toMap() ))
    };


    debugPrint(jsonEncode(data));

    if(type.endsWith("draft")){
      await pr.hide();
      return "false";
    }else{
      debugPrint("api call");
      var response = await Dio().post(Api.baseUrl + "/api/v1/createTemporaryReceipt",
          queryParameters: queryParameters,
          data: jsonEncode(data),
          options: Options(headers: {"Content-Type":"application/json"})
      );

      final jsonRes = json.decode(response.toString());
      //
      debugPrint(response.toString());
      //
      if(jsonRes['result']){
        await pr.hide();
        return "true";
      }else{

        await pr.hide();
        return response.toString();
      }

      await pr.hide();
      return "false";
    }

  } catch (e) {
    print(e);
    await pr.hide();
    return "false";
  }
}

Future<List<TemporaryReceiptModel>> getTemporaryReceipt(BuildContext context , String accNo) async {

  ProgressDialog pr;// = new ProgressDialog(context);
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(
        message: "Please wait..."
    );
    await pr.show();
    String user = await Storage.getUser();
    String token = jsonDecode(user)['token'];
    String company = await Storage.getCompany();

    Map<String, dynamic>? queryParameters = { 'token': token , 'companyCode':company , 'accNo' : accNo };
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





