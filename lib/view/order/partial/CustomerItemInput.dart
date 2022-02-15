import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/widget/InputForm.dart';

// ignore: must_be_immutable
class CustomerItemInput extends StatefulWidget {

  TextEditingController controller; // = TextEditingController(text: 'admin!@#123');
  FocusNode focusNode;
  FocusNode nextFocusNode;
  String hint;
  TextInputType textInputType;
  Function(String?) onChange;
  //final focusEmail = FocusNode();
  CustomerItemInput({ required this.controller, required this.focusNode, required this.nextFocusNode, required this.hint, required this.onChange
    , this.textInputType = TextInputType.text });
  //const CustomerItemInput({Key? key}) : super(key: key);

  @override
  _CustomerItemInputState createState() => _CustomerItemInputState();
}

class _CustomerItemInputState extends State<CustomerItemInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:5 , bottom: 0),
      padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color:MyColors.textBorderColor
        )
      ),
      child: Column(
        children: [
          Container(
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
                    textInputTye: widget.textInputType,
                    secure: false,
                  )
                ) ,
                Icon(Icons.description, color: MyColors.greyColor,)
              ],
            ),
          ),
          //Divider(color: MyColors.greyColor,),

        ],
      ),
    );
  }
}
