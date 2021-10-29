class CustomerModel {

  int custId;
  String  companyCode;
  String  accNo;
  String  name;
  String  docNumber = '';
  String  docDate = '';
  String  addr1;
  String  addr2;
  String  addr3;
  String  addr4;
  String  attention;
  String  defDisplayTerm;
  String  taxType;
  String  phone1;
  String  phone2;
  int  isActive;
  int  rev;
  int  deleted;

  CustomerModel({required this.custId,
    required this.companyCode,
    required this.accNo,
    required this.name,
    required this.addr1,
    required this.addr2,
    required this.addr3,
    required this.addr4,
    required this.attention,
    required this.defDisplayTerm,
    required this.taxType,
    required this.phone1,
    required this.phone2,
    required this.isActive,
    required this.rev,
    required this.deleted,

  });

  factory CustomerModel.fromMap(Map<String, dynamic> json) => CustomerModel(
    custId: json["custId"],
      accNo: json["accNo"],
      name: json["name"],
      addr1: json["addr1"],
      addr2: json["addr2"],
      addr3: json["addr3"],
      addr4: json["addr4"],
      attention: json["attention"],
      defDisplayTerm: json["defDisplayTerm"],
      taxType: json["taxType"],
      phone1: json["phone1"],
      phone2: json["phone2"],
      isActive: json["isActive" ],
      rev: json["rev"],
      deleted: json["deleted"],
      companyCode: json['companyCode'],
  );

  Map<String, dynamic> toMap() => {
    "custId": custId,
    "companyCode": companyCode,
    "accNo": accNo,
    "name" : name,
    "addr1" : addr1,
    "addr2" : addr2,
    "addr3" : addr3,
    "addr4" : addr4,
    "attention" : attention,
    "defDisplayTerm" : defDisplayTerm,
    "taxType" : taxType,
    "phone1" : phone1,
    "phone2" : phone2,
    "isActive" : isActive,
    "rev" : rev,
    "deleted" : deleted

  };


}