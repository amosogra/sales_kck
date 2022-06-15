
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/model/post/outstanding_model.dart';
import 'package:sales_kck/view/dialog/tr_amount_dialog.dart';

class ReceiptDraftSection extends StatefulWidget {

  final List<OutstandingARS> models;
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
                child: Column(
                  children: [
                    Text(Strings.invoice_number , style: TextStyle(color: MyColors.whiteColor, fontSize: 13)),
                    Text("Number" , style: TextStyle(color: MyColors.whiteColor, fontSize: 13)),
                  ],
                ),
              )
          ),

          Container(
              margin: EdgeInsets.only(right: 10),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(Strings.outstanding_amt , style: TextStyle(color: MyColors.whiteColor, fontSize: 13)),
                    Text("AMT" , style: TextStyle(color: MyColors.whiteColor, fontSize: 13)),
                  ],
                ),
              )
          )

        ],
      ),
    );
  }

  Widget _buildItem(OutstandingARS model, int index) {
    return InkWell(
      onTap: (){



        showDialog(context: context,
            builder: (BuildContext context){
              return TrAmountDialog(model.outstandingAmount, (price) {
                setState(() {
                  model.isSelected = true;//!model.isSelected;
                });
              }, (){
                setState(() {
                  model.isSelected = false;
                });
              });
            }
        );
        
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 10),
        color:  model.isSelected ? MyColors.greyColor : MyColors.whiteColor,
        child: Row(
          children: [
            Container(
              child: Checkbox(
                value: model.isSelected, onChanged: (bool? value) {  },
              ),
            ),
            Container(
                child: Container(
                  alignment: Alignment.center,
                  child: Text( model.docDate.substring(0,10) , style: TextStyle(color: MyColors.blackColor, fontSize: 12),),
                )
            ),
            Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(model.docNo , style: TextStyle(color: MyColors.blackColor, fontSize: 12)),
                )
            ),

            Container(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(model.outstandingAmount , style: TextStyle(color: MyColors.blackColor, fontSize: 12)),
                )
            )

          ],
        ),
      ),
    );
  }




  void onClickRemove() {

  }

}
