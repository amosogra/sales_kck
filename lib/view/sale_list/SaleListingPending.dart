import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_kck/constants/DBHelper/ItemDBHelper.dart';
import 'package:sales_kck/constants/DBHelper/OrderDBHelper.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/view/order/pages/Customer.dart';
import 'partial/NoItem.dart';


class SaleListingPending extends StatefulWidget {

  const SaleListingPending({Key? key}) : super(key: key);
  @override
  _SaleListingPendingState createState() => _SaleListingPendingState();

}

class _SaleListingPendingState extends State<SaleListingPending> {

  late final SlidableController slidableController;
  List<SaleOrderModel> items = <SaleOrderModel>[];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void loadItems() async{

    //List<SaleOrderModel> response = await getSaleOrders(context);
    OrderDBHelper orderDBHelper = new OrderDBHelper();
    List<SaleOrderModel> response = await orderDBHelper.retrieveOrders() as List<SaleOrderModel>;

    if(response.length > 0){
      setState(() {
        items = response;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    loadItems();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

    });
  }
  Animation<double>? _rotationAnimation;
  Color _fabColor = Colors.blue;
  void handleSlideAnimationChanged(Animation<double>? slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool? isOpen) {
    setState(() {
      _fabColor = isOpen! ? Colors.green : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.sales_listing_pending_title),
      ),

      body: Container(
        alignment: Alignment.center,
        child: items.length == 0 ?
        showNoItem(context)
            :
        Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: Container(
            child: OrientationBuilder(
              builder: (context, orientation) => _buildList(
                  context,
                  orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal),
            ),
              // child: ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   itemCount: items.length,
              //   itemBuilder: (context, index){
              //     return _buildItem(items[index], index);
              //   },
              // )
          )
        )

      ),

    );
  }

  Widget _buildItem(SaleOrderModel item, int index) {

    return InkResponse(
      onTap: () async{

        Navigator.pop(context, item.toMap());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Customer(saleOrderModel: item,))
        );

      },
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
        //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 2,
                child: Container(
                  child: Text(
                    item.custName,
                    style: TextStyle(fontSize: 14),
                  ),
                )
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    item.companyCode,
                    style: TextStyle(fontSize: 12),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      itemBuilder: (context, index) {
        final Axis slidableDirection =
        direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
        return _getSlidableWithLists(context, index, slidableDirection);
        //return _getSlidableWithDelegates(context, index, slidableDirection);
      },
      itemCount: items.length,
    );
  }

  Widget _getSlidableWithLists( BuildContext context, int index, Axis direction) {
    final SaleOrderModel item = items[index];
    return Slidable(
      key: Key(item.docNo),
      controller: slidableController,
      direction: direction,

      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          debugPrint("dismiss called");
          setState(() {
            items.removeAt(index);
          });
        },
      ),

      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(items[index])
          : HorizontalListItem(items[index]),
      // actions: <Widget>[
      //   IconSlideAction(
      //     caption: 'Archive',
      //     color: Colors.blue,
      //     icon: Icons.archive,
      //     onTap: () => _showSnackBar(context, 'Archive'),
      //   ),
      //   IconSlideAction(
      //     caption: 'Share',
      //     color: Colors.indigo,
      //     icon: Icons.share,
      //     onTap: () => _showSnackBar(context, 'Share'),
      //   ),
      // ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: true,
          onTap: () => _showSnackBar(context, "Delete", index),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String title, int index) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(title)));

    setState(() {

      OrderDBHelper orderDBHelper = new OrderDBHelper();
      orderDBHelper.deleteOrder(items[index].soId);
      ItemDBHelper itemDBHelper = new ItemDBHelper();
      itemDBHelper.deleteByOrder(items[index].soId);
      items.removeAt(index);

    });
  }

}



class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);
  final SaleOrderModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 160.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              child: Text('${item.displayTerm}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.companyCode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item);
  final SaleOrderModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Slidable.of(context)?.renderingMode == SlidableRenderingMode.none ? Slidable.of(context)?.open() : Slidable.of(context)?.close()
      },
      child: InkResponse(
        onTap: (){
          debugPrint("render..");
          Navigator.pop(context, item.toMap());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Customer(saleOrderModel: item,))
          );
        },
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              child: Text('P'),
              foregroundColor: Colors.white,
            ),
            title: Text(item.custName),
            subtitle: Text(item.companyCode),
          ),
        ),
      )
    );
  }
}
