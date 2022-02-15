

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/widget/InputForm.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';


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

  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';

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
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: MyColors.textBorderColor
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    margin: EdgeInsets.only(top:10),
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.old_password, style: TextStyle(color: MyColors.textBorderColor),),
                        Row(
                          children: [
                            Expanded(
                              child: InputForm(
                                validateFunction: (value){
                                  return Validations.validatePassword(value!);
                                },
                                onChange: (value){
                                  setState(() {
                                    oldPassword = value!;
                                  });
                                },
                                controller: oldPasswordController,
                                myHint: Strings.enter_old_password,
                                myFocusNode: focusOldPassword,
                                nextFocusNode: focusNewPassword,
                                secure: true,
                              ),
                            ),
                            Image(image: AssetImage(Assets.iconPassword) , width: 20,)
                          ],
                        )
                      ],
                    )
                ),

                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: MyColors.textBorderColor
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    margin: EdgeInsets.only(top:10),
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.new_password, style: TextStyle(color: MyColors.textBorderColor),),
                        Row(
                          children: [
                            Expanded(
                              child: InputForm(
                                validateFunction: (value){
                                  return Validations.validatePassword(value!);
                                },
                                onChange: (value){
                                  newPassword = value!;
                                },
                                controller: newPasswordController,
                                myHint: Strings.enter_new_password,
                                myFocusNode: focusNewPassword,
                                nextFocusNode: focusConfirmPassword,
                                secure: true,
                              ),
                            ),
                            Image(image: AssetImage(Assets.iconPassword) , width: 20,)
                          ],
                        )
                      ],
                    )
                ),

                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: MyColors.textBorderColor
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    margin: EdgeInsets.only(top:10),
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.confirm_password, style: TextStyle(color: MyColors.textBorderColor),),
                        Row(
                          children: [
                            Expanded(
                              child: InputForm(
                                validateFunction: (value){
                                  return Validations.validatePassword(value!);
                                },
                                onChange: (value){
                                  confirmPassword = value!;
                                },
                                controller: confirmPasswordController,
                                myHint: Strings.enter_confirm_password,
                                myFocusNode: focusConfirmPassword,
                                secure: true,
                              ),
                            ),
                            Image(image: AssetImage(Assets.iconPassword) , width: 20,)
                          ],
                        )
                      ],
                    )
                ),

                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: LoginButton(
                    title: Strings.confirm,
                    isActive: oldPassword.isEmpty &&  newPassword.isEmpty && confirmPassword.isEmpty ? false : true
                    ,
                    onPressed: (){
                      if( oldPassword.isEmpty &&  newPassword.isEmpty && confirmPassword.isEmpty ){

                      }else{
                        Navigator.pop(context);
                      }

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
