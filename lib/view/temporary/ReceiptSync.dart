

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/widget/LoginButton.dart';

class ReceiptSync extends StatefulWidget {
  const ReceiptSync({Key? key}) : super(key: key);

  @override
  _ReceiptSyncState createState() => _ReceiptSyncState();
}

class _ReceiptSyncState extends State<ReceiptSync> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.temp_receipt_synced_title),
        backgroundColor: MyColors.primaryColor,
      ),
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
