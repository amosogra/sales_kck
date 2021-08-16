
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/services/UserService.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/main/HomePage.dart';
import 'package:sales_kck/widget/InputForm.dart';
import 'package:sales_kck/widget/LoginButton.dart';
import 'ForgotPasswordPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = 'salesman',password = 'admin!@#123';
  TextEditingController emailController = TextEditingController(text: 'salesman');
  TextEditingController passwordController = TextEditingController(text: 'admin!@#123');
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState!.removeCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  void handleLogin() async{

    FormState? form = formKey.currentState;
    form!.save();

    if(!form.validate()){
      showInSnackBar('Please fix the errors in red before submitting.');
    }else{
      //login(email, password);
      bool response  = await login(context, emailController.text, passwordController.text);
      if(response){ // Call Async Data
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => HomePage()
            ),
                (Route<dynamic> route) => false);
      }else{
        showToastMessage(context, "Login failed", "Ok");
      }
      //showInSnackBar('Please fix the errors in red before submitting.');
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset : true,
      body:SingleChildScrollView(

        child:Container(
          child: Stack(
            children: [

              Container(
                height: screenHeight / 2,
                color:MyColors.primaryColor,
              ),

              Card(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1 , vertical: screenHeight * 0.15),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.07, vertical: 30),
                  child: Column(

                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formKey,
                        child: buildInputForm(),
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



  buildInputForm(){
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                return Validations.validateName(value!);
              },
              controller: emailController,
              myHint: Strings.email,
              myFocusNode: focusEmail,
              nextFocusNode: focusPassword,
              secure: false,
            ),
        ),


        Container(
          margin: EdgeInsets.only(top:10),
          child:InputForm(
            validateFunction: (value){
              return Validations.validatePassword(value!);
            },
            controller: passwordController,
            myHint: Strings.password,
            myFocusNode: focusPassword,
            secure: true,
          ),
        ),

      ],
    );

  }


}
