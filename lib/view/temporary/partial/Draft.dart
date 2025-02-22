/* import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_kck/constants/DBHelper/TempDraftDBHelper.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';
import 'package:sales_kck/view/temporary/partial/draft_item.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';

class Draft extends StatefulWidget {

  const Draft({Key? key}) : super(key: key);
  @override
  _DraftState createState() => _DraftState();
  
}

class _DraftState extends State<Draft> {

  late final SlidableController slidableController;
  List<TempDraftModel> items = <TempDraftModel>[];
  late TempDraftModel selectedItem ;
  String selectedId = "";
  int selectedIndex = -1;

  void loadItems() async{
    TempDraftDBHelper tempDraftDBHelper = new TempDraftDBHelper();
    List<TempDraftModel> response = await tempDraftDBHelper.retrieveOrdersBySaved("0") as List<TempDraftModel>;

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
          onPressed: (){
            if(selectedId.isNotEmpty){
              TempDraftDBHelper helper = new TempDraftDBHelper();
              selectedItem.isSaved = "1";
              helper.updateTemp(selectedItem);

              setState(() {
                items.removeAt(selectedIndex);

              });

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
                setState(() {
                  selectedItem = items[index];
                  selectedId = id.toString();
                  selectedIndex = index;
                  items[index].isTap = true;
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
          onTap: (){
            setState(() async {
              TempDraftDBHelper tempDraftDBHelper = new TempDraftDBHelper();
              await tempDraftDBHelper.deleteTemp(items[index].id);
              items.removeAt(index);
            });
            _showSnackBar(context, "Delete", index);
          }
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



class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);
  final TempDraftModel item;
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
              child: Text('${item.chequeNo}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.paymentMethod,
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
  final TempDraftModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
          Slidable.of(context)?.renderingMode == SlidableRenderingMode.none ? Slidable.of(context)?.open() : Slidable.of(context)?.close()
        },
        child: InkResponse(
          onTap: (){
            debugPrint("render..");
            //Navigator.pop(context, item.toMap());
          },
          child: Container(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                child: Text('P'),
                foregroundColor: Colors.white,
              ),
              title: Text(item.paymentAmount),
              subtitle: Text(item.paymentMethod),
            ),
          ),
        )
    );
  }
}



 */