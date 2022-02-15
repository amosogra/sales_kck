import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  Storage._();
  static SharedPreferences? localStorage;

  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  static savePassword(value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setString('password', value);
  }

  static getPassword() async {
    localStorage = await SharedPreferences.getInstance();
    String? stringValue = localStorage!.getString('password');
    return stringValue;
  }

  static saveUser(value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setString('user', value);
  }
  static getUser() async {
    localStorage = await SharedPreferences.getInstance();
    String? stringValue = localStorage!.getString('user');
    if(stringValue == null){
      return "";
    }
    return stringValue;
  }

  static Future<int> getUserId() async {
     String tmp = await Storage.getUser();
      if(tmp != null){
        return jsonDecode(tmp)['id'];
      }
      return 0;
  }
  static Future<String> getEmail() async {
    String tmp = await Storage.getUser();
    if(tmp != null){
      return jsonDecode(tmp)['email'].toString();
    }
    return "";
  }

  static setRemember(value) async {
    try{
      localStorage = await SharedPreferences.getInstance();
      localStorage!.setBool('remember', value);
    }catch(e){
    }
  }

  static isRemember() async {
    try{
      localStorage = await SharedPreferences.getInstance();
      bool? stringValue = localStorage!.getBool('remember');
      if(stringValue == null){
        return false;
      }
      return stringValue;
    }catch(e){
      return  false;
    }
  }

  static setLogin(value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setBool('isLogin', value);
  }

  static isLogin() async {
    try{
      localStorage = await SharedPreferences.getInstance();
      bool? stringValue = localStorage!.getBool('isLogin');
      return stringValue;
    }catch(e){
      return false;
    }
  }

  static setShowCompany(value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setBool('showCompany', value);
  }

  static getShowCompany() async {
    try{
      localStorage = await SharedPreferences.getInstance();
      bool? stringValue = localStorage!.getBool('showCompany');
      return stringValue == null ? false : stringValue;
    }catch(e){
      return false;
    }
  }



  static setCompany(value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setString('company', value);
  }

  static getCompany() async {
    localStorage = await SharedPreferences.getInstance();
    String? stringValue = localStorage!.getString('company');
    return stringValue;
  }


  static setSalesAgent(value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setString('salesagentcode', value);
  }

  static getSalesAgent() async {
    localStorage = await SharedPreferences.getInstance();
    String? stringValue = localStorage!.getString('salesagentcode');
    return stringValue;
  }

}