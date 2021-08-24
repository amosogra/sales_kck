

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/sale_list/partial/NoItem.dart';
import 'package:sales_kck/widget/InputForm.dart';

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
        title: Text(Strings.sales_list_synced_title),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              InputForm(
                                myHint: "Search Item", validateFunction: (value){
                                return Validations.validateEmpty(value!);
                              },
                                onChange: (value){},
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.search, color: MyColors.textGreyColor,),
                      ],
                    ),
                    Divider(color: MyColors.greyColor,)
                  ],
                )
              ),

              Container(
                margin: EdgeInsets.only(top: 100),
                child: showNoItem(context),
              )

            ],
          )
      ),
    );
  }
}
