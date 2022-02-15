
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/UomModel.dart';
import 'package:sales_kck/view/order/partial/CustomerItemInput.dart';

class ItemListConfirmDialog extends StatefulWidget {

  final List<String> uoms;
  final ItemModel itemModel;
  final String title;
  final String price;
  final void Function(dynamic, dynamic) clickSuccess;

  ItemListConfirmDialog(this.price , this.uoms, this.itemModel, this.title , this.clickSuccess  );
  //const ItemListConfirmDialog({Key? key}) : super(key: key);
  @override
  _ItemListConfirmDialogState createState() => _ItemListConfirmDialogState();
}


class _ItemListConfirmDialogState extends State<ItemListConfirmDialog> {

  String _selectedLocation = 'A';
  late TextEditingController priceController = TextEditingController(text : initialPrice());
  FocusNode priceNode = FocusNode();
  late TextEditingController qtyController = TextEditingController(text: widget.itemModel.qty != null ? widget.itemModel.qty.toString() : '');
  FocusNode qtyFocus = FocusNode();
  bool isFilled = false;

  String minPrice = "";
  String maxPrice = "";

  String initialPrice(){
    if(widget.price.isNotEmpty){
      return widget.price;
    }
    return widget.itemModel.uom.length > 0 && double.parse(widget.itemModel.uom[0].minPrice) != -1 ? double.parse(widget.itemModel.uom[0].minPrice).toStringAsFixed(2) : '';
  }

  String showPrice(price){
    if(price == -1){
      return "Not Define";
    }
    return price.toStringAsFixed(2);
  }

  contentBox(context){
    return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black,offset: Offset(0,10),
                      blurRadius: 10
                  ),
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment:Alignment.center,
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(widget.itemModel.code , style: Theme.of(context).textTheme.bodyText2,),
                ),

                Container(
                  alignment:Alignment.center,
                  margin: EdgeInsets.only(top: 0, bottom: 10,left: 15, right: 15),
                  child: Text(widget.itemModel.description , style: Theme.of(context).textTheme.bodyText2,),
                ),

                Container(
                  alignment:Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 0, bottom: 0,left: 25, right: 15),
                  child: Text("Min Price: " + showPrice(double.parse(minPrice)) + " Max Price: "  + showPrice(double.parse(maxPrice)) , style: TextStyle(fontSize: 12)),
                ),

                Container(
                  alignment:Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 0, bottom: 0,left: 25, right: 15),
                  child: Text("Uom" , style: TextStyle(fontSize: 12)),
                ),

                Container(
                  alignment:Alignment.center,
                  margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                  child: DropdownButton<String>(
                    hint: Text('Please choose a location'),
                    value: widget.uoms[0],
                    items: widget.uoms.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        debugPrint(newValue);
                        _selectedLocation = newValue.toString();
                        for(var i = 0; i < widget.itemModel.uom.length; i++){
                          if(widget.itemModel.uom[i].uom == newValue){
                            minPrice = widget.itemModel.uom[i].minPrice;
                            maxPrice = widget.itemModel.uom[i].maxPrice;
                          }
                        }

                      });
                    },
                  ),
                ),

                Container(
                  alignment:Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 0, bottom: 0,left: 25, right: 15),
                  child: Text("Qty" , style: TextStyle(fontSize: 12)),
                ),
                Container(
                  alignment:Alignment.center,
                  margin: EdgeInsets.only(top: 0, bottom: 10,left: 15, right: 15),
                  child: CustomerItemInput(
                    textInputType: TextInputType.number,
                    controller: qtyController, focusNode: qtyFocus, nextFocusNode: priceNode, hint: "Enter Qty",
                    onChange: (value){
                      setState(() {

                        if(qtyController.text.isNotEmpty && priceController.text.isNotEmpty && double.parse(minPrice) <= double.parse(priceController.text)
                            && ( double.parse(priceController.text) < double.parse(maxPrice) ||  double.parse(maxPrice) == -1 )){
                          this.isFilled = true;
                        }else{
                          this.isFilled = false;
                        }
                      });
                    },
                  ),
                ),

                Container(
                  alignment:Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 0, bottom: 0,left: 25, right: 15),
                  child: Text("U/Price" , style: TextStyle(fontSize: 12)),
                ),
                Container(
                  alignment:Alignment.center,
                  margin: EdgeInsets.only(top: 0, bottom: 10,left: 15, right: 15),
                  child: CustomerItemInput(
                    textInputType: TextInputType.number,
                    controller: priceController, focusNode: priceNode, nextFocusNode: priceNode, hint: "Enter Price",
                    onChange: (value){
                      setState(() {
                        debugPrint(value);
                        debugPrint(double.parse(minPrice).toString());
                        if(qtyController.text.isNotEmpty && double.parse(minPrice) < double.parse(value!)
                            && (double.parse(value) < double.parse(maxPrice) || double.parse(maxPrice) == -1)){
                          this.isFilled = true;
                        }else{
                          this.isFilled = false;
                        }
                      });
                    },
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: MyColors.primaryColor ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(" Cancel "),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: ElevatedButton(
                          style: this.isFilled ?  ElevatedButton.styleFrom(primary: MyColors.primaryColor ) : ElevatedButton.styleFrom(primary: MyColors.greyColor ),
                          onPressed: () {
                            if(this.isFilled){
                              widget.clickSuccess( qtyController.text , priceController.text);
                            }
                          },
                          child: Text("Add to Cart"),
                        ),
                      )
                    ],
                  )

                )
              ],
            )
          )
        ]
    );
  }

  @override
  Widget build(BuildContext context) {

    minPrice = widget.itemModel.uom.length > 0 ? widget.itemModel.uom[0].minPrice : "0";
    maxPrice = widget.itemModel.uom.length > 0 ? widget.itemModel.uom[0].maxPrice : "0";

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: contentBox(context),
      )
    );

  }
}
