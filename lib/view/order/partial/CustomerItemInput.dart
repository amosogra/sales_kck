import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/widget/InputForm.dart';

// ignore: must_be_immutable
class CustomerItemInput extends StatefulWidget {

  TextEditingController controller; // = TextEditingController(text: 'admin!@#123');
  FocusNode focusNode;
  FocusNode nextFocusNode;
  String hint;
  Function(String?) onChange;
  //final focusEmail = FocusNode();
  CustomerItemInput({required this.controller, required this.focusNode, required this.nextFocusNode, required this.hint, required this.onChange});
  //const CustomerItemInput({Key? key}) : super(key: key);

  @override
  _CustomerItemInputState createState() => _CustomerItemInputState();
}

class _CustomerItemInputState extends State<CustomerItemInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          Container(
            margin: EdgeInsets.only(top: 5) ,
            child: Row(
              children: [
                Expanded(
                  child: InputForm(
                    validateFunction: (value){
                      Validations.validateEmpty(value!);
                    },
                    onChange: widget.onChange,
                    controller: widget.controller,
                    myHint: widget.hint,
                    myFocusNode: widget.focusNode,
                    nextFocusNode: widget.nextFocusNode,
                    secure: false,
                  )
                ) ,
                Icon(Icons.search, color: MyColors.greyColor,)
              ],
            ),
          ),
          Divider(color: MyColors.greyColor,),

        ],
      ),
    );
  }
}
