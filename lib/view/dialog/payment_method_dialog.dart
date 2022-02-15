

import 'package:flutter/material.dart';

class PaymentMethodDialog extends StatefulWidget {

  final List<String> paymentMethodLists;
  final void Function(dynamic) clickSuccess;

  const PaymentMethodDialog({Key? key,
    required this.paymentMethodLists,
    required this.clickSuccess}) : super(key: key);

  @override
  _PaymentMethodDialogState createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.paymentMethodLists.length,
            itemBuilder: (context, index){
              return _buildItem(widget.paymentMethodLists[index], index);
            }
        )
      ],
    );
  }

  _buildItem(String paymentItem, int index) {
    return InkWell(
      onTap: () async{
        widget.clickSuccess(paymentItem);
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
        //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    paymentItem,
                    style: TextStyle(fontSize: 14),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
