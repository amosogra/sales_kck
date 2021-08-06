import 'package:flutter/material.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/widget/AppBarTwo.dart';


class SaleListing extends StatefulWidget {
  const SaleListing({Key? key}) : super(key: key);

  @override
  _SaleListingState createState() => _SaleListingState();
}

class _SaleListingState extends State<SaleListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(
        title: Strings.appName,
        onClicked: (){
        },
      ),

      body: Container(
        child: Text("sale listing.."),
      ),

    );
  }
}
