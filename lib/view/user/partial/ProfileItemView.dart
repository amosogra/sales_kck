

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';


// ignore: must_be_immutable
class ProfileItemView extends StatefulWidget {
  String title;
  String content;

  ProfileItemView({required this.title, required this.content});
  //const ProfileItemView({Key? key}) : super(key: key);

  @override
  _ProfileItemViewState createState() => _ProfileItemViewState();
}

class _ProfileItemViewState extends State<ProfileItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        border: Border.all(
          color: MyColors.textBorderColor
        )
      ),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                child: Text(widget.title, style: TextStyle(color: MyColors.textBorderColor, fontWeight: FontWeight.bold),),
              )
          ),
          Expanded(
              flex: 3,
              child: Container(
                child: Text(widget.content , style: TextStyle(color: MyColors.textColor),),
              )
          )
        ],
      ),
    );

  }
}
