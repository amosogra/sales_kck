

import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("summary page"),
    );
  }
}
