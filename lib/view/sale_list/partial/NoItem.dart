
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/strings.dart';
Widget showNoItem(BuildContext context){

  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage(Assets.iconEdit) , width: 70,),
        Text(Strings.no_pending_order, style: Theme.of(context).textTheme.bodyText1,)
      ],
    ),
  );

}