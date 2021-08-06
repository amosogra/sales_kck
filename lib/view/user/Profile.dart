
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/strings.dart';
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
        title: Text(Strings.appName)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      child: Text(Strings.userName),
                    )
                  ),
                  Flexible(
                    child: Container(
                      child: Text(Strings.userName),
                    )
                  )
                ],
              ),
            ),


            Container(
              child: Row(
                children: [
                  Flexible(
                      child: Container(
                          child: Text(Strings.fullName),
                      )
                  ),
                  Flexible(
                      child: Container(
                        child: Text(this.fullName),
                      )
                  )
                ],
              ),
            ),


            Container(
              child: Row(
                children: [
                  Flexible(
                      child: Container(
                          child: Text(Strings.displayName),
                      )
                  ),
                  Flexible(
                      child: Container(
                        child: Text(this.displayName),
                      )
                  )
                ],
              ),
            ),

            Container(
              child: Row(
                children: [
                  Flexible(
                      child: Container(
                          child: Text(Strings.email),
                      )
                  ),
                  Flexible(
                      child: Container(
                        child: Text(this.email),
                      )
                  )
                ],
              ),
            ),

            Container(
              child: Row(
                children: [
                  Flexible(
                      child: Container(
                          child: Text(Strings.role),
                      )
                  ),
                  Flexible(
                      child: Container(
                        child: Text(
                            this.role
                        ),
                      )
                  )
                ],
              ),
            ),

            Container(
              child: Row(
                children: [
                  Flexible(
                      child: Container(
                          child: Text(Strings.company),
                      )
                  ),
                  Flexible(
                      child: Container(
                        child: Text(Strings.userName),
                      )
                  )
                ],
              ),
            ),


            Container(
              child: LoginButton(
                title: Strings.change_password,
                onPressed: (){
                },
              ),
            ),

            Container(
              child: LoginButton(
                title: Strings.logout,
                onPressed: (){
                },
              ),
            )



          ],
        ),
      ),

    );
  }

}
