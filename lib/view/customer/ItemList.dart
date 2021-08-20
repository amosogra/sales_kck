
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/services/ItemService.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/widget/InputForm.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  String searchKey = '';
  List<ItemModel> items = <ItemModel>[];
  void loadItems() async{
    List<ItemModel> response = await getItems(context);
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
        title: Text(Strings.item_listing),
        backgroundColor: MyColors.primaryColor,
      ),

      body: Container(
        child: Column(

          children: [
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          InputForm(myHint: "Search Item", validateFunction: (value){
                            return Validations.validateEmpty(value!);
                          },
                            onChange: (value){},
                          ),
                          Divider(color: MyColors.greyColor,)
                        ],
                      )
                  ),
                  searchKey == '' ? Icon(Icons.search) : Icon(Icons.close)
                ],
              ),
            ),

            Flexible(
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

          ],
        )

      )
    );
  }

  Widget _buildItem(ItemModel item, int index) {

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
                    item.code,
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
