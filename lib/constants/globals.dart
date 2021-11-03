library globals;

import 'package:flutter/material.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/view/user/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
String page = '';
List<ItemModel> items = <ItemModel>[];



initializeSaleOrder(){

  return  new SaleOrderModel(soId: 0, companyCode: "", custAccNo: "", custName: "",
      docNo: "", docDate: "", invAddr1: "", invAddr2: "", invAddr3: "", invAddr4: "",
      branchCode: "", salesLocation: "", shipVia: "", shipInfo: "", attention: "",
      displayTerm: "" , salesAgent: "", inclusiveTax: 0, subtotalAmt: "0", taxAmt: "0", totalAmt: "0",
      remark1: "", remark2: "", remark3: "", remark4: "",
      cancelled: 0, rev: 0, deleted: 0);

}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed:  () {
      Navigator.pop(context);
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => LoginPage()
          ));
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    //title: Text("Do you want to logout"),
    content: Text("Do you want to logout?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showToastMessage(BuildContext context, String message, String btnTitle){
  Widget continueButton = FlatButton(
    child: Text(btnTitle),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    //title: Text("Do you want to logout"),
    content: Text(message),
    actions: [
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}


