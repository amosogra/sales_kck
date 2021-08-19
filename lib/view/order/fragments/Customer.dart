import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/pickers/radio_picker.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/TermModel.dart';
import 'package:sales_kck/services/TermService.dart';
import 'package:sales_kck/view/customer/CustomerList.dart';
import 'package:sales_kck/view/order/partial/CustomerItemView.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);
  @override
  _CustomerState createState() => _CustomerState();
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
    return SingleChildScrollView(
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
              child: Text(Strings.attention, style:  Theme.of(context).textTheme.headline1 ),
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
                    child: Text(Strings.terms , style:  Theme.of(context).textTheme.headline1 ),
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
                    child: Text(termModel.displayTerm.isEmpty? 'Select Term': termModel.displayTerm)
                  )

                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10) ,
              child: Row(
                children: [
                  Expanded(child:   Text( remark1 ,  style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text(  remark2 , style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),


            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text( remark3 , style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),

            Divider(color: MyColors.greyColor,),
            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text( remark4 , style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            //
            // showMaterialRadioPicker<TermModel>(
            //     context: context,
            //     items: terms
            // ),

          ],
        ),
      )
    );
  }
}
