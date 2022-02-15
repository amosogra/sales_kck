
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';

class ConfirmDialog extends StatefulWidget {

  final String title;
  final VoidCallback clickSuccess;
  ConfirmDialog(this.title , this.clickSuccess );
  //const ConfirmDialog({Key? key}) : super(key: key);
  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();

}

class _ConfirmDialogState extends State<ConfirmDialog> {

  contentBox(context){
    return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black,offset: Offset(0,10),
                      blurRadius: 10
                  ),
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(widget.title , style: Theme.of(context).textTheme.bodyText2,),
                ),


                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: MyColors.primaryColor ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: MyColors.primaryColor ),
                          onPressed: widget.clickSuccess,
                          child: Text(" Yes "),
                        ),
                      )
                    ],
                  )

                )
              ],
            )
          )
        ]
    );
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );


    //
    // return Container(
    //   child: Container(
    //       // margin: EdgeInsets.only(top: 40, bottom: 50, left: 30, right: 30),
    //       color: MyColors.bgColor,
    //       child: Column(
    //         children: [
    //           Text(widget.title , style: Theme.of(context).textTheme.bodyText2,),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               ElevatedButton(
    //                 onPressed: (){
    //                   Navigator.pop(context);
    //                 },
    //                 child: Text("Cancel"),
    //               ),
    //
    //               Container(
    //                 margin: EdgeInsets.only(left: 20),
    //                 child: ElevatedButton(
    //                   onPressed: (){
    //                     Navigator.pop(context);
    //                   },
    //                   child: Text("Done"),
    //                 ),
    //               )
    //             ],
    //           )
    //
    //
    //         ],
    //       ),
    //   ),
    // );
  }
}
