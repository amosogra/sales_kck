

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/TermModel.dart';
import 'package:sales_kck/services/OrderService.dart';
import 'package:sales_kck/widget/LoginButton.dart';

class Summary extends StatefulWidget {

  CustomerModel customerModel;
  TermModel termModel;
  String remark1, remark2, remark3, remark4;
  List<ItemModel> itemModels = <ItemModel>[];

  Summary({Key? key ,required this.customerModel, required this.termModel, required this.remark1, required this.remark2, required this.remark3,
  required this.remark4, required this.itemModels }) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.summary),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text("Document", style: Theme.of(context).textTheme.bodyText2 ,)),
                  Text("Sale Order" , style: Theme.of(context).textTheme.bodyText1 )
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text("Document", style: Theme.of(context).textTheme.bodyText2 ,)),
                    Text("Document" , style: Theme.of(context).textTheme.bodyText1 )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text("Sub Total(ex)", style: Theme.of(context).textTheme.bodyText2 ,)),
                    Text("100.00" , style: Theme.of(context).textTheme.bodyText1 )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text("GST", style: Theme.of(context).textTheme.bodyText2 ,)),
                    Text("10.00" , style: Theme.of(context).textTheme.bodyText1 )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text("Total(inc)", style: Theme.of(context).textTheme.bodyText2 ,)),
                    Text("110.00" , style: Theme.of(context).textTheme.bodyText1 )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text("Final Total", style: Theme.of(context).textTheme.headline2 ,)),
                    Text("110.00" , style: Theme.of(context).textTheme.headline2 )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: LoginButton(
                  title: Strings.save,
                  onPressed: (){


                    saveOrder(context,
                        widget.customerModel,
                        widget.termModel,
                        widget.remark1,
                        widget.remark2,
                        widget.remark3,
                        widget.remark4,
                        widget.itemModels
                    );

                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              )

            ],
          )
      )
    );

  }

}
