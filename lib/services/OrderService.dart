
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:dio/dio.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/model/post/SoList.dart';
import 'package:sales_kck/model/post/TermModel.dart';
import 'package:uuid/uuid.dart';

Future<bool> saveOrder(BuildContext context
    ,  CustomerModel customerModel
    ,  TermModel termModel
    ,  String remark1, String remark2, String remark3, String remark4
    ,  List<ItemModel> itemModels
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
      //'items':items.toString()
    };

    List<SoList> solists = <SoList>[];
    for(var item in itemModels){
      SoList so = SoList(itemcode: "FM-INDIAN(BULK)-MT", location: "HQ", description: item.description, furtherdescription: item.description,
          uom: "MT" , rate: "1.0000000", qty: "150.0000000", focqty: item.rev, smallestunitprice: item.uom[0].price,
          unitprice: item.uom[0].price, discount: item.uom[0].price, discountamt: item.rev, taxtype: item.companyCode, taxrate: item.rev, tempid: item.itemId
      ) ;
      solists.add(so);
    }
//    List<SoList> dataList = solists.map((i) => SoList.fromJson(i)).toList();
    var uuid = Uuid();
    Map<String, dynamic>? data = {
      "docno":uuid.v4().substring(0,10).toString(),
      "docdate":"2021-10-27",
      "debtorcode":customerModel.accNo,
      "debtorname":customerModel.name,
      "invadd1":customerModel.addr1,
      "invadd2":customerModel.addr2,
      "invadd3":customerModel.addr3,
      "invadd4":customerModel.addr4,
      "branchcode":customerModel.companyCode,
      "saleslocation":"HQ",
      "displayterm":termModel.displayTerm,
      "inclusivetax":0,
      "salesagent":"SOON (F)",
      "remark1":remark1,
      "remark2":remark2,
      "remark3":remark3,
      "remark4":remark4,
      "shipvia":"",
      "shipinfo":"",
      "so_pac_list":[],
      "solist": List<dynamic>.from(solists.map((x) => x.toMap() )),
      //'items':items.toString()
    };

    debugPrint(jsonEncode(data));

    var response = await Dio().post(Api.baseUrl + "/api/v1/createSalesOrder",
        queryParameters: queryParameters,
      data: data,
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
  } catch (e) {
    debugPrint("error -- " + e.toString());
    print(e);
    await pr.hide();
    return [];
  }

  //await pr.hide();

}





