import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/temporary/partial/Draft.dart';
import 'package:sales_kck/view/temporary/partial/Saved.dart';

class ReceiptPending extends StatefulWidget {
  const ReceiptPending({Key? key}) : super(key: key);
  @override
  _ReceiptPendingState createState() => _ReceiptPendingState();
}

class _ReceiptPendingState extends State<ReceiptPending> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.primaryColor,
            bottom: const TabBar(
              indicatorColor: MyColors.whiteColor,
              tabs: [
                Tab( text: Strings.saved,), // icon: Icon(Icons.directions_car) ,
                Tab( text: Strings.draft ),
              ],
            ),
            title: const Text(Strings.temp_receipt_pending_title),
          ),

          body:  const TabBarView(
            children: [
              Saved(),
              Draft(),
            ],
          ),

        ),
      ),
    );
  }
}
