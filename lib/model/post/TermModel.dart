


class TermModel {

  //
  // const TermModel(this.name, this.code);
  // final String code;
  // final String name;
  //
  // @override
  // String toString() => name;
  //
  // factory TermModel.fromMap(Map<String, dynamic> json) => TermModel(json["displayTerm"], json["termId"]);


  int termId;
  String companyCode;
  String displayTerm;
  String terms;
  int isActive;



  TermModel({
    required this.termId,
    required this.companyCode,
    required this.displayTerm,
    required this.terms,
    required this.isActive,
  });

  factory TermModel.fromMap(Map<String, dynamic> json) => TermModel(
    termId: json["termId"],
      companyCode: json["companyCode"],
      displayTerm: json["displayTerm"],
      terms: json["terms"],
      isActive: json["isActive"]
  );

  Map<String, dynamic> toMap() => {
    "termId": termId,
    "companyCode": companyCode,
    "displayTerm" : displayTerm,
    "terms" : terms,
    "isActive" : isActive
  };

}