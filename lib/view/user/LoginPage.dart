
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/main/HomePage.dart';
import 'package:sales_kck/widget/InputForm.dart';
import 'package:sales_kck/widget/LoginButton.dart';
import 'ForgotPasswordPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();
  var emailKey = GlobalKey<FormState>();
  var passwordKey = GlobalKey<FormState>();
  bool isRemember = false;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      initView();
    });
  }

  void initView() async{
    bool remember = await Storage.isRemember();
    String user = await Storage.getUser();
    String password = await Storage.getPassword();
    if( remember){
      emailController.text = jsonDecode(user)['email'];
      passwordController.text = password;
    }
    setState(() {
      this.isRemember = remember;
    });
  }

  void handleLogin() async{
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
      body:SingleChildScrollView(

        child:Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                color:MyColors.primaryColor,
              ),

              Card(
                margin: EdgeInsets.only(top: 100, left: 25 , right: 25 ),
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
                            myHint: Strings.username,
                            myFocusNode: focusEmail,
                            nextFocusNode: focusPassword,
                            controller: emailController,
                            textInputTye: TextInputType.emailAddress,
                            key: this.emailKey,
                          )
                      ),

                      Container(
                        margin: EdgeInsets.only(top:10),
                        child: InputForm(
                          controller: passwordController,
                          myHint: Strings.password,
                          myFocusNode: focusPassword,
                          secure: true,
                          key: this.passwordKey,
                        ),
                      ),

                      Container(
                        child: Row(
                          children: [
                            Checkbox(
                              value: isRemember,
                              onChanged: (value) {
                                debugPrint( "clicked -- " + value.toString() );
                                setState(() {
                                  isRemember = value!;
                                });
                              },
                            ),
                            Text( Strings.remember_username , style:TextStyle(fontFamily: 'Verdana')),
                          ],
                        ),
                      ),

                      InkResponse(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top:5),
                          alignment: Alignment.centerRight,
                          child: Text( Strings.forgot_password , style: TextStyle(fontSize: 16, fontFamily: 'Verdana', color: MyColors.primaryColor ),),
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: LoginButton(
                          key: UniqueKey(),
                          title: Strings.login,
                          onPressed: (){
                            Storage.setRemember(this.isRemember);
                            handleLogin();
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
