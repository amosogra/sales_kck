



class UomModel {

  int uomId;
  int itemId;
  String uom;
  String price;
  String minPrice;
  String maxPrice;
  int isActive;
  int rev;
  int deleted;

  UomModel({
    required this.uomId,
    required this.itemId,
    required this.uom,
    required this.price,
    required this.minPrice,
    required this.maxPrice,
    required this.isActive,
    required this.rev,
    required this.deleted,
  });

    factory UomModel.fromMap(Map<String,dynamic> json) => UomModel(
        uomId: json["uomId"],
        itemId: json["itemId"],
        uom: json["uom"],
      price: json["price"],
      minPrice: json["minPrice"],
      maxPrice: json["maxPrice"],
      isActive: json["isActive"],
      rev: json["rev"],
      deleted: json["deleted"],
  );

  Map<String, dynamic> toMap() => {
    "uomId": uomId,
    "itemId": itemId,
    "uom" : uom,
    "price" : price,
    "minPrice" : minPrice,
    "maxPrice" : maxPrice,
    "isActive" : isActive,
    "rev" : rev,
    "deleted" : deleted,
  };


}

