
import 'package:flutter/material.dart';
import 'package:sales_kck/view/mobile_printer/blue_thermal_printer.dart';
import 'package:sales_kck/view/mobile_printer/bluetooth_print.dart';
import 'package:sales_kck/view/mobile_printer/bluetooth_thermal_printer.dart';
import 'package:sales_kck/view/mobile_printer/esc_pos_printer.dart';
import 'package:sales_kck/view/mobile_printer/flutter_sunmi_printer.dart';


class PrinterTestPage extends StatefulWidget {

  const PrinterTestPage({Key? key}) : super(key: key);

  @override
  _PrinterTestPageState createState() => _PrinterTestPageState();
}

class _PrinterTestPageState extends State<PrinterTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BluetoothPrint example app'),
      ),

      body: Column(
        children: [
          SizedBox(height: 30,),
          InkResponse(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BlueThermalPrinterPage() ));
              },
              child: Container( padding: EdgeInsets.all(10), child: Text("Printer 1 - Blue Thermal Printer", style: TextStyle(fontSize: 16),))
          ),

          InkResponse(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BluetoothThermalPrinterPage() ));
              },
              child: Container( padding: EdgeInsets.all(10), child: Text("Printer 2 - Bluetooth Thermal Printer", style: TextStyle(fontSize: 16),))
          ),

          InkResponse(
              onTap: () {
               // Navigator.push(context, MaterialPageRoute(builder: (context) => BluetoothPrintPage() ));
              },
              child: Container( padding: EdgeInsets.all(10), child: Text("Printer 3 Bluetooth Print", style: TextStyle(fontSize: 16),))
          ),

          InkResponse(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FlutterSunmiPrinterPage() ));

              },
              child: Container( padding: EdgeInsets.all(10), child: Text("Printer 4 Flutter Sunmi Printer", style: TextStyle(fontSize: 16),))
          ),

          InkResponse(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EscPosPrinterPage() ));

              },
              child: Container( padding: EdgeInsets.all(10), child: Text("Printer 5 - EscPosPrinterPage ", style: TextStyle(fontSize: 16),))
          ),




        ],
      ),
    );
  }
}
