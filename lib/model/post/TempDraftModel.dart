

class TempDraftModel{

  int id;
  String receiptNo;
  String receiptFrom;
  String receiptDate;
  String paymentDate;
  String paymentMethod;
  String chequeNo;
  String paymentAmount;
  String isSaved;
  bool isTap;

  TempDraftModel({
    required this.id,
    required this.receiptNo,
    required this.receiptFrom,
    required this.receiptDate,
    required this.paymentDate,
    required this.paymentMethod,
    required this.chequeNo,
    required this.paymentAmount,
    required this.isSaved,
    this.isTap = false,
  });

  factory TempDraftModel.fromMap(Map<String, dynamic> json) => TempDraftModel(
      id: json["id"],
      receiptNo: json["receipt_no"],
      receiptFrom: json["receipt_from"],
      receiptDate: json["receipt_date"],
      paymentDate: json["payment_date"],
      paymentMethod: json["payment_method"],
      chequeNo: json["cheque_no"],
      paymentAmount: json["payment_amount"],
      isSaved: json["isSaved"]
  );

  factory TempDraftModel.fromDBMap(Map<String, dynamic> json) => TempDraftModel(
      id: json["id"],
      receiptNo: json["receipt_no"],
      receiptFrom: json["receipt_from"],
      receiptDate: json["receipt_date"],
      paymentDate: json["payment_date"],
      paymentMethod: json["payment_method"],
      chequeNo: json["cheque_no"],
      paymentAmount: json["payment_amount"],
      isSaved: json["isSaved"],
      isTap: false
  );

  Map<String, dynamic> toMap() => {
    "receipt_no": receiptNo,
    "receipt_from": receiptFrom,
    "receipt_date" : receiptDate,
    "payment_date" : paymentDate,
    "payment_method" : paymentMethod,
    "cheque_no": chequeNo,
    "payment_amount" : paymentAmount,
    "isSaved" : isSaved
  };

}