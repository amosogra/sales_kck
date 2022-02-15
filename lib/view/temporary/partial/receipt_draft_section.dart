
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';

class ReceiptDraftSection extends StatefulWidget {

  final List<TempDraftModel> models;
  ReceiptDraftSection({Key? key , required this.models}) : super(key: key);
  @override
  _ReceiptDraftSectionState createState() => _ReceiptDraftSectionState();
}

class _ReceiptDraftSectionState extends State<ReceiptDraftSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildList(),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.models.length,
                itemBuilder: (context, index){
                  return _buildItem(widget.models[index], index);
                }
            ),
          )
        ],
      ),
    );
  }

  buildList(){
    return Container(
      color: MyColors.primaryColor,
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(Strings.date , style: TextStyle(color: MyColors.whiteColor, fontSize: 13),),
              )
          ),
          Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Text(Strings.invoice_number , style: TextStyle(color: MyColors.whiteColor, fontSize: 13)),
              )
          ),

          Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Text(Strings.outstanding_amt , style: TextStyle(color: MyColors.whiteColor, fontSize: 13)),
              )
          )

        ],
      ),
    );
  }

  Widget _buildItem(TempDraftModel model, int index) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text( model.paymentDate , style: TextStyle(color: MyColors.blackColor, fontSize: 12),),
              )
          ),
          Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Text(model.receiptNo , style: TextStyle(color: MyColors.blackColor, fontSize: 12)),
              )
          ),

          Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Text(model.chequeNo , style: TextStyle(color: MyColors.blackColor, fontSize: 12)),
              )
          )

        ],
      ),
    );
  }



}
