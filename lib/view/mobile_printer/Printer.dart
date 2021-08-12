
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';

class Printer extends StatefulWidget {
  const Printer({Key? key}) : super(key: key);

  @override
  _PrinterState createState() => _PrinterState();
}

class _PrinterState extends State<Printer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.mobile_printer),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
        
      ) ,
    );
  }
}
