

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/order/fragments/Customer.dart';
import 'package:sales_kck/view/order/fragments/Order.dart';
import 'package:sales_kck/view/order/fragments/Summary.dart';

class OrderFrame extends StatefulWidget {

  const OrderFrame({Key? key}) : super(key: key);

  @override
  _OrderFrameState createState() => _OrderFrameState();

}

class _OrderFrameState extends State<OrderFrame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.primaryColor,
            bottom: const TabBar(
              indicatorColor: MyColors.whiteColor,
              tabs: [
                Tab( text: Strings.customer,), // icon: Icon(Icons.directions_car) ,
                Tab( text: Strings.order ),
                Tab( text: Strings.summary ),
              ],
            ),
            title: const Text(Strings.sales_order),
          ),
          body:  const TabBarView(
            children: [
              Customer(),
              Order(),
              Summary()
            ],
          ),


        ),
      ),
    );
  }
}
