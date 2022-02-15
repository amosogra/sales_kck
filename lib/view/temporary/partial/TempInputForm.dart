import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/widget/InputForm.dart';

class TempInputForm extends StatefulWidget {

  final String title;
  final String hint;
  final FocusNode currentNode;
  final FocusNode nextFocusNode;
  final TextEditingController? controller;
  final bool enabled;
  final TextInputType textInputTye;
  TempInputForm(
      this.title ,
      this.hint ,
      this.currentNode,
      this.nextFocusNode,
      this.controller,
      this.enabled,
      this.textInputTye
      );

  //const TempInputForm({Key? key}) : super(key: key);

  @override
  _TempInputFormState createState() => _TempInputFormState();

}

class _TempInputFormState extends State<TempInputForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          InputForm(
              enabled: widget.enabled,
              textInputTye: widget.textInputTye,
              myFocusNode: widget.currentNode,
              nextFocusNode: widget.nextFocusNode,
              controller: widget.controller,
              myHint: widget.hint,
              validateFunction: (value){
                return Validations.validateEmpty(value!);
              },
            onChange: (value){},

          ),
          Divider(color: MyColors.greyColor,)
        ],
      ),
    );
  }
}
