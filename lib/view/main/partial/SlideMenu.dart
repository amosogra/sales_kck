import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/dimens.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/view/dialog/ConfirmDialog.dart';
import 'package:sales_kck/view/order/OrderFrame.dart';
import 'package:sales_kck/view/price_history/PriceHistory.dart';
import 'package:sales_kck/view/sale_list/SaleListingPending.dart';
import 'package:sales_kck/view/sale_list/SaleListingSynced.dart';
import 'package:sales_kck/view/sync/Sync.dart';
import 'package:sales_kck/view/temporary/Receipt.dart';
import 'package:sales_kck/view/temporary/ReceiptPending.dart';
import 'package:sales_kck/view/temporary/ReceiptSync.dart';
import 'package:sales_kck/view/user/LoginPage.dart';
import 'package:sales_kck/view/user/Profile.dart';

Widget showSlideMenu(BuildContext context){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 100,
          child: DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: MyColors.primaryColor
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text("KCK Menu", style: TextStyle(color: MyColors.whiteColor , fontSize: 16),),
              )
          ),
        ),

        ListTile(
          title: Container(
            child: Row(
              children: [
                Image(image: AssetImage(Assets.iconHome) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
                Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.home),)
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),


        ListTile(
          title: Container(
            child: Row(
              children: [
                Image(image: AssetImage(Assets.iconProfile) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
                Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.profile),)
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile() ));
          },
        ),



        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconSalesOrder) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.sales_order),)
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderFrame())
            );
            
          },
        ),

        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconSaleListingPending) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.sales_listing_pending_title),)
            ],
          ),
          onTap: () {
            Navigator.pop(context);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SaleListingPending())
            );
          },
        ),

        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconSaleListingSynced) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.sales_list_synced_title),)
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SaleListingSynced())
            );
          },
        ),

        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconPriceHistory) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.price_history),)
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PriceHistory())
            );

          },
        ),

        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconTemporaryRecipe) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.temporary_receipt),)
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Receipt())
            );
          },
        ),

        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconTemporaryRecipePending) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.temp_receipt_pending_title),)
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReceiptPending())
            );
          },
        ),

        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconTemporaryRecipeSync) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.temp_receipt_synced_title),)
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReceiptSync())
            );
          },
        ),

        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconTemporaryRecipeSync) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.mobile_printer),)
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReceiptSync())
            );
          },
        ),
        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconSync) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.sync),)
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Sync())
            );
          },
        ),
        ListTile(
          title: Row(
            children: [
              Image(image: AssetImage(Assets.iconLogout) , width: Dimens.menuIconSize, height: Dimens.menuIconSize,),
              Container( margin: EdgeInsets.only(left: 10), child: Text(Strings.logout),)
            ],
          ),

          onTap: () {
            Navigator.pop(context);
            showDialog(context: context,
                builder: (BuildContext context){
                  Storage.setLogin(false);
                  return ConfirmDialog(
                      "Are you sure to logout?",
                          (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()
                        ), (Route<dynamic>route) => false);
                      }
                  );
                }
            );
          },
        ),
      ],
    ),

  );

}