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
            height: 100,
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
        padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
        //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item.code,
                style: TextStyle(fontSize: 14),
              ),
            ),

            Divider(color: MyColors.greyColor,)

          ],
        ),
      ),
    );
  }


}
