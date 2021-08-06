

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/widget/LoginButton.dart';

class PriceHistory extends StatefulWidget {
  const PriceHistory({Key? key}) : super(key: key);

  @override
  _PriceHistoryState createState() => _PriceHistoryState();

}

class _PriceHistoryState extends State<PriceHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Text(Strings.old_password),
              ],
            ),
          ),

          Container(
            child: Column(
              children: [
                Text(Strings.old_password),

              ],
            ),
          ),


          Container(
            child: LoginButton(
              title: Strings.confirm,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          )


        ],
      ),
    );
  }

}
