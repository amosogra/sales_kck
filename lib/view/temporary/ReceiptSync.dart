import 'package:flutter/material.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftDBHelper.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';
import 'package:sales_kck/model/post/TemporaryReceiptModel.dart';
import 'package:sales_kck/services/temporary_receipt_service.dart';
import 'package:sales_kck/view/customer/CustomerList.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';

class ReceiptSync extends StatefulWidget {
  const ReceiptSync({Key? key}) : super(key: key);

  @override
  _ReceiptSyncState createState() => _ReceiptSyncState();
}

class _ReceiptSyncState extends State<ReceiptSync> {
  String searchKey = '';
  String companyName = 'Customer Name';
  String accNo = '';
  final myController = TextEditingController();

  List<TemporaryReceiptModel> originalItems = <TemporaryReceiptModel>[];
  List<TemporaryReceiptModel> items = <TemporaryReceiptModel>[];
  List<TempDraftModel> draftItems = <TempDraftModel>[];

  void loadItems(String accNo) async {
    List<TemporaryReceiptModel> response = await getTemporaryReceipt(context, accNo);
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
    List<TemporaryReceiptModel> tmp = <TemporaryReceiptModel>[];
    originalItems.forEach((element) {
      if (element.companyCode.toLowerCase().contains(key.toLowerCase()) ||
          element.trNo.toLowerCase().contains(key.toLowerCase()) ||
          element.custAccNo.toLowerCase().contains(key.toLowerCase())) {
        tmp.add(element);
      }
    });
    setState(() {
      items = tmp;
    });
  }

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      TempDraftDBHelper tempDraftDBHelper = new TempDraftDBHelper();
      List<TempDraftModel> response = await tempDraftDBHelper.retrieveOrdersBySaved("2");

      if (response.length > 0) {
        setState(() {
          draftItems = response;
        });
      }
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
        title: Text(Strings.temp_receipt_synced_title),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList()));
                if (result != null) {
                  CustomerModel customerModel = CustomerModel.fromMap(result);
                  setState(() {
                    companyName = customerModel.name;
                  });

                  loadItems(customerModel.accNo);
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(companyName, style: Theme.of(context).textTheme.bodyText2),
                    ),
                    Icon(Icons.search)
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: draftItems.length,
                itemBuilder: (context, index) {
                  return _buildItem2(draftItems[index], index);
                },
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(left: 30, right: 30),
      //   child: LoginButton(
      //     title: Strings.add_item,
      //     onPressed: (){
      //     },
      //   ),
      // ),
    );
  }

  Widget _buildItem(TemporaryReceiptModel item, int index) {
    return GestureDetector(
      onTap: () => {
        //Slidable.of(context)?.renderingMode == SlidableRenderingMode.none ? Slidable.of(context)?.open() : Slidable.of(context)?.close()
      },
      child: InkResponse(
        onTap: () {
          debugPrint("render..");
          //Navigator.pop(context, item.toMap());
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Customer(saleOrderModel: item,))
          // );
        },
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              child: Text('TR'),
              foregroundColor: Colors.white,
            ),
            title: Text(item.trNo),
            subtitle: Text(item.companyCode),
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
    //                 item.trNo,
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

  Widget _buildItem2(TempDraftModel item, int index) {
    return GestureDetector(
      onTap: () => {},
      child: InkResponse(
        onTap: () {
          debugPrint("render..");
          //Navigator.pop(context, item.toMap());
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Customer(saleOrderModel: item,))
          // );
        },
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              child: Text('TR'),
              foregroundColor: Colors.white,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.receiptDate,
                  style: TextStyle(color: MyColors.textGreyColor),
                ),
                Text(item.companyCode)
              ],
            ),
            subtitle: Text(item.receiptNo),
          ),
        ),
      ),
    );
  }
}
