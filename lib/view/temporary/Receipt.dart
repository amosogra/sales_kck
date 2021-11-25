

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftDBHelper.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';
import 'package:sales_kck/view/temporary/partial/TempInputForm.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);
  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {

  late TextEditingController receiptNoController = TextEditingController();
  late TextEditingController receiptFromController = TextEditingController();
  late TextEditingController receiptDateController = TextEditingController();
  late TextEditingController paymentDateController = TextEditingController();
  late TextEditingController paymentMethodController = TextEditingController();
  late TextEditingController chequeNoController = TextEditingController();
  late TextEditingController paymentAmountController = TextEditingController();

  FocusNode receiptNoFocusNode = FocusNode();
  FocusNode receiptFromFocusNode = FocusNode();
  FocusNode receiptDateFocusNode = FocusNode();
  FocusNode paymentDateFocusNode = FocusNode();
  FocusNode paymentMethodFocusNode = FocusNode();
  FocusNode chequeNoFocusNode =  FocusNode();
  FocusNode paymentAmountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.temporary_receipt),
      ),

      body: SingleChildScrollView(

        child: Column(
          children: [
            buildForm(),
            buildList(),
            Container(
              margin: EdgeInsets.only(left: 25, right:25 , top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: MyColors.primaryColor ),
                        onPressed: (){

                          if(receiptNoController.text.isEmpty || receiptFromController.text.isEmpty || receiptDateController.text.isEmpty
                          || paymentDateController.text.isEmpty || paymentMethodController.text.isEmpty || chequeNoController.text.isEmpty
                          || paymentAmountController.text.isEmpty){

                            showToastMessage(context, "Input Data", "Ok");

                          }else{

                            TempDraftModel model = new TempDraftModel(receiptNo: receiptNoController.text
                                , receiptFrom: receiptFromController.text, receiptDate: receiptDateController.text
                                , paymentDate: paymentDateController.text, paymentMethod: paymentMethodController.text
                                , chequeNo: chequeNoController.text, paymentAmount: paymentAmountController.text);

                            TempDraftDBHelper dbHelper = new TempDraftDBHelper();
                            List<TempDraftModel> items =  <TempDraftModel>[];
                            items.add(model);
                            dbHelper.insertTemps(items);

                            showToastMessage(context, "Saved !!!", "Ok");
                          }

                          //Navigator.pop(context);
                        },
                        child: Text("Save Draft"),
                      ),
                    )
                  ),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: MyColors.primaryColor ),
                        onPressed: (){
                        },
                        child: Text("Done and Save"),
                      ),
                    )
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  buildForm(){
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                  child:TempInputForm(Strings.temporary_receipt_no
                      , Strings.new_document
                      , receiptNoFocusNode
                      , receiptFromFocusNode
                      , receiptNoController)
              )
            ],
          ),

          Row(
            children: [
              Expanded(
                  child:TempInputForm(Strings.receive_from
                      , Strings.company_name
                      , receiptFromFocusNode
                      , receiptDateFocusNode
                      , receiptFromController)
              ),
              Icon(Icons.search , color: MyColors.textBorderColor ,),
            ],
          ),

          Row(
            children: [
              Expanded(
                  child:TempInputForm(Strings.received_date , "Received Date", receiptDateFocusNode, paymentDateFocusNode, receiptDateController)
              ),
              Expanded(
                  child:TempInputForm(Strings.payment_date , "Payment Date", paymentDateFocusNode, paymentMethodFocusNode, paymentDateController)
              )
            ],
          ),

          Row(
            children: [
              Expanded(
                  child:TempInputForm(Strings.payment_method , "Payment method", paymentMethodFocusNode, chequeNoFocusNode , paymentMethodController)
              ),
              Expanded(
                  child:TempInputForm(Strings.cheque_no , Strings.cheque_no , chequeNoFocusNode, paymentAmountFocusNode, chequeNoController)
              )
            ],
          ),

          Row(
            children: [
              Expanded(
                  child:TempInputForm(Strings.payment_amount , Strings.amount, paymentAmountFocusNode, paymentAmountFocusNode , paymentAmountController)
              ),
              Expanded(
                  child:Container()
              )
            ],
          ),

        ],
      ),
    );
  }

  buildList(){
    return Container(
      color: MyColors.primaryColor,
      padding: EdgeInsets.only(top: 20, bottom: 20),
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

}
