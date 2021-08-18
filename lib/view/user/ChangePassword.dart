

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/utils/Validations.dart';
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
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.change_password),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(25),

            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Strings.old_password),
                      InputForm(
                        validateFunction: (value){
                          return Validations.validateForm(value!);
                        },
                        controller: oldPasswordController,
                        myHint: Strings.enter_old_password,
                        myFocusNode: focusOldPassword,
                        nextFocusNode: focusNewPassword,
                        secure: true,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Strings.new_password),
                      InputForm(
                        validateFunction: (value){
                          Validations.validateForm(value!);
                        },
                        controller: newPasswordController,
                        myHint: Strings.enter_new_password,
                        myFocusNode: focusNewPassword,
                        nextFocusNode: focusConfirmPassword,
                        secure: true,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Strings.confirm_password),
                      InputForm(
                        validateFunction: (value){
                          Validations.validateForm(value!);
                        },
                        controller: confirmPasswordController,
                        myHint: Strings.enter_confirm_password,
                        myFocusNode: focusConfirmPassword,
                        secure: true,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 25),
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
      )
    );
  }
}
