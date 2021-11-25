

class PDCModel{

  String paymentmethod;
  String chequeno;
  String paymentamount;
  String isrchq;
  String rchqdate;
  String bankcharge;
  String tobankrate;
  String bankchargetaxcode;
  String bankchargetax;
  String bankchargebillnogst;
  String paymentby;
  String bankchargetaxrate;
  String bankchargeprojno;
  String tempid;

  PDCModel({
    required this.paymentmethod,
    required this.chequeno,
    required this.paymentamount,
    required this.isrchq,
    required this.rchqdate,
    required this.bankcharge,
    required this.tobankrate,
    required this.bankchargetaxcode,
    required this.bankchargetax,
    required this.bankchargebillnogst,
    required this.paymentby,
    required this.bankchargetaxrate,
    required this.bankchargeprojno,
    required this.tempid
  });

  factory PDCModel.fromMap(Map<String, dynamic> json) => PDCModel(
      paymentmethod: json["paymentmethod"],
      chequeno: json["chequeno"],
      paymentamount: json["paymentamount"],
      isrchq: json["isrchq"],
      rchqdate: json["rchqdate"],
      bankcharge: json["bankcharge"],
      tobankrate: json["tobankrate"],
      bankchargetaxcode: json["bankchargetaxcode"],
      bankchargetax: json["bankchargetax"],
      bankchargebillnogst: json["bankchargebillnogst"],
      paymentby: json["paymentby"],
      bankchargetaxrate: json["bankchargetaxrate"],
      bankchargeprojno: json["bankchargeprojno"],
      tempid: json["tempid"],
  );


  Map<String, dynamic> toMap() => {
    "paymentmethod": paymentmethod,
    "chequeno": chequeno,
    "paymentamount" : paymentamount,
    "isrchq" : isrchq,
    "rchqdate" : rchqdate,
    "bankcharge": bankcharge,
    "tobankrate" : tobankrate,
    "bankchargetaxcode" : bankchargetaxcode,
    "bankchargetax" : bankchargetax,
    "bankchargebillnogst" : bankchargebillnogst,
    "paymentby" : paymentby,
    "bankchargetaxrate" : bankchargetaxrate,
    "bankchargeprojno" : bankchargeprojno,
    "tempid" : tempid
  };



}