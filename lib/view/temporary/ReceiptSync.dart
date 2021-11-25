

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/TemporaryReceiptModel.dart';
import 'package:sales_kck/services/TemporaryReceipt.dart';
import 'package:sales_kck/widget/LoginButton.dart';

class ReceiptSync extends StatefulWidget {
  const ReceiptSync({Key? key}) : super(key: key);

  @override
  _ReceiptSyncState createState() => _ReceiptSyncState();
}

class _ReceiptSyncState extends State<ReceiptSync> {



  String searchKey = '';
  final myController = TextEditingController();

  List<TemporaryReceiptModel> originalItems = <TemporaryReceiptModel>[];
  List<TemporaryReceiptModel> items = <TemporaryReceiptModel>[];
  void loadItems() async{
    List<TemporaryReceiptModel> response = await getTemporaryReceipt(context);
    if(response.length > 0){
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
      if(element.companyCode.toLowerCase().contains(key.toLowerCase()) || element.trNo.toLowerCase().contains(key.toLowerCase())  || element.custAccNo.toLowerCase().contains(key.toLowerCase()) ){
        tmp.add(element);
      }
    });
    setState(() {
      items = tmp;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(_printLatestValue);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
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
        title: Text(Strings.temp_receipt_synced_title),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
          alignment: Alignment.topCenter,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              items.length == 0 ?
              Container(
                child: Column(
                  children: [
                    Image(image: AssetImage(Assets.iconEdit) , width: 70,),
                    Text(Strings.not_add_order, style:  TextStyle(color: MyColors.textBorderColor ) ),
                  ],
                ),
              )
                  :
              Container(
                  margin: EdgeInsets.only(top: 20),
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

            ],
          )
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
          onTap: (){
            debugPrint("render..");
            Navigator.pop(context, item.toMap());
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
        )
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

}
