
class CompanyModel {
  int id;
  String title;
  String code;
  String salesAgent;

  CompanyModel({
    required this.id,
    required this.title,
    required this.code,
    required this.salesAgent
  });

  factory CompanyModel.fromMap(Map<String, dynamic> json) => CompanyModel(
      id: json["id"],
      title: json["name"],
      code: json["code"],
      salesAgent: json['salesAgent']
  );



}