import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/TermModel.dart';
import 'package:sales_kck/services/TermService.dart';
import 'package:sales_kck/view/customer/CustomerList.dart';
import 'package:sales_kck/view/order/pages/Order.dart';
import 'package:sales_kck/view/order/partial/CustomerItemInput.dart';
import 'package:sales_kck/view/order/partial/CustomerItemView.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:sales_kck/widget/LoginButton.dart';

class Customer extends StatefulWidget {

  @override
  _CustomerState createState() => _CustomerState();
  Customer({Key? key}) : super(key: key);

}

class _CustomerState extends State<Customer> {
  late CustomerModel customerModel = new CustomerModel(
    companyCode: '',accNo: '',name: '', addr1: '',addr2: '',addr3: '',addr4: '',
    attention: '', defDisplayTerm: '', taxType: '', phone1: '', phone2: '', isActive: 1,rev: 0,deleted: 0, custId: 0
  );
  late String remark1 = '';
  late String remark2 = '';
  late String remark3 = '';
  late String remark4 = '';

  TextEditingController remark1Controller = TextEditingController();
  TextEditingController remark2Controller = TextEditingController();
  TextEditingController remark3Controller = TextEditingController();
  TextEditingController remark4Controller = TextEditingController();

  FocusNode remark1FocusNode = FocusNode();
  FocusNode remark2FocusNode = FocusNode();
  FocusNode remark3FocusNode = FocusNode();
  FocusNode remark4FocusNode = FocusNode();

  TermModel termModel = new TermModel(
      termId: 0,
      companyCode: '',
      displayTerm: '',
      terms: '',
      isActive: 0
  );

  goToCustomerLists() async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList() ));
    if(result != null){
      setState(() {
        customerModel = CustomerModel.fromMap(result);
        this.loadTerms(customerModel.companyCode);
        debugPrint("called" + customerModel.companyCode);
      });
    }
  }
  List<TermModel> terms = <TermModel>[];

  void loadTerms(companyCode) async{
    List<TermModel> response = await getTerms(context, companyCode);
    if(response.length > 0){
      setState(() {
        terms = response;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer Info"),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Strings.customer, style: Theme.of(context).textTheme.headline2 , ),
                  CustomerItemView(
                      hintText: "Select Customer", title: customerModel.name + " - " + customerModel.accNo,
                      onTap: (){
                        this.goToCustomerLists();
                      }),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Strings.doc_number, style: Theme.of(context).textTheme.headline2 ),
                            Container(
                              height: 30,
                              padding: EdgeInsets.only(top: 10),
                              child: Text( customerModel.docNumber.isEmpty ? "Doc Number" : customerModel.docNumber ,
                                  style: TextStyle( fontSize: 14, color: customerModel.docNumber.isEmpty? MyColors.textBorderColor : MyColors.textColor, fontFamily: 'Ionicons',)
                              ),
                            ),
                            Divider(color: MyColors.greyColor,)
                          ],
                        ),
                      ),
                      Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Strings.doc_date, style: Theme.of(context).textTheme.headline2 ),
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child:Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text( customerModel.docDate.isEmpty ? "Doc Date" : customerModel.docDate ,
                                              style: TextStyle( fontSize: 14, color: customerModel.docDate.isEmpty? MyColors.textBorderColor : MyColors.textColor, fontFamily: 'Ionicons',)
                                          ),
                                        )
                                    ),
                                    Icon(Icons.calendar_today, color: MyColors.textBorderColor,)
                                  ],
                                ),
                              ),
                              Divider(color: MyColors.greyColor,)
                            ],
                          )
                      )
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(Strings.description, style:  Theme.of(context).textTheme.headline2 ),
                  ),

                  CustomerItemView(
                      hintText: "Address 1", title: customerModel.addr1,
                      onTap: (){
                      }),
                  CustomerItemView(
                      hintText: "Address 2", title: customerModel.addr2,
                      onTap: (){
                      }),
                  CustomerItemView(
                      hintText: "Address 3", title: customerModel.addr3,
                      onTap: (){
                      }),
                  CustomerItemView(
                      hintText: "Address 4", title: customerModel.addr4,
                      onTap: (){
                      }),

                  Container(
                    margin: EdgeInsets.only(top:15),
                    child: Text(Strings.attention, style:  Theme.of(context).textTheme.headline2 ),
                  ),

                  Text(Strings.phone_number , style:  Theme.of(context).textTheme.headline2 ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(customerModel.phone1.isEmpty ? Strings.phone_number : customerModel.phone1,
                        style:  TextStyle( fontSize: 14, color: customerModel.phone1.isEmpty? MyColors.textBorderColor : MyColors.textColor, fontFamily: 'Ionicons',)
                    ),
                  ),
                  Divider(color: MyColors.greyColor,),

                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(Strings.terms , style:  Theme.of(context).textTheme.headline2 ),
                        ),
                        InkWell(
                            onTap: (){
                              showMaterialRadioPicker<TermModel>(
                                context: context,
                                title: 'Pick Your Term',
                                items: terms,
                                transformer: (item) => item.displayTerm,
                                //selectedItem: terms.length > 0 ? terms[0] : '',
                                onChanged: (value) => setState(() => termModel = value),
                              );
                            },
                            child: termModel.termId == 0 && customerModel.custId != 0 ?
                            BlinkText(
                              termModel.displayTerm.isEmpty? 'Select Term': termModel.displayTerm,
                              beginColor: MyColors.textBorderColor,
                              endColor: MyColors.primaryColor,
                              times: 10,
                              duration: Duration(seconds: 1),
                              style: TextStyle(
                                  color: termModel.displayTerm.isEmpty ? MyColors.textGreyColor: MyColors.textColor
                              ),
                            ):
                            Text(
                              termModel.displayTerm.isEmpty? 'Select Term': termModel.displayTerm,
                              style: TextStyle(color: termModel.displayTerm.isEmpty ? MyColors.textGreyColor: MyColors.textColor),
                            )
                        )
                      ],
                    ),
                  ),

                  CustomerItemInput(controller: remark1Controller, focusNode: remark1FocusNode, nextFocusNode: remark2FocusNode, hint: "Remark 1",
                    onChange: (value){
                      setState(() {
                        remark1 = value!;
                      });
                    },),

                  CustomerItemInput(controller: remark2Controller, focusNode: remark2FocusNode, nextFocusNode: remark3FocusNode, hint: "Remark 2", onChange: (value){}),
                  CustomerItemInput(controller: remark3Controller, focusNode: remark3FocusNode, nextFocusNode: remark4FocusNode, hint: "Remark 3", onChange: (value){}),
                  CustomerItemInput(controller: remark4Controller, focusNode: remark4FocusNode, nextFocusNode: remark4FocusNode, hint: "Remark 4", onChange: (value){}),

                  if (remark1.isNotEmpty && customerModel.custId != 0 && termModel.termId != 0) Container(
                    margin: EdgeInsets.only(top: 30),
                    child: LoginButton(
                      title: Strings.next,
                      onPressed: (){

                        //widget.tabController.animateTo(1);
                        //widget.tabController.animateTo((widget.tabController.index + 1) % 2);
                        //DefaultTabController.of(context)!.animateTo(1);

                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            Order(
                              customerModel: customerModel,
                              termModel: termModel,
                              remark1: remark1,
                              remark2: remark2,
                              remark3: remark3,
                              remark4: remark4
                            )
                        ));

                      },
                    ),
                  ) else Container()
                ],
              ),
            )
        ),
      ),
    );
    
  }
}
