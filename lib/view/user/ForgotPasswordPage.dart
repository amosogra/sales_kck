import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
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

  void forgotPassword() async{
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => HomePage()
        ),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset : true,
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
        ),
        body:SingleChildScrollView(

            child:Container(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
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
                                margin: EdgeInsets.only(top:0),
                                child:InputForm(
                                  validateFunction: (value){
                                    Validations.validateName(value!);
                                  },
                                  myHint: Strings.username,
                                  myFocusNode: focusUsername,
                                  controller: usernameController,
                                  textInputTye: TextInputType.emailAddress,
                                  key: this.usernameKey,
                                )
                            ),


                            Container(
                              margin: EdgeInsets.only(top: 40),
                              child: LoginButton(
                                key: this.btnKey,
                                title: Strings.forgot_password,
                                onPressed: (){
                                  forgotPassword();
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
