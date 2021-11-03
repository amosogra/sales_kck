

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/services/OrderService.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/sale_list/partial/NoItem.dart';
import 'package:sales_kck/widget/InputForm.dart';

class SaleListingSynced extends StatefulWidget {

  const SaleListingSynced({Key? key}) : super(key: key);
  @override
  _SaleListingSyncedState createState() => _SaleListingSyncedState();
}


class _SaleListingSyncedState extends State<SaleListingSynced> {

  List<SaleOrderModel> items = <SaleOrderModel>[];
  void loadItems() async{
    List<SaleOrderModel> response = await getSaleOrders(context);
    if(response.length > 0){
      setState(() {
        items = response;
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      loadItems();
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.sales_list_synced_title),
      ),
      body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                margin: EdgeInsets.only(top: 0),
                child: items.length == 0 ?
                showNoItem(context)
                    :
                Container(
                  child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index){
                          return _buildItem(items[index], index);
                        },
                      )
                  )
                )

              )

            ],
          )
      ),
    );
  }

  Widget _buildItem(SaleOrderModel item, int index) {

    return InkResponse(
      onTap: () async{
        //Navigator.pop(context, item.toMap());
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
        //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    item.custName,
                    style: TextStyle(fontSize: 14),
                  ),
                )
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    item.companyCode,
                    style: TextStyle(fontSize: 12),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }



}
