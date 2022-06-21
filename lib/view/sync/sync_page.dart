
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/DBHelper/SyncTableDBHelper.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/model/post/TermModel.dart';
import 'package:sales_kck/model/post/outstanding_model.dart';
import 'package:sales_kck/model/post/sync_model.dart';
import 'package:sales_kck/model/post/tax_types_model.dart';
import 'package:sales_kck/services/CustomerService.dart';
import 'package:sales_kck/services/ItemService.dart';
import 'package:sales_kck/services/order_service.dart';
import 'package:sales_kck/services/TermService.dart';
import 'package:sales_kck/services/outstanding_ars_service.dart';
import 'package:sales_kck/services/tax_types_service.dart';
import 'package:intl/intl.dart';

class Sync extends StatefulWidget {
  const Sync({Key? key}) : super(key: key);

  @override
  _SyncState createState() => _SyncState();
}

class _SyncState extends State<Sync> {

  List<SyncModel> models = <SyncModel>[];
  bool isSync = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadItems();
  }

  void loadItems() async{
    SyncTableDBHelper helper = new SyncTableDBHelper();
    List<SyncModel> response = await helper.retrieveSyncs() as List<SyncModel>;

    if(response.length == 0){
      debugPrint("oks");
      List<SyncModel>  syncModels = [];
      SyncModel customerModel = SyncModel(title: "Customer", totalCount: "0", lastSyncedDate: "", slug: "customer");
      SyncModel productModel = SyncModel(title: "Products", totalCount: "0", lastSyncedDate: "", slug: "product");
      SyncModel termModel = SyncModel(title: "Terms", totalCount: "0", lastSyncedDate: "", slug: "term");
      SyncModel priceHistoryModel = SyncModel(title: "Price History", totalCount: "0", lastSyncedDate: "", slug: "pricehistory");
      SyncModel taxModel = SyncModel(title: "Tax Type", totalCount: "0", lastSyncedDate: "", slug: "tax");
      SyncModel invoiceModel = SyncModel(title: "Invoice", totalCount: "0", lastSyncedDate: "", slug: "invoice");

      syncModels.add(customerModel);
      syncModels.add(productModel);
      syncModels.add(termModel);
      syncModels.add(priceHistoryModel);
      syncModels.add(taxModel);
      syncModels..add(invoiceModel);
      helper.insertSyncs(syncModels);
      response = await helper.retrieveSyncs() as List<SyncModel>;
      setState(() {
        isSync = false;
      });

    }else{
      debugPrint("oks---");
      debugPrint(response.length.toString());
      if(response.length > 0){
        if(response[0].totalCount == "0"){
          setState(() {
            isSync = false;
          });
        }else{
          setState(() {
            isSync = true;
          });
        }
      }

    }

    setState(() {
      debugPrint(response[0].toMap().toString());
      models =  response;
    });
  }

  syncAll () async{

    List<CustomerModel> customerResponse = await getCustomers(context);
    List<ItemModel> productResponse = await getItems(context);
    List<TermModel> termResponse = await getTerms(context,"");
    List<SaleOrderModel> orderResponse = await getSaleOrders(context);
    List<TaxTypes> taxResponse = await getTaxTypes(context);
    List<OutstandingARS> invoiceResponse = await getOutstanding(context , "");

    setState(() {
      models[0].totalCount = customerResponse.length.toString();
      models[1].totalCount = productResponse.length.toString();
      models[2].totalCount = termResponse.length.toString();
      models[3].totalCount = orderResponse.length.toString();
      models[4].totalCount = taxResponse.length.toString();
      models[5].totalCount = invoiceResponse.length.toString();
    });

    save(customerResponse, 0);
    save(productResponse, 1);
    save(termResponse, 2);
    save(orderResponse, 3);
    save(taxResponse, 4);
    save(invoiceResponse, 5);
    
    //loadCustomers(0);
    // loadProduct(1);
    // loadTerm(2);
    //loadPriceHistory(3);
    // loadTax(4);
    // loadInvoice(5);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.sync),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25,right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Full Sync" , style: Theme.of(context).textTheme.headline2,),
                  ),

                  Switch(
                      value: isSync,
                      onChanged: (value){
                        debugPrint(value.toString());
                        setState(() {
                          isSync = value;
                        });
                        if(value){
                          syncAll();
                        }
                      }
                  )
                ],
              ),
            ),

            Container(
                margin: EdgeInsets.only(top:0),
                child:ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: models.length,
                  itemBuilder: (context, index){
                    return _buildItem(index);
                  },
                )
            )

          ],
        )
      ),
    );
  }

  String getDate(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
    // var date = new DateTime.now().toString();
    // var dateParse = DateTime.parse(date);
    // return "${dateParse.year}-${dateParse.month}-${dateParse.day}";
  }

  save(response, index){
    SyncTableDBHelper helper = new SyncTableDBHelper();
    SyncModel model = models[index];
    model.totalCount = response.length.toString();
    model.lastSyncedDate = getDate();
    debugPrint(model.slug);
    helper.updateSync(model);
  }

  void loadCustomers(index) async {
    List<CustomerModel> response = await getCustomers(context);
    setState(() {
      models[index].totalCount = response.length.toString();
    });
    save(response, index);

  }

  void loadProduct(index) async {
    List<ItemModel> response = await getItems(context);
    setState(() {
      models[index].totalCount = response.length.toString();
    });
    save(response, index);
  }

  void loadTerm(index) async {
    List<TermModel> response = await getTerms(context,"");
    setState(() {
      models[index].totalCount = response.length.toString();
    });
    save(response, index);
  }

  void loadPriceHistory(index) async {
    List<SaleOrderModel> response = await getSaleOrders(context);
    setState(() {
      models[index].totalCount = response.length.toString();
    });
    save(response, index);
  }

  void loadTax(index) async {
    List<TaxTypes> response = await getTaxTypes(context);
    setState(() {
      models[index].totalCount = response.length.toString();
    });
    save(response, index);
  }

  void loadInvoice(index) async {
    debugPrint("invocie");
    List<OutstandingARS> response = await getOutstanding(context , "");
    setState(() {
      models[index].totalCount = response.length.toString();
    });
    save(response, index);
  }

  Widget _buildItem(int index){

    return InkResponse(
      onTap: (){
      },

      child: Card(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.models[index].title , style: TextStyle(color: MyColors.textColor)),
                    Text("Total Count: " + this.models[index].totalCount.toString().replaceAll("null", "")  , style: TextStyle(color: MyColors.textColor)),
                    Text("Last Synced: " + this.models[index].lastSyncedDate.toString().replaceAll("null", "") , style: TextStyle(color: MyColors.textGreyColor),),
                  ],
                ),
              ),
              
              InkResponse(
                onTap: (){
                  var slug = this.models[index].slug;
                  debugPrint(slug);

                  if( slug == "customer"){
                    loadCustomers(index);
                  }else if(slug == "product"){
                    loadProduct(index);
                  }else if(slug == "term"){
                    loadTerm(index);
                  }else if(slug == "pricehistory"){
                    loadPriceHistory(index);
                  }else if(slug == "tax"){
                    loadTax(index);
                  }else if(slug == "invoice"){
                    loadInvoice(index);
                  }
                }, child: Icon(Icons.sync)
              )
            ],
          ),
        )
      ),
    );

  }
}


