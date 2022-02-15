

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftDBHelper.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';
import 'package:sales_kck/services/temporary_receipt_service.dart';
import 'package:sales_kck/view/temporary/partial/Draft.dart';
import 'package:sales_kck/view/temporary/partial/draft_item.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';

class Saved extends StatefulWidget {

  const Saved({Key? key}) : super(key: key);
  @override
  _SavedState createState() => _SavedState();

}

class _SavedState extends State<Saved> {
  late final SlidableController slidableController;
  List<TempDraftModel> items = <TempDraftModel>[];
  late TempDraftModel selectedItem ;
  String selectedId = "";
  int selectedIndex = -1;

  void loadItems() async{
    TempDraftDBHelper tempDraftDBHelper = new TempDraftDBHelper();
    List<TempDraftModel> response = await tempDraftDBHelper.retrieveOrdersBySaved("1") as List<TempDraftModel>;

    if(response.length > 0){
      setState(() {
        items = [];
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

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      loadItems();
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
      body: Container(
          alignment: Alignment.center,
          child: items.length == 0?
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image(image: AssetImage(Assets.iconEdit) , width: 70,),
                Text(Strings.not_add_order, style:  TextStyle(color: MyColors.textBorderColor) ),
              ],
            ),
          )
              :
          Container(
            child: OrientationBuilder(
              builder: (context, orientation) => _buildList(
                  context,
                  orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal),
            ),

          )
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: LoginButton(
          title: Strings.add_item,
          onPressed: () async{
            if(selectedId.isNotEmpty){

              //await saveTemporaryReceipt(context, "customerModel", "receiveDate", "chequeDate", "save");

              // TempDraftDBHelper helper = new TempDraftDBHelper();
              // selectedItem.isSaved = "1";
              // helper.updateTemp(selectedItem);
            }
          },
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
      },
      itemCount: items.length,
    );
  }


  Widget _getSlidableWithLists( BuildContext context, int index, Axis direction) {
    final TempDraftModel item = items[index];
    return Slidable(
      key: Key(item.chequeNo),
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
          ? DraftItem(
        model: items[index] ,
        isTap: items[index].isTap,
        onTap: (id) {

          if(selectedIndex != -1){
            setState(() {
              items[selectedIndex].isTap = false;
            });
          }

          setState(() {
            selectedItem = items[index];
            selectedId = id.toString();
            items[index].isTap = true;
            selectedIndex = index;
          });
        },
      )
          : HorizontalListItem(items[index]),
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

    setState(() async {

      TempDraftDBHelper tempDraftDBHelper = new TempDraftDBHelper();
      await tempDraftDBHelper.deleteTemp(items[index].id);
      items.removeAt(index);

    });
  }

}
