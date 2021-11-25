import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/view/customer/ItemList.dart';
import 'package:sales_kck/view/order/pages/Summary.dart';
import 'package:sales_kck/widget/LoginButton.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/TermModel.dart';

class Order extends StatefulWidget {
  CustomerModel customerModel;
  TermModel termModel;
  String remark1 , remark2, remark3, remark4;
  Order({Key? key , required this.customerModel, required this.termModel, required this.remark1, required this.remark2,required this.remark3, required this.remark4 }) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {

  List<ItemModel> items = <ItemModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(items.length.toString());
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
                      var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ItemList() ));

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
        //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
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
                        child: Text( item.uom[0].price.toString() , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
                      )
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      Text("Tax Rae", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
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
                        child: Text( (double.parse(item.uom[0].price) * item.qty).toString() , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
                      )
                    ],
                  ),
                ),

                Divider(color: MyColors.greyColor,)

              ],

            )
          ),
        )
      ),
    );
  }


}

