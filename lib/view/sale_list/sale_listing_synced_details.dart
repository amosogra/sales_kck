
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/DBHelper/ItemDBHelper.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/SoList.dart';
import 'package:sales_kck/model/post/UomModel.dart';

class SaleListingSyncedDetails extends StatefulWidget {

  //List<ItemModel> itemModels = <ItemModel>[];
  final String orderId ;
  SaleListingSyncedDetails({Key? key , required this.orderId}) : super(key: key);
  @override
  _SaleListingSyncedDetailsState createState() => _SaleListingSyncedDetailsState();
}

class _SaleListingSyncedDetailsState extends State<SaleListingSyncedDetails> {

  List<ItemModel> items = <ItemModel>[];


  initData() async{

      ItemDBHelper  itemDBHelper = new ItemDBHelper();
      List<SoList> tmp = await itemDBHelper.retrieveItemsByOrderId(int.parse(widget.orderId));

      tmp.forEach((element) {
        UomModel uomModel = new UomModel(
            uomId: element.orderId,
            itemId: element.orderId,
            uom: element.uom,
            price: element.unitprice,
            minPrice: element.smallestunitprice,
            maxPrice: element.smallestunitprice,
            isActive: 1,
            rev: 1,
            deleted: 1);

        ItemModel itemModel = new ItemModel(
            itemId: element.orderId,
            companyCode: element.itemcode,
            code: element.itemcode,
            description: element.description,
            taxType: element.taxtype,
            qty: int.parse(element.qty),
            isActive: 1,
            rev: 1,
            deleted: 0,
            uom: [uomModel]);

        setState(() {
          items.add(itemModel);
        });

      });
  }


  String getTotalPrice() {
    double total = 0;
    for(var i = 0;i < items.length; i++){
      total += double.parse(items[i].uom[0].price) * items[i].qty ;
    }
    return total.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    initData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
            children: [
              renderItemLists(),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text("Total(inc)", style: Theme.of(context).textTheme.bodyText2 ,)),
                    Text( getTotalPrice() , style: Theme.of(context).textTheme.bodyText1 )
                  ],
                ),
              ),
            ],
        )
      ),
    );
  }
  Widget renderItemLists(){
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index){
            return _buildItem(items[index], index);
          },
        )
    );
  }

  Widget _buildItem(ItemModel item, int index) {
    return InkResponse(
      onTap: () async{

      },
      child: Container(
          padding: EdgeInsets.only(left: 0, top: 5, bottom: 0,  right: 0),
          alignment: Alignment.centerLeft,
          child: Container(
            child: Container(
                margin: EdgeInsets.all(0),
                child: Column(

                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.description,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.qty.toString() + "CTN * " +  double.parse(item.uom[0].price).toStringAsFixed(2),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),


                    Divider()

                  ],

                )
            ),
          )
      ),
    );
  }


}
