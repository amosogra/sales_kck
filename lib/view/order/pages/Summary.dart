

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/TermModel.dart';
import 'package:sales_kck/services/OrderService.dart';
import 'package:sales_kck/view/dialog/ConfirmDialog.dart';
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

  String getTotalPrice() {
    double total = 0;
    for(var i = 0;i < widget.itemModels.length; i++){
      total += double.parse(widget.itemModels[i].uom[0].price);
    }
    return total.toString();
  }

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
                    Text(getTotalPrice() , style: Theme.of(context).textTheme.bodyText1 )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text("GST", style: Theme.of(context).textTheme.bodyText2 ,)),
                    Text(getTotalPrice() , style: Theme.of(context).textTheme.bodyText1 )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text("Total(inc)", style: Theme.of(context).textTheme.bodyText2 ,)),
                    Text(getTotalPrice() , style: Theme.of(context).textTheme.bodyText1 )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text("Final Total", style: Theme.of(context).textTheme.headline2 ,)),
                    Text(getTotalPrice() , style: Theme.of(context).textTheme.headline2 )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    LoginButton(
                      title: Strings.save,
                      onPressed: () async{
                        bool flag = await saveOrder(context,
                            widget.customerModel,
                            widget.termModel,
                            widget.remark1,
                            widget.remark2,
                            widget.remark3,
                            widget.remark4,
                            widget.itemModels,
                          "save"
                        );

                        if(flag){
                          showDialog(context: context,
                              builder: (BuildContext context){
                                return ConfirmDialog(
                                    "Success",
                                        (){
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                );
                              }
                          );

                        }else{
                          showToastMessage(context, "Failed", "Ok");
                        }

                      },
                    ),
                    LoginButton(
                      title: Strings.draft,
                      onPressed: () async{

                        bool flag = await saveOrder(context,
                            widget.customerModel,
                            widget.termModel,
                            widget.remark1,
                            widget.remark2,
                            widget.remark3,
                            widget.remark4,
                            widget.itemModels,
                          "draft"
                        );

                        showDialog(context: context,
                            builder: (BuildContext context){
                              return ConfirmDialog(
                                  "Success",
                                      (){
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                              );
                            }
                        );

                      },
                    ),

                  ],
                )
              )

            ],
          )
      )
    );

  }

}
