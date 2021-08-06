

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/widget/InputForm.dart';
import 'package:sales_kck/widget/LoginButton.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final focusOldPassword = FocusNode();
  final focusNewPassword = FocusNode();
  final focusConfirmPassword = FocusNode();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appName),
      ),
      body: Container(
        child: Column(
          children: [

            Container(
              child: Column(
                children: [
                  Text(Strings.old_password),
                  InputForm(
                    controller: oldPasswordController,
                    myHint: Strings.password,
                    myFocusNode: focusOldPassword,
                    nextFocusNode: focusNewPassword,
                    secure: true,
                  ),
                ],
              ),
            ),

            Container(
              child: Column(
                children: [
                  Text(Strings.old_password),
                  InputForm(
                    controller: oldPasswordController,
                    myHint: Strings.password,
                    myFocusNode: focusOldPassword,
                    nextFocusNode: focusNewPassword,
                    secure: true,
                  ),
                ],
              ),
            ),

            Container(
              child: Column(
                children: [
                  Text(Strings.old_password),
                  InputForm(
                    controller: oldPasswordController,
                    myHint: Strings.password,
                    myFocusNode: focusOldPassword,
                    nextFocusNode: focusNewPassword,
                    secure: true,
                  ),
                ],
              ),
            ),


            Container(
              child: LoginButton(
                title: Strings.confirm,
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            )




          ],
        )
      ),
    );
  }
}
