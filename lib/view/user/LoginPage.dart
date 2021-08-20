
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

  String email = 'test_sales',password = 'admin!@#123';
  TextEditingController emailController = TextEditingController(text: 'test_sales');
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
      //showInSnackBar('Please fix the errors in red before submitti
      // ng.');
    }
  }


  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset : true,
      backgroundColor: MyColors.bgColor,
      body:SingleChildScrollView(
        child:Container(
          child: Stack(
            children: [
              Container(
                height: screenHeight / 2,
                color:MyColors.primaryColor,
              ),

              Card(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08 , vertical: screenHeight * 0.15),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 30),
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
                          child: Text( Strings.forgot_password , style: TextStyle(fontSize: 14, fontFamily: 'Verdana', color: MyColors.primaryColor ),),
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
            // width: 156,
            // height: 148,
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
                          return Validations.validateName(value!);
                        },
                        onChange: (value){},
                        controller: emailController,
                        myHint: Strings.userName,
                        myFocusNode: focusEmail,
                        nextFocusNode: focusPassword,
                        secure: false,
                      ),
                    ),
                    Image(image: AssetImage(Assets.iconUser) , width: 20,)
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
                Text(Strings.password, style: TextStyle(color: MyColors.textBorderColor),),
                Row(
                  children: [
                    Expanded(
                      child: InputForm(
                        validateFunction: (value){
                          return Validations.validatePassword(value!);
                        },
                        onChange: (value){},
                        controller: passwordController,
                        myHint: Strings.password,
                        myFocusNode: focusPassword,
                        secure: true,
                      ),
                    ),
                    Image(image: AssetImage(Assets.iconPassword) , width: 20,)
                  ],
                )
              ],
            )
        ),




      ],
    );
  }

}
