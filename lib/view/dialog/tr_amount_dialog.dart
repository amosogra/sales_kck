

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/view/order/partial/CustomerItemInput.dart';


class TrAmountDialog extends StatefulWidget {

  final String price;
  final void Function(dynamic) onClickSuccess;
  final void Function() onClickRemove;
  TrAmountDialog(this.price, this.onClickSuccess, this.onClickRemove);
  @override
  _TrAmountDialogState createState() => _TrAmountDialogState();
}

class _TrAmountDialogState extends State<TrAmountDialog> {

  late TextEditingController priceController = TextEditingController(text : widget.price);
  FocusNode priceNode = FocusNode();

  contentBox(context) {
    return Container(
      child: Column(
        children: [

          Container(
            alignment:Alignment.center,
            margin: EdgeInsets.only(top: 20, bottom: 10),
            child: Text("Paid Amount" , style: Theme.of(context).textTheme.bodyText2,),
          ),

          Container(
            alignment:Alignment.center,
            margin: EdgeInsets.only(top: 0, bottom: 10,left: 15, right: 15),
            child: CustomerItemInput(
              textInputType: TextInputType.number,
              controller: priceController, focusNode: priceNode, nextFocusNode: priceNode, hint: "Enter Price",
              onChange: (value){

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
                      widget.onClickRemove();
                      Navigator.pop(context);
                    },
                    child: Text(" Remove "),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                      style:  ElevatedButton.styleFrom(primary: MyColors.primaryColor ) ,
                      onPressed: () {
                        widget.onClickSuccess(widget.price);
                        Navigator.pop(context);

                      },
                      child: Text(" Ok "),
                    ),
                  )
                ],
              )

          )

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: contentBox(context),
        )
    );

  }
}
