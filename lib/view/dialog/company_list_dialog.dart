

import 'package:flutter/material.dart';
import 'package:sales_kck/model/post/company_model.dart';

class CompanyListDialog extends StatefulWidget {

  final List<CompanyModel> companyLists;
  final void Function(dynamic , dynamic , dynamic) clickSuccess;

  CompanyListDialog(this.companyLists, this.clickSuccess);
  @override
  _CompanyListDialogState createState() => _CompanyListDialogState();

}

class _CompanyListDialogState extends State<CompanyListDialog> {

  contentBox(context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.companyLists.length,
          itemBuilder: (context, index){
            return _buildItem(widget.companyLists[index], index);
          },
        ),


      ],
    );
  }


  Widget _buildItem( CompanyModel model, int index) {

    return InkResponse(
      onTap: () async{
        widget.clickSuccess(model.code, model.title, model.salesAgent);
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
                    model.title,
                    style: TextStyle(fontSize: 14),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );

  }
}
