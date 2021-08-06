import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';

class LoginButton extends StatefulWidget {

  String title;
  final VoidCallback onPressed;
  final bool isActive ;
  LoginButton({Key? key, required this.title, required this.onPressed , this.isActive = true }) : super(key : key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {


  @override
  Widget build(BuildContext context) {

    double cardWidth = MediaQuery.of(context).size.width;

    return Container(
      width: cardWidth,
      child: ElevatedButton(
          child: Text(widget.title, style: TextStyle(fontSize: 16),),
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            primary: widget.isActive ? MyColors.primaryColor :  MyColors.primaryColor ,
            //onPrimary: MedstreamColor.PRIMARY_COLOR,
            textStyle: TextStyle(
                fontFamily: 'Verdana'
            )
          ),
        //backgroundColor: MaterialStateProperty.all<Color>(MedstreamColor.PRIMARY_COLOR),
      ),
    );
  }
}
