
class SoList {

  String itemcode;
  String location;
  String description;
  String furtherdescription;
  String uom;
  String rate;
  String qty;
  int focqty;
  String smallestunitprice;
  String unitprice;
  String discount;
  int discountamt;
  String taxtype;
  int taxrate;
  int tempid;

  SoList({
    required this.itemcode,
    required this.location,
    required this.description,
    required this.furtherdescription,
    required this.uom,
    required this.rate,
    required this.qty,
    required this.focqty,
    required this.smallestunitprice,
    required this.unitprice,
    required this.discount,
    required this.discountamt,
    required this.taxtype,
    required this.taxrate,
    required this.tempid
  });


  factory SoList.fromMap(Map<String, dynamic> json) => SoList(
    itemcode: json["itemcode"],
    location: json["location"],
    description: json["description"],
    furtherdescription: json["furtherdescription"],
    uom: json["uom"],
    rate: json["rate"],
    qty: json["qty"],
    focqty: json["focqty"],
    smallestunitprice: json["smallestunitprice"],
    unitprice: json["unitprice"],
    discount: json["discount"],
    discountamt: json["discountamt"],
    taxtype: json["taxtype"],
    taxrate: json["taxrate"],
    tempid: json["tempid"],
  );


  Map<String, dynamic> toMap() => {
    "itemcode": itemcode,
    "location": location,
    "description" : description,
    "description" : description,
    "furtherdescription" : furtherdescription,
    "uom": uom,
    "rate" : rate,
    "qty" : qty,
    "focqty" : focqty,
    "smallestunitprice" : smallestunitprice,
    "unitprice" : unitprice,
    "discount" : discount,
    "discountamt" : discountamt,
    "taxtype" : taxtype,
    "taxrate" : taxrate,
    "tempid" : tempid,
  };

}