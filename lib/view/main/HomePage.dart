
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/dimens.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/main/partial/SlideMenu.dart';
import 'package:sales_kck/view/mobile_printer/Printer.dart';
import 'package:sales_kck/view/order/OrderFrame.dart';
import 'package:sales_kck/view/price_history/PriceHistory.dart';
import 'package:sales_kck/view/sale_list/SaleListingPending.dart';
import 'package:sales_kck/view/sale_list/SaleListingSynced.dart';
import 'package:sales_kck/view/sync/Sync.dart';
import 'package:sales_kck/view/temporary/Receipt.dart';
import 'package:sales_kck/view/temporary/ReceiptPending.dart';
import 'package:sales_kck/view/temporary/ReceiptSync.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(Strings.title), backgroundColor: MyColors.primaryColor,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                    child:InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => OrderFrame())
                        );
                      },
                      child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          height: Dimens.item_height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage(Assets.iconSalesOrder) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                              Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_order, style: TextStyle(fontSize: 16,),),)
                            ],
                          ),
                        ),
                      )
                    )
                ),


                Flexible(
                    child:InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SaleListingPending()));
                      },
                      child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimens.item_height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(Assets.iconSaleListingPending) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_listing_pending, style: TextStyle(fontSize: 16,),),)
                              ],
                            ),
                          )
                      ),
                    )
                ),
              ],
            ),

            Row(
              children: [
                Flexible(
                    child:InkWell(

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SaleListingSynced() ));
                      },

                      child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimens.item_height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(Assets.iconSaleListingSynced) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_list_synced, style: TextStyle(fontSize: 16,),),)
                              ],
                            ),
                          )
                      ),
                    )
                ),

                Flexible(
                    child:InkWell(
                      onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  PriceHistory() ));
                      },
                      child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimens.item_height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Image(image: AssetImage(Assets.iconPriceHistory) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.price_history, style: TextStyle(fontSize: 16,),),)

                              ],
                            ),
                          )
                      )

                    )
                ),
              ],
            ),

            Row(
              children: [
                Flexible(
                    child:InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Receipt() ));
                      },
                      child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimens.item_height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(Assets.iconTemporaryRecipe) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.temporary_receipt, style: TextStyle(fontSize: 16,),),)
                              ],
                            ),
                          )
                      ),
                    )
                ),

                Flexible(
                    child:InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ReceiptPending() ));
                      },
                      child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimens.item_height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(Assets.iconTemporaryRecipePending) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.temp_receipt_pending, style: TextStyle(fontSize: 16,),),)
                              ],
                            ),
                          )
                      ),
                    )
                ),
              ],
            ),


            Row(
              children: [
                Flexible(
                    child:InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ReceiptSync() ));
                      },
                      child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimens.item_height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(Assets.iconTemporaryRecipeSync) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.temp_receipt_synced, style: TextStyle(fontSize: 16,),),)
                              ],
                            ),
                          )
                      ),
                    )
                ),
                Flexible(
                    child:InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Printer() ));
                      },
                      child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimens.item_height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(Assets.iconMobilePrinter) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.mobile_printer, style: TextStyle(fontSize: 16,),),)
                              ],
                            ),
                          )
                      ),
                    )
                ),
              ],
            ),

            Row(
              children: [
                Flexible(
                    child:InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Sync() ));
                      },
                      child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimens.item_height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(Assets.iconSync) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sync, style: TextStyle(fontSize: 16,),),)
                              ],
                            ),
                          )
                      ),
                    )
                ),
                Flexible(
                  child: Text(""),
                ),
              ],
            ),

          ],
        ),
      ),
      drawer: showSlideMenu(context)
    );

  }
}
