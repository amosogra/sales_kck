

class PDCKnockModel{

  String doctype;
  String dockey;
  String paidamount;
  String discountamount;
  String tempid;

  PDCKnockModel({
    required this.doctype,
    required this.dockey,
    required this.paidamount,
    required this.discountamount,
    required this.tempid
  });

  factory PDCKnockModel.fromMap(Map<String, dynamic> json) => PDCKnockModel(
    doctype: json["doctype"],
    dockey: json["dockey"],
    paidamount: json["paidamount"],
    discountamount: json["discountamount"],
    tempid: json["tempid"]
  );


  Map<String, dynamic> toMap() => {
    "doctype": doctype,
    "dockey": dockey,
    "paidamount" : paidamount,
    "discountamount" : discountamount,
    "tempid" : tempid
  };



}