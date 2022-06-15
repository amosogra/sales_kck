

import 'package:sales_kck/model/post/PDCKnockModel.dart';
import 'package:sales_kck/model/post/PDCModel.dart';

class CreateTempModel{

  String docno;
  String debtorcode;
  String projectcode;
  String departmentcode;
  String currencycode;
  String description;
  String secondreceiptno;
  String salesagent;
  String receiveddate;
  String chequedate;
  List<PDCModel> flexpdclist;
  List<PDCKnockModel> flexpdcknockofflist;

  CreateTempModel({
    required this.docno,
    required this.debtorcode,
    required this.projectcode,
    required this.departmentcode,
    required this.currencycode,
    required this.description,
    required this.secondreceiptno,
    required this.salesagent,
    required this.receiveddate,
    required this.chequedate,
    required this.flexpdclist,
    required this.flexpdcknockofflist
  });

  factory CreateTempModel.fromMap(Map<String, dynamic> json) => CreateTempModel(
      docno: json["docno"],
      debtorcode: json["debtorcode"],
      projectcode: json["projectcode"],
      departmentcode: json["departmentcode"],
      currencycode: json["currencycode"],
      description: json["description"],
      secondreceiptno: json["secondreceiptno"],
      salesagent: json["salesagent"],
      receiveddate: json["receiveddate"],
      chequedate: json["chequedate"],
      flexpdclist: json["flexpdclist"],
      flexpdcknockofflist: json["flexpdcknockofflist"]
  );

  //List<dynamic>.from(solists.map((x) => x.toMap() ))
  Map<String, dynamic> toMap() => {
    "docno": docno.toString(),
    "debtorcode": debtorcode.toString(),
    "projectcode" : projectcode.toString(),
    "departmentcode" : departmentcode.toString(),
    "currencycode" : currencycode.toString(),
    "description": description.toString(),
    "secondreceiptno" : secondreceiptno.toString(),
    "salesagent" : salesagent.toString(),
    "receiveddate" : receiveddate.toString(),
    "chequedate" : chequedate.toString(),
    "flexpdclist" : List<dynamic>.from(flexpdclist.map((x) => x.toMap() )),
    "flexpdcknockofflist" : List<dynamic>.from(flexpdcknockofflist.map((x) => x.toMap() ))
  };



}