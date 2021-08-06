import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:sales_kck/constants/globals.dart';

class AppBarOne extends StatefulWidget with PreferredSizeWidget {

  @override
  final Size preferredSize;

  AppBarOne({ Key? key,}) : preferredSize = Size.fromHeight(60.0),  super(key: key);

  @override
  _AppBarOneState createState() => _AppBarOneState();

}

class _AppBarOneState extends State<AppBarOne> {

  String name = "AB";
  @override
  void initState(){
    super.initState();
    getName();
  }

  getName() async {
    String tmp = await Storage.getUser();
    debugPrint(tmp);
    setState(() {
      name = "${jsonDecode(tmp)['first_name'][0]}".toUpperCase() + "${jsonDecode(tmp)['last_name'][0]}".toUpperCase();
    });
  }


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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child:Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20),
                  child: Image(
                    //height: 30,
                    image: AssetImage('assets/images_tablet/header_img.png')
                  ),
                )
              ),

              Expanded(
                flex: 1,
                child: Text(''),
              ),
              Expanded(
                flex: 1,
                child:Container(
                  margin: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  child: InkResponse(
                    onTap: (){
                      showAlertDialog(context);
                    },
                      child:Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          color: MyColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text( this.name , style: TextStyle( color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
                      )
                  ),

                )
              )
            ],
          ),

        )
      )
    );
  }

}
