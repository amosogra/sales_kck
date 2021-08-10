

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/sale_list/partial/NoItem.dart';

class SaleListingSynced extends StatefulWidget {

  const SaleListingSynced({Key? key}) : super(key: key);
  @override
  _SaleListingSyncedState createState() => _SaleListingSyncedState();
}


class _SaleListingSyncedState extends State<SaleListingSynced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.sales_list_synced),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Search Item" , style: Theme.of(context).textTheme.bodyText1,),
                          Divider(color: MyColors.greyColor,)
                        ],
                      ),
                    ),
                    Icon(Icons.search),
                    Icon(Icons.close),
                  ],
                ),
              ),

              showNoItem(context),

            ],
          )
      ),
    );
  }
}
