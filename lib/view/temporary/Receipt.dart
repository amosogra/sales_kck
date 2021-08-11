

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/temporary/partial/TempInputForm.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.temporary_receipt),
      ),
      body: Container(
        child: Column(
          children: [
            buildForm(),
            buildList(),
            Container(
              child: Row(
                children: [
                  Expanded(child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: MyColors.primaryColor ),
                    onPressed: (){

                    },
                    child: Text("Save Draft"),
                  ),),
                  Expanded(child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: MyColors.primaryColor ),
                    onPressed: (){
                    },
                    child: Text("Done and Save"),
                  ),)
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
                  child:TempInputForm(Strings.temporary_receipt_no , Strings.new_document)
              )
            ],
          ),

          Row(
            children: [
              Expanded(
                  child:TempInputForm(Strings.receive_from , Strings.company_name)
              ),
              Icon(Icons.search),
            ],
          ),

          Row(
            children: [
              Expanded(
                  child:TempInputForm(Strings.received_date , "")
              ),
              Expanded(
                  child:TempInputForm(Strings.payment_date , "")
              )
            ],
          ),

          Row(
            children: [
              Expanded(
                  child:TempInputForm(Strings.payment_method , "")
              ),
              Expanded(
                  child:TempInputForm(Strings.cheque_no , Strings.cheque_no)
              )
            ],
          ),

          Row(
            children: [
              Expanded(
                  child:TempInputForm(Strings.payment_amount , Strings.amount)
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
      child: Row(
        children: [
          Expanded(child: Text(Strings.date),),
          Expanded(child: Text(Strings.invoice_number),),
          Expanded(child: Text(Strings.outstanding_amt),)
        ],
      ),
    );
  }

}
