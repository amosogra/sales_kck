class CompanyModel {
  int id;
  String title;
  String code;
  String salesAgent;
  String? sysType, displayName, address, phone, fax, email, website, lbbNo, gstRegNo, additionalInfo;

  CompanyModel({
    required this.id,
    required this.title,
    required this.code,
    required this.salesAgent,
    this.sysType,
    this.displayName,
    this.address,
    this.phone,
    this.fax,
    this.email,
    this.website,
    this.lbbNo,
    this.gstRegNo,
    this.additionalInfo,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json["id"],
        title: json["name"],
        code: json["code"],
        salesAgent: json['salesAgent'],
        sysType: json["sysType"],
        displayName: json["displayName"],
        address: json["address"],
        phone: json["phone"],
        fax: json["fax"],
        email: json["email"],
        website: json["website"],
        lbbNo: json["lbbNo"],
        gstRegNo: json["gstRegNo"],
        additionalInfo: json["additionalInfo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": title,
        "code": code,
        "salesAgent": salesAgent,
        "sysType": sysType,
        "displayName": displayName,
        "address": address,
        "phone": phone,
        "fax": fax,
        "email": email,
        "website": website,
        "lbbNo": lbbNo,
        "gstRegNo": gstRegNo,
        "additionalInfo": additionalInfo,
      };
}
