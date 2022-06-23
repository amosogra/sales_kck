import 'package:flutter/material.dart';
import 'package:sales_kck/constants/DBHelper/OrderDBHelper.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/services/order_service.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/order/pages/Customer.dart';
import 'package:sales_kck/view/sale_list/partial/NoItem.dart';
import 'package:sales_kck/view/sale_list/sale_listing_synced_details.dart';
import 'package:sales_kck/view/widget/InputForm.dart';

class SaleListingSynced extends StatefulWidget {
  const SaleListingSynced({Key? key}) : super(key: key);
  @override
  _SaleListingSyncedState createState() => _SaleListingSyncedState();
}

class _SaleListingSyncedState extends State<SaleListingSynced> {
  String searchKey = '';
  final myController = TextEditingController();

  List<SaleOrderModel> originalItems = <SaleOrderModel>[];
  List<SaleOrderModel> items = <SaleOrderModel>[];
  void loadItems() async {
    OrderDBHelper orderDBHelper = new OrderDBHelper();
    List<SaleOrderModel> response = await orderDBHelper.retrieveOrdersBySynced("1");
    //List<SaleOrderModel> response = await getSaleOrders(context);
    if (response.length > 0) {
      setState(() {
        items = response;
        originalItems = response;
      });
    }
  }

  void _printLatestValue() {
    searchItem('${myController.text}');
  }

  void searchItem(String key) {
    List<SaleOrderModel> tmp = <SaleOrderModel>[];
    originalItems.forEach((element) {
      if (element.companyCode.toLowerCase().contains(key.toLowerCase()) ||
          element.custName.toLowerCase().contains(key.toLowerCase()) ||
          element.custAccNo.toLowerCase().contains(key.toLowerCase())) {
        tmp.add(element);
      }
    });
    setState(() {
      items = tmp;
    });
  }

  String getDate(String code) {
    String subString = code.substring(2, 10);
    debugPrint(subString);
    return subString.substring(subString.length - 2, subString.length) +
        "/" +
        getMonth(subString.substring(subString.length - 4, subString.length - 2)) +
        "/" +
        subString.substring(0, 4);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(_printLatestValue);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadItems();
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text(Strings.sales_list_synced_title),
        ),
        body: SingleChildScrollView(
          child: Container(
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
                                      controller: myController,
                                      myHint: "Search Item",
                                      validateFunction: (value) {
                                        return Validations.validateEmpty(value!);
                                      },
                                      onChange: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.search,
                                color: MyColors.textGreyColor,
                              ),
                            ],
                          ),
                          Divider(
                            color: MyColors.greyColor,
                          )
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: items.length == 0
                        ? showNoItem(context)
                        : Container(
                            child: Container(
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return _buildItem(items[index], index);
                                },
                              ),
                            ),
                          ),
                  ),
                ],
              )),
        ));
  }

  Widget _buildItem(SaleOrderModel item, int index) {
    return GestureDetector(
      onTap: () => {},
      child: InkResponse(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SaleListingSyncedDetails(orderId: item.soId.toString())));
        },
        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.docDate,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    item.custName,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            subtitle: Container(
              child: Row(
                children: [
                  Text(item.companyCode),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item.docNo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        item.totalAmt,
                        style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.blackColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // return InkResponse(
    //   onTap: () async{
    //     //Navigator.pop(context, item.toMap());
    //   },
    //   child: Container(
    //     padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
    //     //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
    //     child: Row(
    //       children: [
    //         Expanded(
    //             flex: 2,
    //             child: Container(
    //               child: Text(
    //                 item.custName,
    //                 style: TextStyle(fontSize: 14),
    //               ),
    //             )
    //         ),
    //         Expanded(
    //             flex: 1,
    //             child: Container(
    //               child: Text(
    //                 item.companyCode,
    //                 style: TextStyle(fontSize: 12),
    //               ),
    //             )
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
