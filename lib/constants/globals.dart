library globals;

import 'package:flutter/material.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/view/user/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
String page = '';
List<ItemModel> items = <ItemModel>[];

initializeSaleOrder() {
  return new SaleOrderModel(
      soId: 0,
      companyCode: "",
      custAccNo: "",
      custName: "",
      docNo: "",
      docDate: "",
      invAddr1: "",
      invAddr2: "",
      invAddr3: "",
      invAddr4: "",
      branchCode: "",
      salesLocation: "",
      shipVia: "",
      shipInfo: "",
      attention: "",
      displayTerm: "",
      salesAgent: "",
      inclusiveTax: 0,
      subtotalAmt: "0",
      taxAmt: "0",
      totalAmt: "0",
      remark1: "",
      remark2: "",
      remark3: "",
      remark4: "",
      cancelled: 0,
      rev: 0,
      deleted: 0,
      synced: "0");
}

String getMonth(value) {
  if (value == "01") {
    return "JAN";
  } else if (value == "02") {
    return "FEB";
  } else if (value == "03") {
    return "MAR";
  } else if (value == "04") {
    return "APR";
  } else if (value == "05") {
    return "MAY";
  } else if (value == "06") {
    return "JUN";
  } else if (value == "07") {
    return "JUL";
  } else if (value == "08") {
    return "AUG";
  } else if (value == "09") {
    return "SEP";
  } else if (value == "10") {
    return "OCT";
  } else if (value == "11") {
    return "NOV";
  } else if (value == "12") {
    return "DEC";
  }
  return value;
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
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

showToastMessage(BuildContext context, String message, String btnTitle, {Function()? press, bool dismissible = true}) {
  Widget continueButton = FlatButton(
    child: Text(btnTitle),
    onPressed: () {
      Navigator.pop(context);
      if (press != null) press();
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
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return alert;
    },
  );
  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
