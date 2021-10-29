import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/services/OrderService.dart';
import 'partial/NoItem.dart';


class SaleListingPending extends StatefulWidget {

  const SaleListingPending({Key? key}) : super(key: key);
  @override
  _SaleListingPendingState createState() => _SaleListingPendingState();

}

class _SaleListingPendingState extends State<SaleListingPending> {


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
    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.sales_listing_pending_title),
      ),

      body: Container(
        alignment: Alignment.center,
        child: items.length == 0 ?
        showNoItem(context)
            :
        Container(
          alignment: Alignment.topCenter,
          child: Flexible(
              flex: 1,
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
          ),
        )

      ),

    );
  }


  Widget _buildItem(SaleOrderModel item, int index) {

    return InkResponse(
      onTap: () async{
        Navigator.pop(context, item.toMap());
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
