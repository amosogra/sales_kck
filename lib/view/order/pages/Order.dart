import 'package:flutter/material.dart';
import 'package:sales_kck/constants/DBHelper/ItemDBHelper.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/dimens.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/SoList.dart';
import 'package:sales_kck/model/post/UomModel.dart';
import 'package:sales_kck/view/customer/ItemList.dart';
import 'package:sales_kck/view/dialog/ItemListConfirmDialog.dart';
import 'package:sales_kck/view/order/pages/Summary.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/TermModel.dart';

class Order extends StatefulWidget {

  final String type;
  final String orderId;
  final CustomerModel customerModel;
  final TermModel termModel;
  final String remark1 , remark2, remark3, remark4;

  Order({
    Key? key ,
    required this.type,
    required this.orderId,
    required this.customerModel,
    required this.termModel,
    required this.remark1,
    required this.remark2,
    required this.remark3,
    required this.remark4
  }) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {

  List<ItemModel> items = <ItemModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();

  }

  initView() async{

    if(widget.type == "edit"){

      ItemDBHelper  itemDBHelper = new ItemDBHelper();
      List<SoList> tmp = await itemDBHelper.retrieveItemsByOrderId(int.parse(widget.orderId)) as List<SoList>;

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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item Info"),
      ),
      body: Scaffold(
        body: Container(
            child: items.length > 0 ?
            buildItemLists()
                :
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(Assets.iconEdit) , width: 70, ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(Strings.not_add_order, style: TextStyle(color: MyColors.textBorderColor)),
                  )
                ],
              ),
            )
        ),

        bottomNavigationBar: Container(
            height: 120,
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginButton(
                    title: Strings.add_item,
                    onPressed: () async{
                      var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ItemList(pageType: "order",) ));
                      if(result != null){
                        setState(() {
                          ItemModel itemModel = ItemModel.fromMap(result);
                          items.add(itemModel);
                        });
                      }

                    },
                  ),

                  Padding(padding: EdgeInsets.all(5)),
                  items.length > 0 ?
                  LoginButton(
                    title: items.length > 0 ? "Next" : Strings.add_item,
                    onPressed: () async{
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          Summary(
                            customerModel: widget.customerModel,
                            termModel: widget.termModel,
                            remark1: widget.remark1,
                            remark2: widget.remark2,
                            remark3: widget.remark3,
                            remark4: widget.remark4,
                            itemModels: this.items,
                          )
                      ));
                    },
                  ):
                      Container()
                ],
              )
            )
        ),
      ),
    );
  }

  buildItemLists(){
    return Container(
      margin: EdgeInsets.only(top: 30),
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
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5,  right: 10),
        alignment: Alignment.centerLeft,
        child: Card(
          child: Container(
            margin: EdgeInsets.all(20),
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
                  child: Row(
                    children: [
                      Expanded(
                          child: renderLeftPanel(item)
                      ),
                      Container(
                        child: InkResponse(
                          onTap: (){

                            showDialog(context: context,
                                builder: (BuildContext context){
                                  List<String> uoms = <String>[];
                                  item.uom.forEach((element) {
                                    uoms.add(element.uom);
                                  });
                                  return ItemListConfirmDialog(
                                      item.uom[0].price,
                                      uoms,
                                      item,
                                      "Success",
                                          (qty, price){
                                        Navigator.pop(context);
                                        debugPrint(item.toMap().toString());
                                        setState(() {
                                          item.qty = int.parse(qty);
                                          item.uom[0].price = price;
                                        });
                                      }
                                  );
                                }
                            );

                          },
                          child: Image(image: AssetImage(Assets.iconEdit) , width: Dimens.menuIconSize, height: Dimens.menuIconSize, )

                        )
                      ),

                      // remove icon
                      Container(
                        margin: EdgeInsets.only(left: 10),
                          child: InkResponse(
                              onTap: (){
                                setState(() {
                                  items.removeAt(index);
                                });
                              },
                              child: Image(image: AssetImage(Assets.iconTrash) , width: Dimens.menuIconSize, height: Dimens.menuIconSize, )

                          )
                      )

                    ],
                  ),
                ),
                //Divider(color: MyColors.greyColor,)

              ],

            )
          ),
        )
      ),
    );
  }

  Widget renderLeftPanel(ItemModel item){
    return Container(
      child: Column(
        children: [

          Container(
            child: Row(
              children: [
                Text("Quantity", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text( item.qty.toString() + "CTN", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
                )
              ],
            ),
          ),

          Container(
            child: Row(
              children: [
                Text("Unit Price", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(  item.uom[0].price == "" ? "0.00" : double.parse(item.uom[0].price).toStringAsFixed(2) , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
                )
              ],
            ),
          ),

          Container(
            child: Row(
              children: [
                Text("Tax Rate", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text( "0%" , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
                )
              ],
            ),
          ),

          Container(
            child: Row(
              children: [
                Text("Tax Amount", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text( item.taxType , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
                )
              ],
            ),
          ),

          Container(
            child: Row(
              children: [
                Text("Total Cost", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text( (double.parse(item.uom[0].price) * item.qty).toStringAsFixed(2) , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }


}

