import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/services/UserService.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/main/HomePage.dart';
import 'package:sales_kck/widget/InputForm.dart';
import 'package:sales_kck/widget/LoginButton.dart';

class ForgotPasswordPage extends StatefulWidget {

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  TextEditingController usernameController = TextEditingController();
  final focusUsername = FocusNode();
  final usernameKey = GlobalKey<FormState>();
  final btnKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      initView();
    });

  }

  void initView() async{
  }

  void handleForgotPassword(BuildContext context) async{
    bool response = await forgotPassword(context, usernameController.text);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset : true,
        backgroundColor: MyColors.bgColor,
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text(Strings.forgot_password),
        ),
        body:SingleChildScrollView(

            child:Container(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2 - 30,
                      color:MyColors.primaryColor,
                    ),

                    Card(
                      margin: EdgeInsets.only(top: 120, left: 25 , right: 25 ),
                      child: Container(
                        margin: EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                        child: Column(
                          children: [
                            Image(
                                width: 156,
                                height: 148,
                                image: AssetImage(Assets.appLogo)
                            ),



                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MyColors.textBorderColor
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                margin: EdgeInsets.only(top:0),
                                padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(Strings.userName, style: TextStyle(color: MyColors.textBorderColor),),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InputForm(
                                            validateFunction: (value){
                                              Validations.validateName(value!);
                                            },
                                            onChange: (value){},
                                            controller: usernameController,
                                            myHint: Strings.userName,
                                            myFocusNode: focusUsername,
                                            secure: false,
                                            key: this.usernameKey,
                                          ),
                                        ),
                                        Image(image: AssetImage(Assets.iconUser) , width: 20,)
                                      ],
                                    )
                                  ],
                                )
                            ),


                            // Container(
                            //     margin: EdgeInsets.only(top:0),
                            //     child:InputForm(
                            //       validateFunction: (value){
                            //         Validations.validateName(value!);
                            //       },
                            //       myHint: Strings.username,
                            //       myFocusNode: focusUsername,
                            //       controller: usernameController,
                            //       textInputTye: TextInputType.emailAddress,
                            //       key: this.usernameKey,
                            //     )
                            // ),

                            Container(
                              margin: EdgeInsets.only(top: 40),
                              child: LoginButton(
                                key: this.btnKey,
                                title: Strings.forgot_password,
                                onPressed: (){
                                  handleForgotPassword(context);
                                },

                              ),
                            )

                          ],
                        ),
                      ),
                    ),

                  ],
                )

            )

        )
    );
  }

}
