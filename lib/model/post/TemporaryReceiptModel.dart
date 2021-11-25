

class TemporaryReceiptModel{

  int trId;
  String companyCode;
  String trNo;
  String custAccNo;
  int cancelled;
  int deleted;
  String salesAgent;
  String chequeNo;
  String paymentMethod;
  String paymentAmount;

  TemporaryReceiptModel({
    required this.trId,
    required this.companyCode,
    required this.trNo,
    required this.custAccNo,
    required this.cancelled,
    required this.deleted,
    required this.salesAgent,
    required this.chequeNo,
    required this.paymentMethod,
    required this.paymentAmount
  });

  factory TemporaryReceiptModel.fromMap(Map<String, dynamic> json) => TemporaryReceiptModel(
    trId: json["trId"],
    companyCode: json["companyCode"],
    trNo: json["trNo"],
      custAccNo: json["custAccNo"],
      cancelled: json["cancelled"],
      deleted: json["deleted"],
      salesAgent: json["salesAgent"],
      chequeNo: json["chequeNo"],
      paymentMethod: json["paymentMethod"],
      paymentAmount: json["paymentAmount"]
  );

  factory TemporaryReceiptModel.fromDBMap(Map<String, dynamic> json) => TemporaryReceiptModel(
      trId: json["trId"],
      companyCode: json["companyCode"],
      trNo: json["trNo"],
      custAccNo: json["custAccNo"],
      cancelled: json["cancelled"],
      deleted: json["deleted"],
      salesAgent: json["salesAgent"],
      chequeNo: json["chequeNo"],
      paymentMethod: json["paymentMethod"],
      paymentAmount: json["paymentAmount"]
  );


  Map<String, dynamic> toMap() => {
    "trId": trId,
    "companyCode": companyCode,
    "trNo" : trNo,
    "custAccNo" : custAccNo,
    "cancelled" : cancelled,
    "deleted": deleted,
    "salesAgent" : salesAgent,
    "chequeNo" : chequeNo,
    "paymentMethod" : paymentMethod,
    "paymentAmount" : paymentAmount
  };



}