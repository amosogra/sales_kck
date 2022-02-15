
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_storages.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/User.dart';
import 'package:sales_kck/model/post/company_model.dart';
import 'package:sales_kck/view/dialog/ConfirmDialog.dart';
import 'package:sales_kck/view/dialog/company_list_dialog.dart';
import 'package:sales_kck/view/user/ChangePassword.dart';
import 'package:sales_kck/view/user/LoginPage.dart';
import 'package:sales_kck/view/user/partial/ProfileItemView.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User myUser;
  String company = '';
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      initView();
    });
  }

  void initView () async{
    String user = await Storage.getUser();
    if(user.isNotEmpty){
      myUser = User.fromMap(jsonDecode(user)['user']);
    }
    company = await Storage.getCompany();
  }

  void openCompany() async{

    bool isShown = await Storage.getShowCompany();
    var data = await Storage.getUser();
    List<CompanyModel> models = [];

    jsonDecode(data.toString())['user']['companies'].forEach((item) {
      CompanyModel model = CompanyModel.fromMap(item);
      models.add(model);
    });

    //if(!isShown){
    showDialog(context: context,
        builder: (BuildContext context){
          return CompanyListDialog(
              models,
                  (val1, val2, salesAgent){
                Storage.setShowCompany(true);
                Storage.setCompany(val1);
                company = val1;
                Storage.setSalesAgent(salesAgent);
                Navigator.pop(context);
              }
          );
        }
    );
    //}
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(milliseconds: 1000),
        () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.edit_profile)
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: FutureBuilder(
          future: _calculation,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
          {
            if(snapshot.hasData){
              return Container(
                child: Column(
                  children: [

                    Container(
                      child: buildForm(),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 7 , left: 10, right: 10),
                      child: LoginButton(
                        title: Strings.change_password,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: LoginButton(
                        title: Strings.logout,
                        onPressed: (){

                          Storage.setLogin(false);
                          showDialog(context: context,
                              builder: (BuildContext context){
                                return ConfirmDialog(
                                    "Are you sure to logout?",
                                        (){
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()
                                      ), (Route<dynamic>route) => false);
                                    }
                                );
                              }
                          );
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmDialog("Title") ));
                        },
                      ),
                    )
                  ],
                ),
              );

            }else{
              return Container();
            }

          },

        )
      ),

    );
  }


  buildForm(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.personal_info, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        ProfileItemView(title: Strings.userName, content: myUser.username),
        ProfileItemView(title: Strings.fullName, content: myUser.name),
        ProfileItemView(title: Strings.displayName, content: myUser.name),
        ProfileItemView(title: Strings.email, content: myUser.email),
        ProfileItemView(title: Strings.role, content: "Role"),
        InkResponse(
          onTap: () {
            openCompany();
          },
          child: ProfileItemView(title: Strings.company, content: company),
        )

      ],
    );
  }

}
