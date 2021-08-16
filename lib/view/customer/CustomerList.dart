
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/Customer.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<Customer> customers = <Customer>[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.customer),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
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

  Widget _buildItem(Customer item, int index) {
    return InkResponse(
      onTap: () async{

      },
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
        //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
        child: Row(
          children: [

            Expanded(
                child: Container(
                  child: Text(
                    item.name,
                    style: TextStyle(fontSize: 16),
                  ),
                )
            ),

          ],
        ),
      ),
    );

  }

}
