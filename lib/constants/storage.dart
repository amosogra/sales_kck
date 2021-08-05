import 'dart:convert';

import 'package:flutter/cupertino.dart';
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


  static saveSession(value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setString('session', value);
  }

  static getSession() async {
    localStorage = await SharedPreferences.getInstance();
    String? stringValue = localStorage!.getString('session');
    return stringValue;
  }

  static setRemember(value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setString('remember', value);
  }

  static isRemember() async {
    localStorage = await SharedPreferences.getInstance();
    bool? stringValue = localStorage!.getBool('remember');
    return stringValue;
  }

  static setLogin(value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setBool('isLogin', value);
  }

  static isLogin() async {
    localStorage = await SharedPreferences.getInstance();
    bool? stringValue = localStorage!.getBool('isLogin');
    return stringValue;
  }

}