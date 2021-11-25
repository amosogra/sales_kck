
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/services/ItemService.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/dialog/ItemListConfirmDialog.dart';
import 'package:sales_kck/widget/InputForm.dart';
import 'package:sales_kck/constants/globals.dart' as globals;


class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  String searchKey = '';
  final myController = TextEditingController();

  List<ItemModel> originalItems = <ItemModel>[];
  List<ItemModel> items = <ItemModel>[];

  void _printLatestValue() {
    searchItem('${myController.text}');
  }

  void loadItems() async{
    List<ItemModel> response = await getItems(context);
    if(response.length > 0){
      setState(() {
        originalItems = response;
        items = response;
        globals.items = response;
      });
    }
  }

  void searchItem(String key) {

    List<ItemModel> tmp = <ItemModel>[];
    originalItems.forEach((element) {
      if(element.companyCode.toLowerCase().contains(key.toLowerCase()) || element.code.toLowerCase().contains(key.toLowerCase())  || element.description.toLowerCase().contains(key.toLowerCase()) ){
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

      if(globals.items.length == 0){
        loadItems();
      }else{
        setState(() {
          originalItems =  globals.items;
          items = globals.items;
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
                          InputForm(
                            controller: myController,
                            myHint: "Search Item", validateFunction: (value){
                            return Validations.validateEmpty(value!);
                          },
                            onChange: (value){},
                          ),
                          Divider(color: MyColors.greyColor,)
                        ],
                      )
                  ),
                  searchKey == '' ? Icon(Icons.search, color: MyColors.textGreyColor,) : Icon(Icons.close)
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


        showDialog(context: context,
            builder: (BuildContext context){
              List<String> uoms = <String>[];
              item.uom.forEach((element) {
                uoms.add(element.uom);
              });

              return ItemListConfirmDialog(
                  uoms,
                  item,
                  "Success",
                      (value){

                    Navigator.pop(context);
                    debugPrint(item.toMap().toString());
                    item.qty = int.parse(value);
                    debugPrint(item.toMap().toString());

                    Navigator.pop(context, item.toMap() );

                  }
              );
            }
        );

        // debugPrint(item.toMap().toString());
        // debugPrint(item.uom.toList().toString());
        // Navigator.pop(context, item.toMap());

      },
      child: Card(
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
          //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: Text(
                              item.description.trimLeft(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item.code,
                              style: TextStyle(fontSize: 12),
                            ),
                          )

                        ],
                      )
                  )
              ),
            ],
          ),
        ),
      )
    );
  }

}
