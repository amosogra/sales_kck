
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/dimens.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/main/partial/SlideMenu.dart';
import 'package:sales_kck/view/order/OrderFrame.dart';
import 'package:sales_kck/view/price_history/PriceHistory.dart';
import 'package:sales_kck/view/sale_list/SaleListingPending.dart';
import 'package:sales_kck/view/sale_list/SaleListingSynced.dart';

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
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_order, style: TextStyle(fontSize: 16,),),)
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
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_order, style: TextStyle(fontSize: 16,),),)
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
                                Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_order, style: TextStyle(fontSize: 16,),),)

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
                    child:Card(
                        child: Container(
                          alignment: Alignment.center,
                          height: Dimens.item_height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage(Assets.iconTemporaryRecipe) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                              Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_order, style: TextStyle(fontSize: 16,),),)
                            ],
                          ),
                        )
                    )
                ),

                Flexible(
                    child:Card(
                        child: Container(
                          alignment: Alignment.center,
                          height: Dimens.item_height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage(Assets.iconTemporaryRecipePending) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                              Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_order, style: TextStyle(fontSize: 16,),),)
                            ],
                          ),
                        )
                    )
                ),
              ],
            ),


            Row(
              children: [
                Flexible(
                    child:Card(
                        child: Container(
                          alignment: Alignment.center,
                          height: Dimens.item_height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage(Assets.iconTemporaryRecipeSync) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                              Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_order, style: TextStyle(fontSize: 16,),),)
                            ],
                          ),
                        )
                    )
                ),
                Flexible(
                    child:Card(
                        child: Container(
                          alignment: Alignment.center,
                          height: Dimens.item_height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage(Assets.iconMobilePrinter) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                              Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_order, style: TextStyle(fontSize: 16,),),)
                            ],
                          ),
                        )
                    )
                ),
              ],
            ),

            Row(
              children: [
                Flexible(
                    child:Card(
                        child: Container(
                          alignment: Alignment.center,
                          height: Dimens.item_height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage(Assets.iconSync) , width: Dimens.iconSize, height: Dimens.iconSize, ),
                              Container( margin: EdgeInsets.only(top: 10), child: Text(Strings.sales_order, style: TextStyle(fontSize: 16,),),)
                            ],
                          ),
                        )
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
