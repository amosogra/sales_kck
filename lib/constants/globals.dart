library globals;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sales_kck/view/user/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
String page = '';

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


showCloseDialog(BuildContext context) {
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
    content: Text("Are you sure??"),
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

showRetryTestDialog(BuildContext context , int count, bool isConnected) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      if(Navigator.canPop(context)){
        Navigator.pop(context);
      }
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed:  () {
      debugPrint("close count " +  count.toString() );
      for(int i = 0; i < count; i++){
        if( i  == count - 1){
          if(isConnected){
            if(Navigator.canPop(context)){
              Navigator.pop(context, "connected");
              debugPrint(" navigator pop connected");
            }

          }else{
            if(Navigator.canPop(context)){
              Navigator.pop(context, "disconnected");
              debugPrint(" navigator pop disconnected");
            }
          }
        }else{
          if(Navigator.canPop(context)){
            Navigator.pop(context);
            debugPrint(" navigator pop");
          }
        }

      }
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //         builder: (context) => MainPage(page: 4,)
      //     ),
      //         (Route<dynamic> route) => false);

    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    //title: Text("Do you want to logout"),
    content: Text("Are you sure??"),
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

dynamic setPatientName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  prefs.setString('patient_name', name);
}

dynamic getPatientName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString('patient_name');
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


