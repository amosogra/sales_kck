import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/app_storages.dart';
import 'package:sales_kck/view/main/HomePage.dart';
import 'package:sales_kck/view/user/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await checkLogin();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child:Image(
              width:  Device.get().isTablet ? 300 : 200,
              height: Device.get().isTablet ? 300 : 200,
              image: AssetImage(Assets.appLogo)
          )
      ),
    );
  }

  Future<void> checkLogin() async{

    var isLogin = await Storage.isLogin();
    if( isLogin != null && isLogin ){

      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => HomePage()
            ),
                (Route<dynamic> route) => false);
      });

    }else{

      Future.delayed(const Duration(milliseconds: 300),(){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()
        ), (Route<dynamic>route) => false);
      });
    }
  }
}
