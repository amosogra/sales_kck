
import 'dart:async';
import 'dart:convert';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';

class Printer extends StatefulWidget {
  const Printer({Key? key}) : super(key: key);

  @override
  _PrinterState createState() => _PrinterState();
}

class _PrinterState extends State<Printer> {

  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String? _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;


  void initPrinter() {
    print('init printer');

    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen((event) {

      if (!mounted) return;
      setState(() => _devices = event);

      if (_devices.isEmpty)
        setState(() {
          _devicesMsg = 'No devices';
        });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // if (appData.isIOS) {
    //   initPrinter();
    // } else {
      bluetoothManager.state.listen((val) {
        print("state = $val");
        if (!mounted) return;
        if (val == 12) {
          print('on');
          initPrinter();
        } else if (val == 10) {
          print('off');
          setState(() {
            _devicesMsg = 'Please enable bluetooth to print';
          });
        }
        print('state is $val');
      });
    //}
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Printer page"),
        ),
        body: Container(
          child: _devices.isNotEmpty
              ? ListView.builder(
            itemBuilder: (context, position) => ListTile(
              onTap: () {
                //  _startPrint(_devices[position]);
              },
              leading: Icon(Icons.print),
              title: Text(_devices[position].name),
              subtitle: Text(_devices[position].address),
            ),
            itemCount: _devices.length,
          )
              : Center(
            child: Text(
              _devicesMsg ?? 'Ops something went wrong!',
              style: TextStyle(fontSize: 24),
            ),
          ),
        )
    );
  }


  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(Strings.mobile_printer),
  //       backgroundColor: MyColors.primaryColor,
  //     ),
  //     body: Container(
  //       child: StreamBuilder<List<BluetoothDevice>>(
  //         stream: bluetoothPrint.scanResults,
  //         initialData: [],
  //         builder: (c, snapshot) => Column(
  //           children: snapshot.data!.map((d) => ListTile(
  //             title: Text(d.name??''),
  //             subtitle: Text(d.address),
  //             onTap: () async {
  //               setState(() {
  //                 _device = d;
  //               });
  //             },
  //             trailing: _device != null && _device.address == d.address?Icon(
  //               Icons.check,
  //               color: Colors.green,
  //             ):null,
  //           )).toList(),
  //         ),
  //       ),
  //     ) ,
  //   );
  // }
}
