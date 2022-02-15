
import 'package:sales_kck/constants/app_strings.dart';

class SoList {

  String itemcode;
  String location;
  String description;
  String furtherdescription;
  String uom;
  String rate;
  String qty;
  String focqty;
  String smallestunitprice;
  String unitprice;
  String discount;
  String discountamt;
  String taxtype;
  String taxrate;
  String tempid;
  int orderId;

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
    required this.tempid,
    required this.orderId,
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
    orderId: int.parse(json["order_id"]),
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
    "order_id" : orderId,

  };

}