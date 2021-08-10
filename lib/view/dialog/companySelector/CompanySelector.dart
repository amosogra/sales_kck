
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/strings.dart';

import 'CompanySelectorDialog.dart';


class CompanySelector extends StatefulWidget {

  final List<String> companies;
  CompanySelector(this.companies);
  //const CompanySelector({Key? key}) : super(key: key);

  @override
  _CompanySelectorState createState() => _CompanySelectorState();
}

class _CompanySelectorState extends State<CompanySelector> {

  String selectedCompany = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              String company  = await showDialog(context: this.context, builder: (BuildContext context){
                return new Dialog(
                  child: CompanySelectorDialog(
                    widget.companies , selectedCompany
                  )
                );
              });
              setState(() {
                selectedCompany = company;
              });
            },
            child: Text(Strings.confirm)
        ),

        Container(
          color: Colors.green,
          height: 2,
        ),


      ],
    );
  }


}
