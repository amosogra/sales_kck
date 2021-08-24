

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/widget/LoginButton.dart';

class Saved extends StatefulWidget {

  const Saved({Key? key}) : super(key: key);
  @override
  _SavedState createState() => _SavedState();

}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(Assets.iconEdit) , width: 70,),
            Text(Strings.not_add_order, style: TextStyle(color: MyColors.textBorderColor),),
          ],
        )
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: LoginButton(
          title: Strings.add_item,
          onPressed: (){
          },
        ),
      ),
    );
  }
}
