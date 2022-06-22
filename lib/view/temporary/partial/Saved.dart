import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftDBHelper.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftInvoiceDBHelper.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';
import 'package:sales_kck/services/temporary_receipt_service.dart';
import 'package:sales_kck/view/temporary/partial/Draft.dart';
import 'package:sales_kck/view/temporary/partial/draft_item.dart';
import 'package:sales_kck/view/temporary/temp_receipt_page.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  late final SlidableController slidableController;
  List<TempDraftModel> items = <TempDraftModel>[];
  late TempDraftModel selectedItem;
  String selectedId = "";
  int selectedIndex = -1;

  void loadItems() async {
    TempDraftDBHelper tempDraftDBHelper = new TempDraftDBHelper();
    List<TempDraftModel> response = await tempDraftDBHelper.retrieveOrdersBySaved("1");

    if (response.length > 0) {
      setState(() {
        items = response;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
        child: items.length == 0
            ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Image(
                      image: AssetImage(Assets.iconEdit),
                      width: 70,
                    ),
                    Text(Strings.not_add_order, style: TextStyle(color: MyColors.textBorderColor)),
                  ],
                ),
              )
            : Container(
                child: OrientationBuilder(
                  builder: (context, orientation) => _buildList(
                    context,
                    orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
                  ),
                ),
              ),
      ),
      bottomNavigationBar: selectedId.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: LoginButton(
                title: Strings.sync_item,
                onPressed: () async {
                  if (selectedId.isNotEmpty) {
                    String response = await saveTemporaryReceipt(context, items[selectedIndex], "save");

                    if (response == "true") {
                      showToastMessage(context, "Create new Temporary Receipt.", "Ok");
                      TempDraftDBHelper helper = new TempDraftDBHelper();
                      items[selectedIndex].isSaved = "2";
                      helper.updateTemp(items[selectedIndex]);
                      // TempDraftDBHelper tempDraftDBHelper = new TempDraftDBHelper();
                      // await tempDraftDBHelper.deleteTemp(items[selectedIndex].id);
                      setState(() {
                        selectedId = '';
                        items.removeAt(selectedIndex);
                      });
                      _showSnackBar(context, "Delete", selectedIndex);
                    } else {
                      showToastMessage(context, response, "Ok");
                    }
                    // TempDraftDBHelper helper = new TempDraftDBHelper();
                    // selectedItem.isSaved = "1";
                    // helper.updateTemp(selectedItem);
                  }
                },
              ),
            )
          : null,
    );
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      itemBuilder: (context, index) {
        final Axis slidableDirection = direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
        return _getSlidableWithLists(context, index, slidableDirection);
      },
      itemCount: items.length,
    );
  }

  Widget _getSlidableWithLists(BuildContext context, int index, Axis direction) {
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
              model: items[index],
              isTap: items[index].isTap,
              onTap: (id) {
                if (selectedIndex != -1) {
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
          onTap: () async {
            TempDraftDBHelper tempDraftDBHelper = new TempDraftDBHelper();
            await tempDraftDBHelper.deleteTemp(items[index].id);

            TempDraftInvoiceDBHelper draftInvoiceHelper = new TempDraftInvoiceDBHelper();
            var draftInvoices = await draftInvoiceHelper.retrieveTRInvoicesBySaved(items[index].id);
            int count = await draftInvoiceHelper.deleteTempInvoice(draftInvoices[0].trId);
            print("--------------------- count = $count deleted ----------------------");

            setState(() {
              items.removeAt(index);
            });
            _showSnackBar(context, "Delete", index);
          },
        ),
        IconSlideAction(
          caption: 'Edit',
          color: Colors.yellow,
          icon: Icons.edit_note,
          closeOnTap: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Receipt(
                  model: items[index],
                ),
              ),
            );
            _showSnackBar(context, "Edit", index);
          },
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String title, int index) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(title)));
  }
}
