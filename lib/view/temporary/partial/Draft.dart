

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/widget/LoginButton.dart';

class Draft extends StatefulWidget {

  const Draft({Key? key}) : super(key: key);
  @override
  _DraftState createState() => _DraftState();
  
}

class _DraftState extends State<Draft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(Assets.iconEdit) , width: 70,),
            Text(Strings.not_add_order, style: Theme.of(context).textTheme.bodyText2,),
          ],
        )
      ),

      bottomNavigationBar: Container(
        child: LoginButton(
          title: Strings.add_item,
          onPressed: (){
          },
        ),
      ),
    );
  }
}
