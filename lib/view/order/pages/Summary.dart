import 'package:flutter/material.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/TermModel.dart';
import 'package:sales_kck/services/order_service.dart';
import 'package:sales_kck/view/dialog/ConfirmDialog.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';

class Summary extends StatefulWidget {

  CustomerModel customerModel;
  TermModel termModel;
  String remark1, remark2, remark3, remark4;
  List<ItemModel> itemModels = <ItemModel>[];

  Summary({
    Key? key ,
    required this.customerModel,
    required this.termModel,
    required this.remark1,
    required this.remark2,
    required this.remark3,
    required this.remark4,
    required this.itemModels
  }) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {

  String getTotalPrice() {
    double total = 0;
    for(var i = 0;i < widget.itemModels.length; i++){
      total += double.parse(widget.itemModels[i].uom[0].price) * widget.itemModels[i].qty ;
    }
    return total.toStringAsFixed(2);
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
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Selected Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              ),

              Container(
                child: renderItemLists(),
              ),

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
                          getTotalPrice(),
                          "save"
                        );

                        if(flag){
                          showDialog(context: context,
                              builder: (BuildContext context){
                                return ConfirmDialog(
                                    "Your order has been saved",
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
                         // showToastMessage(context, "Failed", "Ok");
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
                          getTotalPrice(),
                          "draft"
                        );

                        showDialog(context: context,
                            builder: (BuildContext context){
                              return ConfirmDialog(
                                  "Your order has been saved",
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



  Widget renderItemLists(){
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.itemModels.length,
          itemBuilder: (context, index){
            return _buildItem(widget.itemModels[index], index);
          },
        )
    );
  }


  Widget _buildItem(ItemModel item, int index) {
    return InkResponse(
      onTap: () async{

      },
      child: Container(
          padding: EdgeInsets.only(left: 0, top: 5, bottom: 0,  right: 0),
          alignment: Alignment.centerLeft,
          child: Container(
            child: Container(
                margin: EdgeInsets.all(0),
                child: Column(

                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.description,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.qty.toString() + "CTN * " +  double.parse(item.uom[0].price).toStringAsFixed(2),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),


                    Divider()

                  ],

                )
            ),
          )
      ),
    );
  }


}
