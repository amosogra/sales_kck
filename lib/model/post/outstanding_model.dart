

class OutstandingARS {
  String companyCode;
  String docType;
  int docKey;
  String docNo;
  String docDate;
  String outstandingAmount;
  String custAccNo;
  int cancelled;
  int deleted;

  OutstandingARS({
    required this.companyCode,
    required this.docType,
    required this.docKey,
    required this.docNo,
    required this.docDate,
    required this.outstandingAmount,
    required this.custAccNo,
    required this.cancelled,
    required this.deleted});


  factory OutstandingARS.fromMap(Map<String, dynamic> json) => OutstandingARS(
      companyCode: json['companyCode'],
      docType: json['docType'],
      docKey: json['docKey'],
      docNo: json['docNo'],
    docDate: json['docDate'],
    outstandingAmount: json['outstandingAmount'],
    custAccNo: json['custAccNo'],
    cancelled: json['cancelled'],
    deleted: json['deleted'],
  );

}