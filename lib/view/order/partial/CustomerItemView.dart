

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:blinking_text/blinking_text.dart';

// ignore: must_be_immutable
class CustomerItemView extends StatefulWidget {

  String hintText;
  String title;
  VoidCallback onTap;
  CustomerItemView({required this.hintText, required this.title, required this.onTap});

  //const CustomerItemView({Key? key}) : super(key: key);

  @override
  _CustomerItemViewState createState() => _CustomerItemViewState();
}

class _CustomerItemViewState extends State<CustomerItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10) ,
              child: Row(
                children: [
                  Expanded(
                      child:  widget.hintText == "Select Customer"  && widget.title.replaceAll("-", '').trim().isEmpty ? BlinkText(
                          widget.title.replaceAll("-", '').trim().isEmpty ? widget.hintText : widget.title,
                          beginColor: MyColors.textBorderColor,
                          endColor: MyColors.primaryColor,
                          times: 10,
                          duration: Duration(seconds: 1),
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.title.replaceAll("-", '').trim().isEmpty? MyColors.textBorderColor : MyColors.textColor,
                            fontFamily: 'Ionicons',)
                      ):
                      Text(
                          widget.title.replaceAll("-", '').trim().isEmpty ? widget.hintText : widget.title,
                          style: TextStyle( fontSize: 14, color: widget.title.replaceAll("-", '').trim().isEmpty? MyColors.textBorderColor : MyColors.textColor, fontFamily: 'Ionicons',)
                      )
                  ),
                  Icon(Icons.search, color: MyColors.textBorderColor,)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),
          ],
        ),
      ),
    );

  }
}
