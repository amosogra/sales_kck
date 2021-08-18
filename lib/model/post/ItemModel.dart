


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

  static List<UomModel> parseData(uomJson){
    List<UomModel> uoms = [];
    for(var item in uomJson){
      UomModel uomModel = UomModel.fromMap(item);
      uoms.add(uomModel);
    }
    return uoms;
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
    uom: parseData(json["uom"]),
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
    "uom" : uom,
  };


}