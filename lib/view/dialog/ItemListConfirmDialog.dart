
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/UomModel.dart';
import 'package:sales_kck/view/order/partial/CustomerItemInput.dart';

class ItemListConfirmDialog extends StatefulWidget {

  List<String> uoms;
  ItemModel itemModel;
  final String title;
  void Function(dynamic) clickSuccess;

  ItemListConfirmDialog(this.uoms, this.itemModel, this.title , this.clickSuccess );
  //const ItemListConfirmDialog({Key? key}) : super(key: key);
  @override
  _ItemListConfirmDialogState createState() => _ItemListConfirmDialogState();

}

class _ItemListConfirmDialogState extends State<ItemListConfirmDialog> {

  String _selectedLocation = 'A';
  late TextEditingController priceController = TextEditingController(text : widget.itemModel.uom.length > 0 ? widget.itemModel.uom[0].price : '');
  FocusNode priceNode = FocusNode();
  late TextEditingController qtyController = TextEditingController(text: '');
  FocusNode qtyFocus = FocusNode();
  bool isFilled = false;

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
                        _selectedLocation = newValue.toString();
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
                        if(qtyController.text.isNotEmpty){
                          this.isFilled = true;
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
                      });
                    },
                  ),
                ),


                // DropdownButton(
                //   hint: Text('Please choose a location'), // Not necessary for Option 1
                //   value: _selectedLocation,
                //   onChanged: (newValue) {
                //     setState(() {
                //       _selectedLocation = newValue.toString();
                //     });
                //   },
                //   items: _locations.map((location) {
                //     return DropdownMenuItem(
                //       child: new Text(location),
                //       value: location,
                //     );
                //   }).toList(),
                // ),


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
                            if(qtyController.text.isNotEmpty){
                              widget.clickSuccess( qtyController.text);
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

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );


    //
    // return Container(
    //   child: Container(
    //       // margin: EdgeInsets.only(top: 40, bottom: 50, left: 30, right: 30),
    //       color: MyColors.bgColor,
    //       child: Column(
    //         children: [
    //           Text(widget.title , style: Theme.of(context).textTheme.bodyText2,),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               ElevatedButton(
    //                 onPressed: (){
    //                   Navigator.pop(context);
    //                 },
    //                 child: Text("Cancel"),
    //               ),
    //
    //               Container(
    //                 margin: EdgeInsets.only(left: 20),
    //                 child: ElevatedButton(
    //                   onPressed: (){
    //                     Navigator.pop(context);
    //                   },
    //                   child: Text("Done"),
    //                 ),
    //               )
    //             ],
    //           )
    //
    //
    //         ],
    //       ),
    //   ),
    // );
  }
}
