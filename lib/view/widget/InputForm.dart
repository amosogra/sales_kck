import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_kck/constants/font_family.dart';

class InputForm extends StatefulWidget{

  final String? myHint;
  final FocusNode? myFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController? controller;
  final TextInputType textInputTye;
  final bool enabled;
  final bool secure;
  final String? Function(String?) validateFunction;
  void Function(String?) onChange;

  InputForm({Key? key,
    @required this.myHint,
    this.myFocusNode,
    this.nextFocusNode,
    this.controller ,
    this.secure = false ,
    this.enabled = true,
    this.textInputTye = TextInputType.text,
    required this.validateFunction,
    required this.onChange,
  }) : super(key : key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  @override
  Widget build(BuildContext context) {

    final inputDecoration =  InputDecoration(
        //icon: Icon(Icons.person),

        hintText: widget.myHint,
        hintStyle: TextStyle(fontSize: 14),
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
        isDense: true,
        //fillColor: MyColors.greenColor, filled: true
        //labelText: 'Name *',
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.cyan),
        // ),

        // focusedBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.red),
        // ),
    );

    return Container(

        child:TextFormField(
          enabled: widget.enabled,
          obscureText: widget.secure,
          focusNode: widget.myFocusNode,
          controller: widget.controller,
          keyboardType: widget.textInputTye,

          style: new TextStyle(
            fontFamily: FontFamily.verdana,
          ),
          decoration: inputDecoration,
          onSaved: (value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          onChanged: widget.onChange,
          onFieldSubmitted: (String value) {
            if(widget.myFocusNode != widget.nextFocusNode){
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            }else{
              FocusScope.of(context).requestFocus(FocusNode());
            }
          },
          validator: widget.validateFunction,
         //  validator: (value) {
         //    return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
         //  },
        )
    );
  }
}
