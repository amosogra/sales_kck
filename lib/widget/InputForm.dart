import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InputForm extends StatefulWidget {

  final String? myHint;
  final FocusNode? myFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController? controller;
  final TextInputType textInputTye;
  final bool secure;

  InputForm({required Key key,
    @required this.myHint,
    this.myFocusNode,
    this.nextFocusNode,
    this.controller ,
    this.secure = false ,
    this.textInputTye = TextInputType.text
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
        hintStyle: TextStyle(fontSize: 16),
        //labelText: 'Name *',
        enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.cyan),
        ),
        focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    );

    return Container(
        child:TextFormField(
          obscureText: widget.secure,
          focusNode: widget.myFocusNode,
          controller: widget.controller,
          keyboardType: widget.textInputTye,
          style: new TextStyle(
            fontFamily: 'Verdana'
          ),
          decoration: inputDecoration,
          onSaved: (value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          onFieldSubmitted: (String value) {
            FocusScope.of(context).requestFocus(widget.nextFocusNode);
          },

          validator: (value) {
            return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
          },
        )
    );
  }
}
