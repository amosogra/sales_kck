

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/customer/CustomerList.dart';


class Customer extends StatefulWidget {

  const Customer({Key? key}) : super(key: key);
  @override
  _CustomerState createState() => _CustomerState();

}

class _CustomerState extends State<Customer> {
  String customerName = "Customer";
  String docNumber = '';
  String docDate = '';
  late String address1 = 'Address 1';
  late String address2 = 'Address 2';
  late String address3 = 'Address 3';
  late String address4 = 'Address 4';

  late String phoneNumber = 'Phone Number';
  late String remark1 = 'Remark 1';
  late String remark2 = 'Remark 2';
  late String remark3 = 'Remark 3';
  late String remark4 = 'Remark 4';

  goToCustomerLists() async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList() ));
    if(result != null){

      debugPrint(result.toString());
      debugPrint(result["name"]);

      setState(() {
        customerName = result['name'] + " - " +   result['accNo'];
        address1 = result['addr1'];
        address2 = result['addr2'];
        address3 = result['addr3'];
        address4 = result['addr4'];
        phoneNumber = result['phone1'];
      });
    }
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
            InkWell(
              onTap: (){
                this.goToCustomerLists();
              },
              child: Container(
                margin: EdgeInsets.only(top: 10) ,
                child: Row(
                  children: [
                    Expanded(child:   Text(customerName, style: Theme.of(context).textTheme.bodyText2 ), ) ,
                    Icon(Icons.search)
                  ],
                ),
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Row(
              children: [
                Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.doc_number, style: Theme.of(context).textTheme.headline2 ),
                        Text( docNumber , style: Theme.of(context).textTheme.bodyText2 ),
                        Divider(color: MyColors.greyColor,)
                      ],
                    ),
                ),
                Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.doc_date, style: Theme.of(context).textTheme.headline2 ),
                        Row(
                          children: [
                            Expanded(child:   Text( docDate , style: Theme.of(context).textTheme.bodyText2 ), ) ,
                            Icon(Icons.calendar_today)
                          ],
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
            Container(
              margin: EdgeInsets.only(top: 10) ,
              child: Row(
                children: [
                  Expanded(
                    child:   Text( address1 , style: Theme.of(context).textTheme.bodyText2 ,),
                  ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text( address2, style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),


            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text( address3 , style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),
            Container(
              margin: EdgeInsets.only(top: 5) ,
              child: Row(
                children: [
                  Expanded(child:   Text( address4 , style: Theme.of(context).textTheme.bodyText2 ,), ) ,
                  Icon(Icons.search)
                ],
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top:15),
              child: Text(Strings.attention, style:  Theme.of(context).textTheme.headline1 ),
            ),
            Text(Strings.phone_number , style:  Theme.of(context).textTheme.headline2 ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(Strings.phone_number, style:  Theme.of(context).textTheme.bodyText2 ),
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(Strings.terms , style:  Theme.of(context).textTheme.headline1 ),
                  ),
                  Text("Last date sat")
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

          ],
        ),
      )
    );
  }
}
