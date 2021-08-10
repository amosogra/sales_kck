

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';


class Customer extends StatefulWidget {

  const Customer({Key? key}) : super(key: key);
  @override
  _CustomerState createState() => _CustomerState();

}

class _CustomerState extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 30, left: 30, right: 30),
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


            Row(
              children: [
                Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.doc_number, style: Theme.of(context).textTheme.headline2 ),
                        Text(Strings.new_document, style: Theme.of(context).textTheme.bodyText2 ),
                        Divider(color: MyColors.greyColor,)
                      ],
                    ),
                ),
                Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.doc_date, style: Theme.of(context).textTheme.headline2 ),
                        Row(
                          children: [
                            Expanded(child:   Text(Strings.today, style: Theme.of(context).textTheme.bodyText2 ), ) ,
                            Icon(Icons.calendar_today)
                          ],
                        ),
                        Divider(color: MyColors.greyColor,)
                      ],
                    )
                )
              ],
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(Strings.description, style:  Theme.of(context).textTheme.headline2 ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10) ,
              child: Row(
                children: [
                  Expanded(child:   Text("Address 1" ,  style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text("Address 2", style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),


            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text("Address 3", style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),
            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text("Address 4", style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),


            Container(
              margin: EdgeInsets.only(top:15),
              child: Text(Strings.attention, style:  Theme.of(context).textTheme.headline1 ),
            ),
            Text(Strings.phone_number, style:  Theme.of(context).textTheme.headline2 ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(Strings.phone_number, style:  Theme.of(context).textTheme.bodyText2 ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(Strings.terms , style:  Theme.of(context).textTheme.headline1 ),
                  ),
                  Text("Lst date sat")
                ],
              ),
            ),



            Container(
              margin: EdgeInsets.only(top: 10) ,
              child: Row(
                children: [
                  Expanded(child:   Text("Remarks 1" ,  style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text("Remarks 2", style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),


            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text("Remarks 3", style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),
            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text("Remarks 4", style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),




          ],
        ),
      )
    );
  }
}
