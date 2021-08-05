

import 'package:flutter/material.dart';

class CompanySelectorDialog extends StatefulWidget {

  final List<String> companies;
  final String currentSelection;

  CompanySelectorDialog(this.companies, this.currentSelection);
  //const CompanySelectorDialog({Key? key}) : super(key: key);

  @override
  _CompanySelectorDialogState createState() => _CompanySelectorDialogState();
}

class _CompanySelectorDialogState extends State<CompanySelectorDialog> {

  String selectedCompany  = "";

  @override
  void initState(){
    selectedCompany = widget.currentSelection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints( maxHeight: 350, minHeight: 200),
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.companies.length,
              itemBuilder: (BuildContext context, int index){
                return CheckboxListTile(
                    value: selectedCompany == widget.companies[index] ? true : false,
                    onChanged: (bool? selected){
                       setState(() {
                         if(selected == true){
                           selectedCompany = widget.companies[index];
                         }else{
                           selectedCompany = "";
                         }
                       });
                    },
                    title: Text(widget.companies[index]),
                );
              }
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context, widget.currentSelection);
                },
                child: Text("Cancel"),
              ),

              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, selectedCompany);
                  },
                  child: Text("Done"),
              )
            ],
          )
        ],
      ),
    );
  }
}
