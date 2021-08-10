
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/dialog/ConfirmDialog.dart';
import 'package:sales_kck/view/user/ChangePassword.dart';
import 'package:sales_kck/view/user/LoginPage.dart';
import 'package:sales_kck/widget/AppBarOne.dart';
import 'package:sales_kck/widget/LoginButton.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String role = "";
  String email = "";
  String displayName = "";
  String fullName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.edit_profile)
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(Strings.userName),
                    )
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Text(" this is my user."),
                    )
                  )
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          child: Text(Strings.fullName),
                      )
                  ),
                  Expanded(
                      child: Container(
                        child: Text(this.fullName),
                      )
                  )
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          child: Text(Strings.displayName),
                      )
                  ),
                  Expanded(
                      child: Container(
                        child: Text(this.displayName),
                      )
                  )
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),


            Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          child: Text(Strings.email),
                      )
                  ),
                  Expanded(
                      child: Container(
                        child: Text(this.email),
                      )
                  )
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),


            Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          child: Text(Strings.role),
                      )
                  ),
                  Expanded(
                      child: Container(
                        child: Text(
                            this.role
                        ),
                      )
                  )
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          child: Text(Strings.company),
                      )
                  ),
                  Expanded(
                      child: Container(
                        child: Text(Strings.userName),
                      )
                  )
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

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
      ),

    );
  }

}
