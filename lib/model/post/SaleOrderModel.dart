

class SaleOrderModel{

  int soId;
  String companyCode;
  String custAccNo;
  String custName;
  String docNo;
  String docDate;
  String invAddr1;
  String invAddr2;
  String invAddr3;
  String invAddr4;
  String branchCode;
  String salesLocation;
  String shipVia;
  String shipInfo;
  String attention;
  String displayTerm;
  String salesAgent;
  int inclusiveTax;
  String subtotalAmt;
  String taxAmt;
  String totalAmt;
  String remark1;
  String remark2;
  String remark3;
  String remark4;
  int cancelled;
  int rev;
  int deleted;

  SaleOrderModel({
    required this.soId,
    required this.companyCode,
    required this.custAccNo,
    required this.custName,
    required this.docNo,
    required this.docDate,
    required this.invAddr1,
    required this.invAddr2,
    required this.invAddr3,
    required this.invAddr4,
    required this.branchCode,
    required this.salesLocation,
    required this.shipVia,
    required this.shipInfo,
    required this.attention,
    required this.displayTerm,
    required this.salesAgent,
    required this.inclusiveTax,
    required this.subtotalAmt,
    required this.taxAmt,
    required this.totalAmt,
    required this.remark1,
    required this.remark2,
    required this.remark3,
    required this.remark4,
    required this.cancelled,
    required this.rev,
    required this.deleted,
  });

  factory SaleOrderModel.fromMap(Map<String, dynamic> json) => SaleOrderModel(
    soId: json["soId"],
    companyCode: json["companyCode"],
    custAccNo: json["custAccNo"],
    custName: json["custName"],
    docNo: json["docNo"],
    docDate: json["docDate"],
    invAddr1: json["invAddr1"],
    invAddr2: json["invAddr2"],
    invAddr3: json["invAddr3"],
    invAddr4: json["invAddr4"],
    branchCode: json["branchCode"],
    salesLocation: json["salesLocation"],
    shipVia: json["shipVia"],
    shipInfo: json["shipInfo"],
    attention: json["attention"],
    displayTerm: json["displayTerm"],
    salesAgent: json["salesAgent"],
    inclusiveTax: json["inclusiveTax"],
    subtotalAmt: json["subtotalAmt"],
    taxAmt: json["taxAmt"],
    totalAmt: json["totalAmt"],
    remark1: json["remark1"],
    remark2: json["remark2"],
    remark3: json["remark3"],
    remark4: json["remark4"],
    cancelled: json["cancelled"],
    rev: json["rev"],
    deleted: json["deleted"]
  );
  Map<String, dynamic> toMap() => {
    "soId": soId,
    "companyCode": companyCode,
    "custAccNo" : custAccNo,
    "custName" : custName,
    "docNo" : docNo,
    "docDate": docDate,
    "invAddr1" : invAddr1,
    "invAddr2" : invAddr2,
    "invAddr3" : invAddr3,
    "invAddr4" : invAddr4,
    "branchCode" : branchCode,
    "salesLocation" : salesLocation,
    "shipVia" : shipVia,
    "shipInfo" : shipInfo,
    "attention" : attention,
    "displayTerm" : displayTerm,
    "salesAgent" : salesAgent,
    "inclusiveTax" : inclusiveTax,
    "subtotalAmt" : subtotalAmt,
    "taxAmt" : taxAmt,
    "totalAmt" : totalAmt,
    "remark1" : remark1,
    "remark2" : remark2,
    "remark3" : remark3,
    "remark4" : remark4,
    "cancelled" : cancelled,
    "rev" : rev,
    "deleted" : deleted,
  };

}