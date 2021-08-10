

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.price_history),
      ),

      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.customer, style: Theme.of(context).textTheme.headline2 , ),
            Container(
              margin: EdgeInsets.only(top: 10) ,
              child: Row(
                children: [
                  Expanded(child:   Text(Strings.customer, style: Theme.of(context).textTheme.bodyText2 ), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Text(Strings.customer, style: Theme.of(context).textTheme.headline2 , ),
            Container(
              margin: EdgeInsets.only(top: 10) ,
              child: Row(
                children: [
                  Expanded(child:   Text(Strings.customer, style: Theme.of(context).textTheme.bodyText2 ), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),


            Container(
              child: LoginButton(
                title: Strings.search,
                onPressed: (){
                },
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Image(image: AssetImage(Assets.iconEdit) , width: 70,),
                  Text(Strings.no_record, style: Theme.of(context).textTheme.bodyText1,)
                ],
              ),
            )

          ],
        ),
      ),

    );
  }

}
