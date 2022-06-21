
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/DBHelper/ItemDBHelper.dart';
import 'package:sales_kck/constants/DBHelper/OrderDBHelper.dart';
import 'package:sales_kck/constants/app_storages.dart';
import 'package:dio/dio.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/model/post/SoList.dart';
import 'package:sales_kck/model/post/TermModel.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

Future<bool> saveOrder(BuildContext context
    ,  CustomerModel customerModel
    ,  TermModel termModel
    ,  String remark1, String remark2, String remark3, String remark4
    ,  List<ItemModel> itemModels
    ,  String totalPrice
    , String type
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
    String salesAgent = await Storage.getSalesAgent();
    debugPrint("token " + token);

    Map<String, dynamic>? queryParameters = {
      'token': token,
      'companyCode': customerModel.companyCode,
      //'items':items.toString()
    };

    List<SoList> solists = <SoList>[];
    for(var item in itemModels){
      SoList so = SoList(itemcode: item.code, location: "HQ", description: item.description, furtherdescription: "",
          uom: item.uom[0].uom , rate: "1.0000000", qty: item.qty.toString(), focqty: "0", smallestunitprice: item.uom[0].price,
          unitprice: item.uom[0].price, discount: "", discountamt: "0", taxtype: "",
          taxrate: "0", tempid: "0",
          orderId: 0
      ) ;
      solists.add(so);
    }

    var uuid = Uuid();
    var doc_number = customerModel.docNumber;// + uuid.v4().toString().substring(0,4);
    termModel.displayTerm = "CASH";
    Map<String, dynamic>? data = {
      "docno":doc_number,
      "docdate":customerModel.docDate,
      "debtorcode":customerModel.accNo,
      "debtorname":customerModel.name,
      "invadd1":customerModel.addr1,
      "invadd2":customerModel.addr2,
      "invadd3":customerModel.addr3,
      "invadd4":customerModel.addr4,
      "branchcode":"",
      "saleslocation":"",
      "displayterm":termModel.displayTerm,
      "inclusivetax":0,
      "salesagent": salesAgent, //SOON (F)
      "remark1":remark1,
      "remark2":remark2,
      "remark3":remark3,
      "remark4":remark4,
      "shipvia":"",
      "shipinfo":"",
      "so_pac_list":[],
      "solist": List<dynamic>.from(solists.map((x) => x.toMap() ))
    };
    debugPrint(jsonEncode(data));

    String sync = "1";
    if(type.endsWith("draft")){
      sync = "0";
    }

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);

      SaleOrderModel saleOrderModel = new SaleOrderModel(soId: 0, companyCode: customerModel.companyCode, custAccNo: customerModel.accNo, custName: customerModel.name,
          docNo: doc_number, docDate: formattedDate , invAddr1: customerModel.addr1, invAddr2: customerModel.addr2, invAddr3: customerModel.addr3, invAddr4: customerModel.addr4,
          branchCode: customerModel.companyCode, salesLocation: "", shipVia: "", shipInfo: "", attention: "attention",
          displayTerm: termModel.displayTerm , salesAgent: salesAgent , inclusiveTax: 0, subtotalAmt: "0", taxAmt: "0", totalAmt: totalPrice,
          remark1: remark1, remark2: remark2, remark3: remark3, remark4: remark4,
          cancelled: 0, rev: 0, deleted: 0 , synced: sync);

      List<SaleOrderModel> saleOrders = <SaleOrderModel>[];
      saleOrders.add(saleOrderModel);

      OrderDBHelper orderDBHelper = new OrderDBHelper();
      int  insertedId = await orderDBHelper.insertOrders(saleOrders);
      ItemDBHelper itemDBHelper = new  ItemDBHelper();
      for(var item in solists){
        item.orderId = int.parse(insertedId.toString());
      }

      itemDBHelper.insertItems(solists);
      if(type.endsWith("draft")){
        await pr.hide();
        return false;
      }


      debugPrint(jsonEncode(data));
      var response = await Dio().post(Api.baseUrl + "/api/v1/createSalesOrder",
          queryParameters: queryParameters,
          data: jsonEncode(data),
          options: Options(
              headers: {
                'Content-Type': 'application/json;charset=UTF-8',
                'Charset': 'utf-8'
              },
            followRedirects: false,
            validateStatus: (status) => true,
            responseType: ResponseType.json,
            receiveTimeout: 10000,
            sendTimeout: 10000
              )
      );

      List<ItemModel> items = [];
      final jsonRes = json.decode(response.toString());

      if(jsonRes['result']){
        await pr.hide();
        return true;
      }else{
        await pr.hide();
        showToastMessage(context, jsonRes['error'], "Ok");
        return false;
      }


  } catch (e) {
    print(e);
    await pr.hide();
    return false;
  }
}


Future<List<SaleOrderModel>> getSaleOrders(BuildContext context) async {

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
    var response = await Dio().post(Api.baseUrl + "/api/v1/salesOrders", queryParameters: queryParameters );
    debugPrint(response.toString());
    List<SaleOrderModel> saleOrderLists = [];
    final jsonRes = json.decode(response.toString());

    if(jsonRes['result']){
      for(var saleOrder in jsonRes["salesOrders"]) {
        SaleOrderModel saleOrderModel = SaleOrderModel.fromMap(saleOrder);
        saleOrderLists.add(saleOrderModel);
      }
      await pr.hide();
      return saleOrderLists;

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

Future<bool> syncOrder(BuildContext context
    ,  SaleOrderModel saleOrderModel
    ,  List<SoList> itemModels
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
    String salesAgent = await Storage.getSalesAgent();

    Map<String, dynamic>? queryParameters = {
      'token': token,
      'companyCode': saleOrderModel.companyCode,
    };

    List<SoList> solists = <SoList>[];for(var item in itemModels){
      SoList so = SoList(itemcode: item.itemcode, location: "", description: item.description, furtherdescription: "",
          uom: item.uom , rate: item.rate.toString(), qty: item.qty.toString(), focqty: "0", smallestunitprice: item.smallestunitprice,
          unitprice: item.unitprice, discount: "", discountamt: "0", taxtype: item.taxtype,
          taxrate: "0", tempid: "0",
          orderId: 0
      );
      solists.add(so);
    }

    var uuid = Uuid();
    var doc_number = saleOrderModel.docNo + uuid.v4().toString().substring(0,4);
    saleOrderModel.displayTerm = "CASH";
    Map<String, dynamic>? data = {
      "docno":doc_number,
      "docdate":saleOrderModel.docDate,
      "debtorcode":saleOrderModel.custAccNo,
      "debtorname":saleOrderModel.custName,
      "invadd1":saleOrderModel.invAddr1,
      "invadd2":saleOrderModel.invAddr2,
      "invadd3":saleOrderModel.invAddr3,
      "invadd4":saleOrderModel.invAddr4,
      "branchcode":"",
      "saleslocation":"",
      "displayterm":saleOrderModel.displayTerm,
      "inclusivetax":0,
      "salesagent": salesAgent, //SOON (F)
      "remark1":saleOrderModel.remark1,
      "remark2":saleOrderModel.remark2,
      "remark3":saleOrderModel.remark3,
      "remark4":saleOrderModel.remark4,
      "shipvia":"",
      "shipinfo":"",
      "so_pac_list":[],
      "solist": List<dynamic>.from(solists.map((x) => x.toMap() ))
      //'items':items.toString()
    };

    debugPrint(jsonEncode(data));

    var response = await Dio().post(Api.baseUrl + "/api/v1/createSalesOrder",
        queryParameters: queryParameters,
        data: data,
        options: Options(
            headers: {
              'Content-Type': 'application/json;charset=UTF-8',
              'Charset': 'utf-8'
            },
            followRedirects: false,
            validateStatus: (status) => true,
            responseType: ResponseType.json,
            receiveTimeout: 10000,
            sendTimeout: 10000
        )
    );

    List<ItemModel> items = [];
    final jsonRes = json.decode(response.toString());

    if(jsonRes['result']){
      await pr.hide();
      return true;
    }else{
      await pr.hide();
      showToastMessage(context, jsonRes['error'], "Ok");
      return false;
    }

  } catch (e) {
    print(e);
    await pr.hide();
    return false;
  }
}






