import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/constants/colors.dart';

class EscPosPrinterPage extends StatefulWidget {
  const EscPosPrinterPage({Key? key}) : super(key: key);

  @override
  _EscPosPrinterPageState createState() => _EscPosPrinterPageState();
}

class _EscPosPrinterPageState extends State<EscPosPrinterPage> {

  String? ipAddress = "Not found Device";


  init () {
    const port = 9100;
    final stream = NetworkAnalyzer.discover2(
      '192.168.0',
      port,
      timeout: Duration(milliseconds: 5000),
    );

    int found = 0;
    stream.listen((NetworkAddress addr) {
      // print('${addr.ip}:$port');
      if (addr.exists) {
        found++;
        print('Found device: ${addr.ip}:$port');
        setState(() {
          ipAddress = addr.ip;
        });
      }
    }).onDone(() => print('Finish. Found $found device(s)'));

  }
  void testReceipt(NetworkPrinter printer) {
    printer.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: PosStyles(codeTable: 'CP1252'));
    printer.text('Special 2: blåbærgrød',
        styles: PosStyles(codeTable: 'CP1252'));

    printer.text('Bold text', styles: PosStyles(bold: true));
    printer.text('Reverse text', styles: PosStyles(reverse: true));
    printer.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    printer.text('Align left', styles: PosStyles(align: PosAlign.left));
    printer.text('Align center', styles: PosStyles(align: PosAlign.center));
    printer.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    printer.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    printer.feed(2);
    printer.cut();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text("ESC Printer"),
      ),

      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [

            Container(
              child: Text(ipAddress! , style: TextStyle(fontSize: 16), ),
            ),

            SizedBox(height: 50,),
            InkResponse(
              onTap: () async{
                const PaperSize paper = PaperSize.mm80;
                final profile = await CapabilityProfile.load();
                final printer = NetworkPrinter(paper, profile);
                final PosPrintResult res = await printer.connect( ipAddress, port: 9100);
                if (res == PosPrintResult.success) {
                  testReceipt(printer);
                  printer.disconnect();
                }else{
                  setState(() {
                    ipAddress = "pos printer error";
                  });
                }


              },
              child: Text("Print click here "  , style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }
}
