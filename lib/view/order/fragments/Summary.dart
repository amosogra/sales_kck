

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text("Document", style: Theme.of(context).textTheme.bodyText2 ,)),
              Text("sale order" , style: Theme.of(context).textTheme.bodyText2 )
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(child: Text("Document", style: Theme.of(context).textTheme.bodyText2 ,)),
                Text("sale order" , style: Theme.of(context).textTheme.bodyText2 )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(child: Text("Sub Total(ex)", style: Theme.of(context).textTheme.bodyText2 ,)),
                Text("0.00" , style: Theme.of(context).textTheme.bodyText2 )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(child: Text("GST", style: Theme.of(context).textTheme.bodyText2 ,)),
                Text("0.00" , style: Theme.of(context).textTheme.bodyText2 )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(child: Text("Total(inc)", style: Theme.of(context).textTheme.bodyText2 ,)),
                Text("0.00" , style: Theme.of(context).textTheme.bodyText2 )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(child: Text("Final Total", style: Theme.of(context).textTheme.headline2 ,)),
                Text("0.00" , style: Theme.of(context).textTheme.headline2 )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
            child: LoginButton(
              title: Strings.save,
              onPressed: (){
              },
            ),
          )

        ],
      )
    );
  }
}
