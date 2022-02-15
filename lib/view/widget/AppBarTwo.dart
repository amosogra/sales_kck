
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/font_family.dart';

class AppBarTwo extends StatefulWidget with PreferredSizeWidget {

  @override
  final Size preferredSize;
  final String title;
  final VoidCallback onClicked;
  final bool showBack;
  AppBarTwo({ Key? key, required this.title, required this.onClicked, this.showBack = true}) :     preferredSize = Size.fromHeight(60.0),  super(key: key);

  @override
  _AppBarTwoState createState() => _AppBarTwoState();

}

class _AppBarTwoState extends State<AppBarTwo> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 1
          )]
      ),
      child:SafeArea(
        child:Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0))
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child:InkResponse(
                  onTap: widget.onClicked,
                  child: Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: widget.showBack ? Image(
                          height: 25,
                          image: AssetImage('assets/images/back.png')
                      ) : null
                  ),
                )
              ),

              Expanded(
                flex: 13,
                child: Container(

                  alignment: Alignment.center,
                  child:Text(widget.title, style: TextStyle(color: MyColors.primaryColor, fontSize: Device.get().isTablet ? 20 : 18 , fontFamily: FontFamily.verdana),),
                )
              ),

              Expanded(
                  flex: 1,
                  child:Text("")
              )

            ],
          ),

        )
      )
    );
  }




}
