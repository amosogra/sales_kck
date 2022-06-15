

class OutstandingARS {
  String companyCode;
  String docType;
  String docKey;
  String docNo;
  String docDate;
  String outstandingAmount;
  String custAccNo;
  String cancelled;
  String deleted;
  bool isSelected;
  String trId;

  OutstandingARS({
    required this.companyCode,
    required this.docType,
    required this.docKey,
    required this.docNo,
    required this.docDate,
    required this.outstandingAmount,
    required this.custAccNo,
    required this.cancelled,
    required this.deleted,
    required this.isSelected,
    required this.trId
  });

  factory OutstandingARS.fromMap(Map<String, dynamic> json) => OutstandingARS(
      companyCode: json['companyCode'].toString(),
      docType: json['docType'].toString(),
      docKey: json['docKey'].toString(),
      docNo: json['docNo'].toString(),
      docDate: json['docDate'].toString(),
      outstandingAmount: json['outstandingAmount'].toString(),
      custAccNo: json['custAccNo'].toString(),
      cancelled: json['cancelled'].toString(),
      deleted: json['deleted'].toString(),
      isSelected: false,
      trId: json["trId"].toString(),
  );


  Map<String, dynamic> toMap() => {
    "companyCode": companyCode,
    "docType": docType,
    "docKey": docKey,
    "docNo": docNo,
    "docDate" : docDate,
    "outstandingAmount" : outstandingAmount,
    "custAccNo" : custAccNo,
    "cancelled": cancelled,
    "deleted" : deleted,
    "trId" : trId
  };


}