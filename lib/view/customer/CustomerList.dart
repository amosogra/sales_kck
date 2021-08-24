
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/services/CustomerService.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {

  List<CustomerModel> customers = <CustomerModel>[];

  void loadCustomers() async{
    List<CustomerModel> response = await getCustomers(context);
    if(response.length > 0){
      debugPrint(customers.length.toString());
      setState(() {
        customers = response;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCustomers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.customer),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
          margin: EdgeInsets.only(top: 30),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: customers.length,
            itemBuilder: (context, index){
              return _buildItem(customers[index], index);
            },
          )
      ),
    );
  }

  Widget _buildItem(CustomerModel item, int index) {
    return InkResponse(
      onTap: () async{
        Navigator.pop(context, item.toMap());
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
        //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item.name + "  -  " + item.accNo,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),

            Divider(color: MyColors.greyColor,)

          ],
        ),
      ),
    );

  }

}
