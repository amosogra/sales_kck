import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/app_storages.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/dimens.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/model/post/company_model.dart';
import 'package:sales_kck/view/dialog/company_list_dialog.dart';
import 'package:sales_kck/view/main/partial/SlideMenu.dart';
import 'package:sales_kck/view/mobile_printer/PrinterTestPage.dart';
import 'package:sales_kck/view/order/pages/Customer.dart';
import 'package:sales_kck/view/price_history/price_history_page.dart';
import 'package:sales_kck/view/sale_list/SaleListingPending.dart';
import 'package:sales_kck/view/sale_list/sale_listing_synced.dart';
import 'package:sales_kck/view/sync/sync_page.dart';
import 'package:sales_kck/view/temporary/temp_receipt_page.dart';
import 'package:sales_kck/view/temporary/temp_receipt_pending_page.dart';
import 'package:sales_kck/view/temporary/ReceiptSync.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
  }

  initView() async {
    bool isShown = await Storage.getShowCompany();
    var data = await Storage.getUser();
    List<CompanyModel> models = [];

    debugPrint("${jsonDecode(data.toString())['user']['companies']}");
    jsonDecode(data.toString())['user']['companies'].forEach((item) {
      CompanyModel model = CompanyModel.fromJson(item);
      models.add(model);
    });

    //if(!isShown){
    showDialog(
        context: context,
        barrierDismissible: false,
        //barrierLabel: "Select Company",
        builder: (BuildContext context) {
          return CompanyListDialog(models, (val1, val2, salesAgent, model) {
            Storage.setShowCompany(true);
            Storage.setCompany(val1);
            Storage.setSalesAgent(salesAgent);
            Storage.setCompanyModel(model);
            Navigator.pop(context);
          });
        });
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.bgColor,
        appBar: AppBar(
          title: Text(Strings.title),
          backgroundColor: MyColors.primaryColor,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                      child: InkWell(
                          onTap: () {
                            SaleOrderModel saleOrderModel = initializeSaleOrder();
                            debugPrint("companyCode" + saleOrderModel.companyCode);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Customer(
                                          saleOrderModel: saleOrderModel,
                                        )));
                          },
                          child: Card(
                            child: Container(
                              alignment: Alignment.center,
                              height: Dimens.item_height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(Assets.iconSalesOrder),
                                    width: Dimens.iconSize,
                                    height: Dimens.iconSize,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(Strings.sales_order, style: Theme.of(context).textTheme.headline1),
                                  )
                                ],
                              ),
                            ),
                          ))),
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SaleListingPending()));
                    },
                    child: Card(
                        child: Container(
                      alignment: Alignment.center,
                      height: Dimens.item_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(Assets.iconSaleListingPending),
                            width: Dimens.iconSize,
                            height: Dimens.iconSize,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(Strings.sales_listing_pending, style: Theme.of(context).textTheme.headline1),
                          ),
                        ],
                      ),
                    )),
                  )),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SaleListingSynced()));
                    },
                    child: Card(
                        child: Container(
                      alignment: Alignment.center,
                      height: Dimens.item_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(Assets.iconSaleListingSynced),
                            width: Dimens.iconSize,
                            height: Dimens.iconSize,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(Strings.sales_list_synced, style: Theme.of(context).textTheme.headline1),
                          ),
                        ],
                      ),
                    )),
                  )),
                  Flexible(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PriceHistory()));
                          },
                          child: Card(
                              child: Container(
                            alignment: Alignment.center,
                            height: Dimens.item_height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(Assets.iconPriceHistory),
                                  width: Dimens.iconSize,
                                  height: Dimens.iconSize,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(Strings.price_history, style: Theme.of(context).textTheme.headline1),
                                ),
                              ],
                            ),
                          )))),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Receipt()));
                    },
                    child: Card(
                        child: Container(
                      alignment: Alignment.center,
                      height: Dimens.item_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(Assets.iconTemporaryRecipe),
                            width: Dimens.iconSize,
                            height: Dimens.iconSize,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(Strings.temporary_receipt, style: Theme.of(context).textTheme.headline1),
                          ),
                        ],
                      ),
                    )),
                  )),
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptPending()));
                    },
                    child: Card(
                        child: Container(
                      alignment: Alignment.center,
                      height: Dimens.item_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(Assets.iconTemporaryRecipePending),
                            width: Dimens.iconSize,
                            height: Dimens.iconSize,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(Strings.temp_receipt_pending, style: Theme.of(context).textTheme.headline1),
                          ),
                        ],
                      ),
                    )),
                  )),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptSync()));
                    },
                    child: Card(
                        child: Container(
                      alignment: Alignment.center,
                      height: Dimens.item_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(Assets.iconTemporaryRecipeSync),
                            width: Dimens.iconSize,
                            height: Dimens.iconSize,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(Strings.temp_receipt_synced, style: Theme.of(context).textTheme.headline1),
                          ),
                        ],
                      ),
                    )),
                  )),
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrinterTestPage()));
                    },
                    child: Card(
                        child: Container(
                      alignment: Alignment.center,
                      height: Dimens.item_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(Assets.iconMobilePrinter),
                            width: Dimens.iconSize,
                            height: Dimens.iconSize,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(Strings.mobile_printer, style: Theme.of(context).textTheme.headline1),
                          ),
                        ],
                      ),
                    )),
                  )),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Sync()));
                    },
                    child: Card(
                        child: Container(
                      alignment: Alignment.center,
                      height: Dimens.item_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(Assets.iconSync),
                            width: Dimens.iconSize,
                            height: Dimens.iconSize,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(Strings.sync, style: Theme.of(context).textTheme.headline1),
                          ),
                        ],
                      ),
                    )),
                  )),
                  Flexible(
                    child: Text(""),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: showSlideMenu(context));
  }
}
