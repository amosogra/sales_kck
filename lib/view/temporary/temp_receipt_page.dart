import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftDBHelper.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';
import 'package:sales_kck/view/customer/CustomerList.dart';
import 'package:sales_kck/view/dialog/payment_method_dialog.dart';
import 'package:sales_kck/view/temporary/partial/TempInputForm.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sales_kck/view/temporary/partial/receipt_draft_section.dart';

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
  String companyName = "Customer Name";
  List<TempDraftModel> draftItems =  <TempDraftModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDraftData();
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.temporary_receipt),
      ),

      bottomSheet: Container(
        alignment: Alignment.bottomCenter,
        height: 90,
        child: saveDraftButtonSection()
      ),

      body: Container(

          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[

              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: buildForm(),
                )
              ),
              Expanded(
                flex: 3,
                child: ReceiptDraftSection(models: draftItems)
              ),
            ],

          ),

      )
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
                      , receiptNoController, true, TextInputType.text)
              )
            ],
          ),

         InkResponse(
           onTap: () async{
             var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList() ));
             if(result != null){
               setState(() {
                 CustomerModel customerModel = CustomerModel.fromMap(result);
                 setState(() {
                   companyName = customerModel.name;
                   receiptFromController.text = customerModel.name;
                 });
               });
             }
           },
           child:  Row(
             children: [
               Expanded(
                   child:TempInputForm(Strings.receive_from
                       , companyName
                       , receiptFromFocusNode
                       , receiptDateFocusNode
                       , receiptFromController, false, TextInputType.text)
               ),
               Icon(Icons.search , color: MyColors.textBorderColor ,),
             ],
           ),
         ),

          Row(
            children: [
              Expanded(
                  child:InkResponse(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2025, 6, 7),
                            onChanged: (date) {
                              print('change $date in time zone ' +
                                  date.timeZoneOffset.inHours.toString());
                            }, onConfirm: (date) {
                              print('confirm $date');
                              receiptDateController.text = '$date'.substring(0,10);
                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: TempInputForm(Strings.received_date , "Received Date", receiptDateFocusNode, paymentDateFocusNode, receiptDateController, false, TextInputType.text)
                  ),
              ),

              Expanded(
                child:InkResponse(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2025, 6, 7),
                          onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            print('confirm $date');
                            paymentDateController.text = '$date'.substring(0,10);
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: TempInputForm(Strings.payment_date , "Payment Date", paymentDateFocusNode, paymentMethodFocusNode, paymentDateController, false , TextInputType.text)
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                  child: InkResponse(
                    onTap: (){
                      List<String> paymentMethodLists = [];
                      paymentMethodLists.add("Bank");
                      paymentMethodLists.add("Cash");

                      showDialog(context: context,
                          builder: (BuildContext context){
                            return PaymentMethodDialog(paymentMethodLists: paymentMethodLists, clickSuccess: (value){
                              paymentMethodController.text =  value;
                              Navigator.pop(context);
                            });
                          }
                      );

                    },
                    child: TempInputForm(Strings.payment_method , "Payment method", paymentMethodFocusNode, chequeNoFocusNode , paymentMethodController, false , TextInputType.text),
                  )
              ),
              Expanded(
                  child:TempInputForm(Strings.cheque_no , Strings.cheque_no , chequeNoFocusNode, paymentAmountFocusNode, chequeNoController, true , TextInputType.text)
              )
            ],
          ),

          Row(
            children: [
              Expanded(
                  child:TempInputForm(Strings.payment_amount , Strings.amount, paymentAmountFocusNode, paymentAmountFocusNode , paymentAmountController, true, TextInputType.number)
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

  saveDraftButtonSection() {
    return Container(

      //bottom: 80,
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: MyColors.primaryColor ),
                    onPressed: () async{
                      if(receiptNoController.text.isEmpty || receiptFromController.text.isEmpty || receiptDateController.text.isEmpty
                          || paymentDateController.text.isEmpty || paymentMethodController.text.isEmpty || chequeNoController.text.isEmpty
                          || paymentAmountController.text.isEmpty){
                        showToastMessage(context, "Input Data - " + receiptFromController.text, "Ok");
                      }else{
                        TempDraftModel model = new TempDraftModel(receiptNo: receiptNoController.text
                            , receiptFrom: receiptFromController.text, receiptDate: receiptDateController.text
                            , paymentDate: paymentDateController.text, paymentMethod: paymentMethodController.text
                            , chequeNo: chequeNoController.text, paymentAmount: paymentAmountController.text, id: -1, isSaved: '0');

                        TempDraftDBHelper dbHelper = new TempDraftDBHelper();
                        List<TempDraftModel> items =  <TempDraftModel>[];
                        items.add(model);
                        dbHelper.insertTemps(items);
                        showToastMessage(context, "Saved !!!", "Ok");

                        List<TempDraftModel> response = await dbHelper.retrieveTemps() as List<TempDraftModel>;
                        if(response.length > 0){
                          setState(() {
                            draftItems = response;
                          });
                        }
                      }
                      //Navigator.pop(context);
                    },
                    child: Text("Save Draft"),
                  ),
                )
            ),

            Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: MyColors.primaryColor ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Done and Save"),
                  ),
                )
            )
          ],
        ),
      )
    );

  }

  void loadDraftData() async{
    TempDraftDBHelper dbHelper = new TempDraftDBHelper();
    List<TempDraftModel> response = await dbHelper.retrieveTemps() as List<TempDraftModel>;
    if(response.length > 0){
      setState(() {
        draftItems = response;
      });
    }
  }



}
