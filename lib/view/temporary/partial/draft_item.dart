
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';

class DraftItem extends StatefulWidget {

  TempDraftModel model;
  bool isTap;
  final void Function(dynamic) onTap;

  DraftItem({Key? key, required this.model , required this.onTap , required this.isTap }) : super(key: key);

  @override
  _DraftItemState createState() => _DraftItemState();
}

class _DraftItemState extends State<DraftItem> {


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
            widget.onTap(widget.model.id);
          },
          child: Container(
            color: widget.isTap ? Colors.grey : Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                child: Text('P'),
                foregroundColor: Colors.white,
              ),
              title: Text(widget.model.paymentAmount),
              subtitle: Text(widget.model.paymentMethod),
            ),
          ),
        )
    );


  }
}
