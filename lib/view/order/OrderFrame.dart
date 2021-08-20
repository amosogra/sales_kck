

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

class _OrderFrameState extends State<OrderFrame> with SingleTickerProviderStateMixin{

  final List<Tab> myTabs = <Tab>[
    Tab( text: Strings.customer,), // icon: Icon(Icons.directions_car) ,
    Tab( text: Strings.order ),
    Tab( text: Strings.summary ),
  ];
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.primaryColor,
            bottom:   TabBar(
              indicatorColor: MyColors.whiteColor,
              tabs: this.myTabs,
              controller: _tabController,
            ),
            title: const Text(Strings.sales_order),
          ),
          body:  TabBarView(
            children: [
              Customer(tabController: _tabController,),
              Order(),
              Summary()
            ],
          ),

        ),
      ),
    );
  }
}
