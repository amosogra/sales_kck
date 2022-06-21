import 'dart:async';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:printer/printer.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftDBHelper.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftInvoiceDBHelper.dart';
import 'package:sales_kck/constants/app_storages.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';
import 'package:sales_kck/model/post/outstanding_model.dart';
import 'package:sales_kck/services/outstanding_ars_service.dart';
import 'package:sales_kck/services/temporary_receipt_service.dart';
import 'package:sales_kck/view/customer/CustomerList.dart';
import 'package:sales_kck/view/dialog/payment_method_dialog.dart';
import 'package:sales_kck/view/temporary/partial/TempInputForm.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sales_kck/view/temporary/partial/receipt_draft_section.dart';
import 'package:intl/intl.dart';
import 'package:sales_kck/view/temporary/temp_receipt_pending_page.dart';

class Receipt extends StatefulWidget {
  final TempDraftModel? model;
  const Receipt({Key? key, this.model}) : super(key: key);
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
  FocusNode chequeNoFocusNode = FocusNode();
  FocusNode paymentAmountFocusNode = FocusNode();
  String companyName = "Customer Name";
  List<OutstandingARS> draftInvoiceItems = <OutstandingARS>[];
  String companyCode = "";
  String accNo = "";

  Future<String> generateTRNumber() async {
    var rnd = Random();
    String number = '';
    for (int i = 0; i < 4; i++) {
      number = number + rnd.nextInt(9).toString();
    }
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMdd').format(now);
    var saleAgentsCode = await Storage.getSalesAgent();
    return "TR" + formattedDate + saleAgentsCode + number;
  }

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      chequeNoController.text = widget.model!.chequeNo;
      receiptNoController.text = widget.model!.receiptNo;
      receiptFromController.text = widget.model!.receiptFrom;
      receiptDateController.text = widget.model!.receiptDate;
      paymentDateController.text = widget.model!.paymentDate;
      paymentMethodController.text = widget.model!.paymentMethod;
      paymentAmountController.text = widget.model!.paymentAmount;
      companyName = widget.model!.receiptFrom;
      companyCode = widget.model!.companyCode;
      accNo = widget.model!.accNo;

      Future.delayed(Duration(seconds: 1), () async {
        await loadDraftData(widget.model!.accNo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text(Strings.temporary_receipt),
        ),
        bottomSheet: Container(alignment: Alignment.bottomCenter, height: 60, child: saveDraftButtonSection()),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: buildForm(),
                  )),
              Expanded(flex: 3, child: ReceiptDraftSection(models: draftInvoiceItems, paymentAmountController: paymentAmountController)),
            ],
          ),
        ));
  }

  buildForm() {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                  child: TempInputForm(
                      Strings.temporary_receipt_no, Strings.new_document, receiptNoFocusNode, receiptFromFocusNode, receiptNoController, false, TextInputType.text))
            ],
          ),
          InkResponse(
            onTap: () async {
              var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList()));
              if (result != null) {
                var number = await generateTRNumber();
                CustomerModel customerModel = CustomerModel.fromMap(result);
                setState(() {
                  companyName = customerModel.name;
                  receiptFromController.text = customerModel.name;
                  receiptNoController.text = number;
                  companyCode = customerModel.companyCode;
                  accNo = customerModel.accNo;
                });
                debugPrint("customerModel.accNo--" + customerModel.toMap().toString());
                loadDraftData(customerModel.accNo);
              }
            },
            child: Row(
              children: [
                Expanded(
                    child: TempInputForm(
                  Strings.receive_from,
                  companyName,
                  receiptFromFocusNode,
                  receiptDateFocusNode,
                  receiptFromController,
                  false,
                  TextInputType.text,
                )),
                Icon(
                  Icons.search,
                  color: MyColors.textBorderColor,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkResponse(
                    onTap: () {
                      DatePicker.showDatePicker(context, showTitleActions: true, minTime: DateTime(2018, 3, 5), maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                        print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        print('confirm $date');
                        receiptDateController.text = '$date'.substring(0, 10);
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: TempInputForm(
                        Strings.received_date, "Received Date", receiptDateFocusNode, paymentDateFocusNode, receiptDateController, false, TextInputType.text)),
              ),
              Expanded(
                child: InkResponse(
                    onTap: () {
                      DatePicker.showDatePicker(context, showTitleActions: true, minTime: DateTime(2018, 3, 5), maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                        print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        print('confirm $date');
                        paymentDateController.text = '$date'.substring(0, 10);
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: TempInputForm(
                        Strings.payment_date, "Payment Date", paymentDateFocusNode, paymentMethodFocusNode, paymentDateController, false, TextInputType.text)),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: InkResponse(
                onTap: () {
                  List<String> paymentMethodLists = [];
                  paymentMethodLists.add("BANK");
                  paymentMethodLists.add("CASH");
                  paymentMethodLists.add("CHEQUE");

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PaymentMethodDialog(
                            paymentMethodLists: paymentMethodLists,
                            clickSuccess: (value) {
                              paymentMethodController.text = value;
                              Navigator.pop(context);
                            });
                      });
                },
                child: TempInputForm(
                    Strings.payment_method, "Payment method", paymentMethodFocusNode, chequeNoFocusNode, paymentMethodController, false, TextInputType.text),
              )),
              Expanded(
                  child: TempInputForm(Strings.cheque_no, Strings.cheque_no, chequeNoFocusNode, paymentAmountFocusNode, chequeNoController, true, TextInputType.text))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: TempInputForm(
                      Strings.payment_amount, Strings.amount, paymentAmountFocusNode, paymentAmountFocusNode, paymentAmountController, true, TextInputType.number)),
              Expanded(child: Container())
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
              padding: EdgeInsets.only(left: 5, right: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: MyColors.primaryColor),
                onPressed: () async {
                  if (receiptNoController.text.isEmpty ||
                      receiptFromController.text.isEmpty ||
                      receiptDateController.text.isEmpty ||
                      paymentDateController.text.isEmpty ||
                      paymentMethodController.text.isEmpty ||
                      (chequeNoController.text.isEmpty && paymentMethodController.text == "CHEQUE") ||
                      paymentAmountController.text.isEmpty) {
                    showToastMessage(context, "Input Data - " + receiptFromController.text, "Ok");
                  } else {
                    saveData("draft");
                  }
                  //Navigator.pop(context);
                },
                child: Text("Save Draft"),
              ),
            )),
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: MyColors.primaryColor),
                  onPressed: () async {
                    Navigator.pop(context);
                    saveData("save");
                  },
                  child: Text("Save & Print"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isInvoiceSelected() {
    bool flag = false;
    for (var i = 0; i < draftInvoiceItems.length; i++) {
      if (draftInvoiceItems[i].isSelected) {
        flag = true;
      }
    }
    return flag;
  }

  Future loadDraftData(String accNo) async {
    List<OutstandingARS> response = await getOutstanding(context, accNo);
    response.sort((a, b) => -a.docDate.compareTo(b.docDate));
    if (response.isNotEmpty) {
      setState(() {
        draftInvoiceItems = response;
      });
    }
  }

  void saveData(type) async {
    if (companyCode.isNotEmpty && accNo.isNotEmpty && isInvoiceSelected()) {
      TempDraftModel model = new TempDraftModel(
        companyCode: companyCode,
        accNo: accNo,
        receiptNo: receiptNoController.text,
        receiptFrom: receiptFromController.text,
        receiptDate: receiptDateController.text,
        paymentDate: paymentDateController.text,
        paymentMethod: paymentMethodController.text,
        chequeNo: chequeNoController.text,
        paymentAmount: paymentAmountController.text,
        id: -1,
        isSaved: type == "save" ? '2' : '0',
      );

      TempDraftDBHelper dbHelper = new TempDraftDBHelper();
      List<TempDraftModel> items = <TempDraftModel>[];
      items.add(model);
      var id = await dbHelper.insertTemps(items);

      List<OutstandingARS> insertData = [];

      for (var i = 0; i < draftInvoiceItems.length; i++) {
        if (draftInvoiceItems[i].isSelected) {
          draftInvoiceItems[i].trId = id.toString();
          insertData.add(draftInvoiceItems[i]);
        }
        draftInvoiceItems[i].isSelected = false;
      }

      insertData.sort((a, b) => a.docDate.compareTo(b.docDate));

      // Save Invoice Data
      TempDraftInvoiceDBHelper invoiceHelper = new TempDraftInvoiceDBHelper();
      await invoiceHelper.insertTempInvoice(insertData);
//..........................print.............................
      var printer = Printer();
      await printer.start();
      await printer.setCopies(1);

      var companyModel = await Storage.getCompanyModel();
      await printer.printCenter(companyModel.displayName ?? '');
      await printer.printCenter("E-mail: ${companyModel.email}");
      await printer.printCenter(companyModel.website ?? '');
      //await printer.printCenter(text)

//..........................end................................

      showToastMessage(context, "Saved !!!", "Ok");
      companyCode = "";
      accNo = "";
      receiptNoController.text = "";
      receiptFromController.text = "";
      receiptDateController.text = "";
      paymentDateController.text = "";
      paymentMethodController.text = "";
      chequeNoController.text = "";
      paymentAmountController.text = "";

      if (type == "save") {
        String response = await saveTemporaryReceipt(context, model, "save");

        if (response == "true") {
          showToastMessage(context, "Create new Temporary Receipt.", "Ok");
        } else {
          showToastMessage(context, response, "Ok");
        }
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptPending()));
      }
    } else {
      showToastMessage(context, "Select Invoice Data", "Ok");
    }
  }
}
