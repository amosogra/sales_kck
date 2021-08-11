import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'partial/NoItem.dart';


class SaleListingPending extends StatefulWidget {

  const SaleListingPending({Key? key}) : super(key: key);
  @override
  _SaleListingPendingState createState() => _SaleListingPendingState();

}

class _SaleListingPendingState extends State<SaleListingPending> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.sales_listing_pending_title),
      ),

      body: Container(
        alignment: Alignment.center,
        child: showNoItem(context)
      ),

    );
  }

}
