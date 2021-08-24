


import 'package:sales_kck/model/post/UomModel.dart';

class ItemModel {

  int itemId;
  String companyCode;
  String code;
  String description;
  String taxType;
  int isActive;
  int rev;
  int deleted;
  List<UomModel> uom;

  ItemModel({
    required this.itemId,
    required this.companyCode,
    required this.code,
    required this.description,
    required this.taxType,
    required this.isActive,
    required this.rev,
    required this.deleted,
    required this.uom,
  });

  static List<UomModel> jsonToArray(uomJson){
    List<UomModel> uoms = [];
    for(var item in uomJson){
      UomModel uomModel = UomModel.fromMap(item);
      uoms.add(uomModel);
    }
    return uoms;
  }


  static List<Map<String, dynamic>> arrayToJson(List<UomModel> uoms){
    List<Map<String, dynamic>> uoms_str = [];
    for(var item in uoms){
      var res  = item.toMap();
      uoms_str.add(res);
    }
    return uoms_str;
  }


  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
    itemId: json["itemId"],
    companyCode: json["companyCode"],
    code: json["code"],
    description: json["description"],
    taxType: json["taxType"],
    isActive: json["isActive"],
    rev: json["rev"],
    deleted: json["deleted"],
    uom: jsonToArray(json["uom"]),
  );

  Map<String, dynamic> toMap() => {
    "itemId": itemId,
    "companyCode": companyCode,
    "code" : code,
    "description" : description,
    "taxType" : taxType,
    "isActive": isActive,
    "rev" : rev,
    "deleted" : deleted,
    "uom" : arrayToJson(uom),
  };

}